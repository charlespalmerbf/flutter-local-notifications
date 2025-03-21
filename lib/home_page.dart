import 'package:flutter/material.dart';
import 'package:flutter_local_notification/noti_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the NotiService instance provided by the context
    final notiService = Provider.of<NotiService>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Send Notification"),
          onPressed: () {
            notiService.showNotification(
              title: "Hello",
              body: "This is a notification",
            );
          },
        ),
      ),
    );
  }
}