import 'package:dicoding_fundamental_submission_3_restaurant_app_final/component/navigation.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/data/api/api_service.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitched = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Setting",
                style: TextStyle(fontSize: 36),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Restaurant Notification"),
                      Text("Enable Notification"),
                    ],
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                  IconButton(
                    onPressed: () async {
                      final restaurant = await ApiService().allResto();
                      await NotificationHelper().showNotification(
                        flutterLocalNotificationsPlugin,
                        restaurant,
                      );
                    },
                    icon: Icon(Icons.notifications_active),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBottom(navIndex: 2),
    );
  }
}
