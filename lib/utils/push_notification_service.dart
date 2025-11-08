import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dollar_kursi/firebase_options.dart';

/// 🔔 Сервис для работы с Firebase Cloud Messaging
class PushNotificationService {
  // ---- Singleton ----
  static final PushNotificationService _instance =
      PushNotificationService._internal();
  factory PushNotificationService() => _instance;
  PushNotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// 🚀 Основная инициализация Firebase и уведомлений
  Future<void> init() async {
    // 🔐 Запрашиваем разрешения (особенно важно для iOS и Android 13+)
    await _requestPermissions();

    // ⚙️ Настройка локальных уведомлений (Android + iOS)
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _localNotifications.initialize(initSettings);

    // 💬 Для iOS: показывать уведомления в foreground
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 🧠 Подключаем обработчики
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // 🚀 Проверяем, было ли приложение открыто через пуш при старте
    await _checkInitialMessage();

    // 🔥 Токен устройства
    await getDeviceToken();

    // ♻️ Слушаем обновления токена
    listenTokenRefresh();

    debugPrint('✅ PushNotificationService инициализирован');
  }

  // ---------------------------------------------------------------------------
  // 📦 --- Получение токена устройства ---
  Future<String?> getDeviceToken() async {
    // final localDatasource = AuthLocaleDataSourceImpl();
    // Wait for iOS registration
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken == null) {
        debugPrint('⚠️ APNs token not yet available. Waiting...');
        // small delay to give iOS time
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    final token = await _firebaseMessaging.getToken();
    debugPrint('🔥 FCM токен устройства: $token');
    if (token != null) {
      // localDatasource.setString(Keys.fcmToken, token);
    }
    return token;
  }

  // ---------------------------------------------------------------------------
  // 🔄 --- Обновление токена ---
  void listenTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      debugPrint('♻️ Обновлён FCM токен: $newToken');
      // 👉 можно обновить токен на сервере
    });
  }

  // ---------------------------------------------------------------------------
  // 📩 --- Фоновая обработка ---
  @pragma('vm:entry-point')
  static Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('🔔 Получено уведомление в фоне: ${message.messageId}');
  }

  // ---------------------------------------------------------------------------
  // 📬 --- Уведомление в активном приложении ---
  Future<void> _onMessage(RemoteMessage message) async {
    debugPrint('📩 Получено сообщение: ${message.notification?.title}');
    final notification = message.notification;

    if (notification != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel',
            'Уведомления',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // 📲 --- Клик по уведомлению ---
  void _onMessageOpenedApp(RemoteMessage message) {
    debugPrint('📲 Пользователь открыл уведомление: ${message.data}');
    // 👉 Здесь можно вызвать навигацию через navigatorKey
  }

  // ---------------------------------------------------------------------------
  // 🚀 --- Проверка initial message (если приложение открыто через пуш) ---
  Future<void> _checkInitialMessage() async {
    final message = await _firebaseMessaging.getInitialMessage();
    if (message != null) {
      debugPrint('🚀 Приложение открыто через пуш: ${message.data}');
      // 👉 можно сразу навигировать на нужный экран
    }
  }

  // ---------------------------------------------------------------------------
  // 🔐 --- Запрос разрешений ---
  Future<void> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint('🔐 Статус разрешений: ${settings.authorizationStatus}');
  }

  // ---------------------------------------------------------------------------
  // 📡 --- Подписка и отписка от топиков ---
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('📡 Подписан на топик: $topic');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('🚫 Отписан от топика: $topic');
  }
}
