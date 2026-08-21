import 'package:bookly_app/core/utils/api_service.dart';
import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:bookly_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:bookly_app/features/favorites/data/repos/favorite_repo_impl.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/features/notifications/data/repos/notification_repo.dart';
import 'package:bookly_app/features/notifications/data/repos/notification_repo_impl.dart';
import 'package:bookly_app/features/profile/data/repos/profile_repo.dart';
import 'package:bookly_app/features/profile/data/repos/profile_repo_impl.dart';
import 'package:bookly_app/features/search/data/repos/search_repo.dart';
import 'package:bookly_app/features/search/data/repos/search_repo_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(getIt<ApiService>()));

  getIt.registerSingleton<SearchRepo>(SearchRepoImpl(getIt<ApiService>()));

  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  getIt.registerSingleton<FavoriteRepo>(
    FavoriteRepoImpl(
      firestore: getIt<FirebaseFirestore>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerSingleton<ProfileRepo>(
    ProfileRepoImpl(firestore: getIt<FirebaseFirestore>()),
  );

  getIt.registerSingleton<NotificationRepo>(
    NotificationRepoImpl(
      firestore: getIt<FirebaseFirestore>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      profileRepo: getIt<ProfileRepo>(),
      auth: getIt<FirebaseAuth>(),
      prefs: getIt<SharedPreferences>(),
      favoriteRepo: getIt<FavoriteRepo>(),
    ),
  );
}
