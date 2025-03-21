import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // INITIALIZATION
  Future<void> initNotification() async {
    if (_isInitialized) return; // If already initialized, return

    // PREPARE ANDROID NOTIFICATION SETTINGS
    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

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
  }

  // NOTIFICATION DETAIL SETUP
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel_id',
          'Daily Notifications',
          channelDescription: 'Daily Notification Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());
  }

  // SHOW NOTIFICATION

  // ON NOTIFICATION TAPPED
}
