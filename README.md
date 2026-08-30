📚 Bookly

A modern Flutter book discovery application that started as a simple course project and was expanded into a more complete, real-world application.

The original version focused on browsing books and viewing book details. I then extended the project with authentication, search, favorites, notifications, profile management, theme customization, Firebase integration, and a feature-based architecture.

Note: Bookly is a portfolio/learning project. It is designed to demonstrate practical Flutter, Firebase, API integration, state management, and software architecture skills.

✨ Features

🔐 Authentication

Sign up with name, email, and password

Mandatory email verification

Login validation based on email verification status

Password reset

Change email with re-authentication and email verification

Change password with re-authentication

Secure logout

🔍 Book Search

Search books using the Google Books API

Search by book title or author

Reuses the same book presentation flow as the Home screen

Handles API errors and missing API configuration

❤️ Favorites

Add/remove books from favorites

Favorites are stored per authenticated user in Cloud Firestore

Favorite state can be restored when the user signs in again

Batch deletion of favorites when an account is deleted

🔔 Notifications

Firebase Cloud Messaging (FCM)

Local notifications using flutter_local_notifications

Foreground notification handling

Background notification handling

Notification tap handling

Deep-linking from a notification directly to the related Book Details screen

FCM token storage and refresh synchronization

Read/unread notification state

Mark one or all notifications as read

Delete individual notifications

Notification enable/disable setting

👤 Profile Management

View user profile

Edit profile information

Profile image selection

Delete account with password re-authentication

Removes related Firestore data such as:

Profile

Favorites

Notifications

🌗 Theme Management

Light theme

Dark theme

System theme

Theme preference persisted locally using SharedPreferences

🎨 UI & UX

Custom reusable widgets

Google Fonts

Font Awesome icons

Liquid Glass visual effects

Animated UI elements

Loading and error states

Responsive scrolling layouts

🏗️ Architecture

The project follows a feature-based architecture with Clean Architecture principles, separating UI/state-management responsibilities from data access and external services.

The current structure is intentionally pragmatic for a Flutter application:

lib/
├── core/
│   ├── errors/
│   ├── services/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── about/
│   ├── auth/
│   ├── favorites/
│   ├── home/
│   ├── main/
│   ├── notifications/
│   ├── profile/
│   ├── search/
│   ├── settings/
│   └── splash/
│
├── firebase_options.dart
└── main.dart

Most features are organized into layers such as:

feature/
├── data/
│   ├── models/
│   └── repos/
│
└── presentation/
    ├── manager/
    ├── views/
    └── widgets/

Core responsibilities

Data layer: API/Firebase communication, models, and repository implementations

Presentation layer: Cubits, screens, and reusable widgets

Core layer: shared services, routing, themes, errors, utilities, and dependency injection

State Management

The project uses Cubit/BLoC for state management.

Examples include:

AuthCubit

FavoriteCubit

SearchCubit

NotificationCubit

NotificationSettingsCubit

ThemeCubit

ProfileCubit

ChangeEmailCubit

ChangePasswordCubit

DeleteAccountCubit

Dependency Injection

GetIt is used as a service locator for shared dependencies such as:

ApiService

Firebase Auth

Cloud Firestore

Repositories

NotificationService

SharedPreferences

This keeps dependency creation centralized and makes repositories/Cubits easier to work with and test.

🔄 Notification Flow

One of the project's main custom features is opening a specific book when the user taps a notification.

The flow is approximately:

FCM Message
     │
     ├── Foreground
     │      ↓
     │  Local Notification
     │
     └── Background / Terminated
            ↓
       FCM / Background Handler
            ↓
       Notification Tap
            ↓
       Extract bookId
            ↓
       AppRouter
            ↓
       Book Details

The notification payload contains the related bookId, which is used to navigate directly to the corresponding book.

🛠️ Tech Stack

Technology

Purpose

Flutter / Dart

Application development

Firebase Authentication

User authentication

Cloud Firestore

User data, favorites, and notifications

Firebase Cloud Messaging

Push notifications

flutter_local_notifications

Local/foreground notifications

Google Books API

Book data and search

Dio

HTTP client

flutter_bloc / Cubit

State management

GetIt

Dependency injection / service locator

SharedPreferences

Local persistence

GoRouter

Navigation and routing

Dartz

Either-based error handling

Google Fonts

Typography

Font Awesome

Icons

Liquid Glass Renderer

Visual effects

Image Picker

Profile image selection

📁 Project Structure

A simplified view of the project:

lib/
├── core/
│   ├── errors/
│   ├── services/
│   │   ├── api_service.dart
│   │   └── notification_service.dart
│   ├── theme/
│   └── utils/
│       ├── app_router.dart
│       ├── service_locator.dart
│       ├── validators.dart
│       └── widgets/
│
├── features/
│   ├── auth/
│   ├── favorites/
│   ├── home/
│   ├── notifications/
│   ├── profile/
│   ├── search/
│   ├── settings/
│   └── splash/
│
└── main.dart

🚀 Getting Started

Prerequisites

Make sure you have:

Flutter SDK compatible with Dart 3.11.0 or newer

Android Studio / Xcode depending on the target platform

A Firebase project

A Google Books API key

Check your Flutter installation:

flutter doctor

1. Clone the repository

git clone <YOUR_GITHUB_REPOSITORY_URL>
cd Bookly_App-main

2. Install dependencies

flutter pub get

3. Configure Google Books API

Create a .env file in the project root based on .env.example:

GOOGLE_BOOKS_API_KEY=YOUR_API_KEY_HERE

The application reads the API key using flutter_dotenv.

Do not commit your real .env file or private credentials to source control.

4. Configure Firebase

Create/configure a Firebase project and enable:

Firebase Authentication

Cloud Firestore

Firebase Cloud Messaging

For Authentication, enable:

Email/Password sign-in

Then configure Firebase for your Flutter platforms using the FlutterFire CLI:

dart pub global activate flutterfire_cli
flutterfire configure

This generates/updates the Firebase configuration for the selected platforms.

Firebase setup may also require platform-specific configuration in Android Studio/Xcode, especially for push notifications on iOS.

5. Run the application

flutter run

To run on a specific device:

flutter devices
flutter run -d <device-id>

🔥 Firestore Data Model

User-related data is organized under the authenticated user's UID.

A simplified structure is:

users/
└── {userId}/
    ├── profile fields
    ├── notificationsEnabled
    ├── fcmToken
    │
    ├── favorites/
    │   └── {bookId}
    │
    └── notifications/
        └── {notificationId}

This keeps favorites and notifications scoped to the authenticated user.

When an account is deleted, the application also removes the user's related Firestore documents before deleting the Firebase Authentication account.

🌐 API

Book data is provided by the Google Books API.

The application uses it for:

Featured books

Newest books

Similar books

Individual book details

Search

The API is accessed through a reusable ApiService built on top of Dio.

📱 Screens

The application currently includes:

Splash

Login

Register

Forgot Password

Home

Search

Book Details

Favorites

Notifications

Profile

Edit Profile

Settings

Change Email

Change Password

Delete Account

About

Screenshots

Screenshots can be added here to showcase the main user flows:

docs/
└── screenshots/
    ├── home.png
    ├── search.png
    ├── book_details.png
    ├── favorites.png
    ├── notifications.png
    └── profile.png

🎥 Demo

Add the application demo video here:

Demo: <(https://drive.google.com/file/d/1wEvK_4dVgjYo7SRLeb0oBiaZbaN2dNbT/view?usp=drive_link)>

🧠 What I Learned

This project went beyond implementing UI screens from a course and gave me practical experience with:

Structuring a multi-feature Flutter application

Repository-based data access

Cubit/BLoC state management

Firebase Authentication flows

Re-authentication for sensitive account operations

Cloud Firestore data modeling

REST API integration with Dio

Error handling with Either

Push and local notification handling

Notification-to-screen navigation

Dependency injection with GetIt

Local persistence with SharedPreferences

Theme persistence and system theme support

Reusable Flutter widgets

Separating presentation logic from data access

Most importantly, the project helped me practice taking an existing learning project and extending it independently instead of stopping at the course requirements.

📚 Resources

Flutter Documentation

Firebase for Flutter

Firebase Authentication

Cloud Firestore

Firebase Cloud Messaging

Google Books APIs

Dio

flutter_bloc

GetIt

GoRouter

👩‍💻 Author

Basmala Ahmed

Flutter Developer

📄 License

This project was created for learning and portfolio purposes.
