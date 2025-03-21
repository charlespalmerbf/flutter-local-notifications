import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // INITIALIZATION
  Future<void> initNotification() async {
    if (_isInitialized) return; // If already initialized, return

    // Request permissions for Android 13+
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // PREPARE ANDROID NOTIFICATION SETTINGS
    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');  // Ensure this icon exists

    // PREPARE IOS NOTIFICATION SETTINGS
    const initSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

    // PREPARE INITIALIZATION SETTINGS
    const initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIOS);

    // INITIALIZE NOTIFICATION PLUGIN
    await notificationsPlugin.initialize(initSettings);

    // CREATE NOTIFICATION CHANNEL FOR ANDROID
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'daily_channel_id', // Channel ID
      'Daily Notifications', // Channel Name
      description: 'This channel is used for daily notifications',
      importance: Importance.max,
    );

    // CREATE THE CHANNEL (Needed for Android 8.0+)
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _isInitialized = true; // Mark as initialized
  }

  // NOTIFICATION DETAIL SETUP
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel_id', // Use the same channel ID
          'Daily Notifications',
          channelDescription: 'Daily Notification Channel',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails());
  }

  // SHOW NOTIFICATION
  Future<void> showNotification({int id = 0, String? title, String? body}) async {
    if (!_isInitialized) {
      await initNotification(); // Ensure initialized before showing notification
    }

    return notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}
