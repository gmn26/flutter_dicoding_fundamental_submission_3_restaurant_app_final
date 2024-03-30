import 'package:dicoding_fundamental_submission_3_restaurant_app_final/data/db/database_helper.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/data/model/restaurant_favorite_db.dart';
import 'package:get/get.dart';

class FavoriteRestaurantListController extends GetxController {
  var favoriteRestaurants = <FavoriteRestaurant>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;

  Future<void> fetchRestaurants() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final results = await DatabaseHelper().getFavorite();
      favoriteRestaurants.assignAll(results);
      // if (favoriteRestaurants) {
      // } else {
      //   hasError.value = true;
      // }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFavorite(String id) async {
    isLoading.value = true;
    hasError.value = false;

    try {
      await DatabaseHelper().deleteFavorite(id);
      final results = await DatabaseHelper().getFavorite();
      favoriteRestaurants.assignAll(results);
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
