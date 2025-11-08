import 'dart:async';
import 'package:dollar_kursi/di/di.dart';
import 'package:dollar_kursi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _sl = GetIt.instance;

  static const _prefKey = 'notifications_enabled';

  /// 🚀 Основная инициализация Firebase и уведомлений
  Future<void> init() async {
    await _requestPermissions();
    await _initLocalNotifications();

    // Читаем состояние пользователя из SharedPreferences
    final prefs = _sl<SharedPreferences>();
    final enabled = prefs.getBool(_prefKey) ?? true;

    if (enabled) {
      await _ensureNotificationsActive();
    } else {
      debugPrint('🔕 Пользователь ранее отключил уведомления');
    }

    // 💬 Разрешить отображение уведомлений при активном приложении (iOS)
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 🧠 Обработчики сообщений
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // 🚀 Проверяем, было ли приложение открыто через пуш при старте
    await _checkInitialMessage();

    // ♻️ Следим за обновлением токена
    listenTokenRefresh();

    debugPrint('✅ PushNotificationService инициализирован');
  }

  // ---------------------------------------------------------------------------
  // 📩 --- Получение и обновление токена ---
  // Future<String?> getDeviceToken() async {
  //   if (defaultTargetPlatform == TargetPlatform.iOS) {
  //     final apnsToken = await _firebaseMessaging.getAPNSToken();
  //     if (apnsToken == null) {
  //       await Future.delayed(const Duration(seconds: 2));
  //     }
  //   }

  //   final token = await _firebaseMessaging.getToken();
  //   debugPrint('🔥 Токен устройства: $token');
  //   return token;
  // }

  void listenTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      debugPrint('♻️ Обновлён FCM-токен: $newToken');
      // тут можно обновить токен на сервере
    });
  }

  // ---------------------------------------------------------------------------
  // 🔔 --- Включение уведомлений ---
  Future<void> enableNotifications({bool save = true}) async {
    try {
      final prefs = _sl<SharedPreferences>();
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        final token = await _firebaseMessaging.getToken();
        await _firebaseMessaging.subscribeToTopic('ADS');
        debugPrint('✅ Уведомления включены, токен: $token');
        if (token != null) {
          await sl<SharedPreferences>().setString("fcm_token", token);
        }
        if (save) prefs.setBool(_prefKey, true);
      } else {
        debugPrint('⚠️ Пользователь не дал разрешение на уведомления');
      }
    } catch (e) {
      debugPrint('Ошибка при включении уведомлений: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // 🔕 --- Отключение уведомлений ---
  Future<void> disableNotifications({bool save = true}) async {
    try {
      final prefs = _sl<SharedPreferences>();
      debugPrint('🔕 Отключаем уведомления...');
      await _firebaseMessaging.unsubscribeFromTopic('ADS');
      await _firebaseMessaging.deleteToken();
      if (save) prefs.setBool(_prefKey, false);
      debugPrint('🚫 Уведомления отключены');
    } catch (e) {
      debugPrint('Ошибка при отключении уведомлений: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // 🔄 --- Активация при старте (если включено в настройках) ---
  Future<void> _ensureNotificationsActive() async {
    final token = await _firebaseMessaging.getToken();
    if (token == null) {
      await enableNotifications(save: false);
    } else {
      await _firebaseMessaging.subscribeToTopic('ADS');
      debugPrint('📡 Уведомления активны, токен: $token');
      await sl<SharedPreferences>().setString("fcm_token", token);
    }
  }

  // ---------------------------------------------------------------------------
  // 📬 --- Сообщения ---
  @pragma('vm:entry-point')
  static Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('🔔 Уведомление в фоне: ${message.messageId}');
  }

  Future<void> _onMessage(RemoteMessage message) async {
    debugPrint('📩 Входящее сообщение: ${message.notification?.title}');
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

  void _onMessageOpenedApp(RemoteMessage message) {
    debugPrint('📲 Пользователь открыл уведомление: ${message.data}');
  }

  Future<void> _checkInitialMessage() async {
    final message = await _firebaseMessaging.getInitialMessage();
    if (message != null) {
      debugPrint('🚀 Приложение открыто через пуш: ${message.data}');
    }
  }

  // ---------------------------------------------------------------------------
  // ⚙️ --- Локальные уведомления и разрешения ---
  Future<void> _initLocalNotifications() async {
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
  }

  Future<void> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint('🔐 Статус разрешений: ${settings.authorizationStatus}');
  }
}
