import 'package:bookly_app/features/notifications/data/repos/notification_repo.dart';
import 'package:bookly_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final localNotifications = FlutterLocalNotificationsPlugin();

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

  const initializationSettings = InitializationSettings(
    android: androidSettings,
  );

  await localNotifications.initialize(settings: initializationSettings);

  const channel = AndroidNotificationChannel(
    'bookly_notifications',
    'Bookly_notifications',
    description: 'Notifications from Bookly',
    importance: Importance.high,
  );

  final androidPlugin = localNotifications
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  await androidPlugin?.createNotificationChannel(channel);

  final title =
      message.data['title'] ?? message.notification?.title ?? 'Bookly';

  final body = message.data['body'] ?? message.notification?.body ?? '';
  
  final notificationId = message.messageId?.hashCode.abs() ?? (DateTime.now().millisecondsSinceEpoch % 100000);

  await localNotifications.show(
    id: notificationId % 2147483647,
    title: title,
    body: body,
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        'bookly_notifications',
        'Bookly_notifications',
        channelDescription: 'Notifications from Bookly',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
  );

  print('🔥 Background notification shown');
}

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final NotificationRepo notificationRepo;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  int _notificationId = 0;

  NotificationService(this.notificationRepo);

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'bookly_notifications',
    'Bookly_notifications',
    description: 'Notifications from Bookly',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _requestPermission();
    await _initializeLocalNotifications();

    listenToTokenRefresh();
    listenToForegroundMessages();

    print('FCM initialized successfully');
  }

  void listenToTokenRefresh() {
    _messaging.onTokenRefresh.listen((token) async {
      try {
        await notificationRepo.saveFcmToken(token);
      } catch (e) {
        print('Failed to update FCM token : $e');
      }
    });
  }

  Future<void> syncFcmToken() async {
    final token = await _messaging.getToken();

    if (token != null) {
      await notificationRepo.saveFcmToken(token);
    }
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permission status : ${settings.authorizationStatus}');
  }

  void listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🔥 onMessage listener triggered');
      final notification = message.notification;

      if (notification != null) {
        _showLocalNotification(
          title: notification.title ?? '',
          body: notification.body ?? '',
        );
      }
    });
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    final initialized = await _localNotifications.initialize(
      settings: initializationSettings,
    );

    print('Local Notifications Initialized : $initialized');

    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    print('androidPlugin is null : ${androidPlugin == null}');

    await androidPlugin?.createNotificationChannel(_channel);

    print('createNotificationChannel called');
  }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
  }) async {
    await _localNotifications.show(
      id: _notificationId++,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}
