import 'package:flutter/material.dart';
import 'package:flutter_local_notification/noti_service.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // INITIALIZING NOTIFICATION SERVICE
  NotiService().initNotification();

  runApp(
    // Providing NotiService to the entire app
    Provider<NotiService>(
      create: (_) => NotiService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
