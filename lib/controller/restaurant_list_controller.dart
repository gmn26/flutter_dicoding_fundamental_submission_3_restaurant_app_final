import 'dart:convert';

import 'package:dicoding_fundamental_submission_3_restaurant_app_final/data/model/restaurant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RestaurantListController extends GetxController {
  final RxList<RestaurantElement> restaurantsList = RxList<RestaurantElement>();
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  List<RxBool> isFav = List.filled(20, false.obs);

  Future<void> fetchRestaurants() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final response =
          await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

      if (response.statusCode == 200) {
        final restaurantJson = jsonDecode(response.body);
        final Restaurant restaurant = Restaurant.fromJson(restaurantJson);
        restaurantsList.assignAll(restaurant.restaurants);
      } else {
        hasError.value = true;
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchRestaurants();
    super.onInit();
  }
}
