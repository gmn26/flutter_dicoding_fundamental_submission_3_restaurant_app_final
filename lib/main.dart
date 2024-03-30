import 'package:dicoding_fundamental_submission_3_restaurant_app_final/ui/detail_restaurant_page.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/ui/favorite_page.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/ui/home_page.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/ui/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/favorite-restaurant',
          page: () => FavoritePage(),
        ),
        GetPage(
          name: '/setting',
          page: () => SettingPage(),
        ),
        GetPage(
          name: '/detail',
          page: () => const RestaurantDetailPage(),
        ),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
