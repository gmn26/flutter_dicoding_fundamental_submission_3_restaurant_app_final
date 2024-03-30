import 'package:dicoding_fundamental_submission_3_restaurant_app_final/component/list_favorite_button.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/component/navigation.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/component/restaurant_star_rate.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/controller/restaurant_list_controller.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/data/model/restaurant_favorite_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(RestaurantListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.hasError.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 60,
                  color: Colors.red,
                ),
                SizedBox(height: 20),
                Text(
                  'No Internet Connection',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Please check your internet connection and try again.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.restaurantsList.length,
            itemBuilder: (context, index) {
              var restaurant = controller.restaurantsList[index];
              FavoriteRestaurant addToFav = FavoriteRestaurant(
                id: restaurant.id,
                name: restaurant.name,
                description: restaurant.description,
                pictureId: restaurant.pictureId,
                city: restaurant.city,
                rating: restaurant.rating,
              );
              return Material(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      '/detail',
                      arguments: restaurant.id,
                    );
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    leading: Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(restaurant.name),
                            RatingStars(counter: restaurant.rating.floor()),
                          ],
                        ),
                        ListFavoriteButton(
                          restaurantId: restaurant.id,
                          addToFav: addToFav,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: const NavBottom(navIndex: 0),
    );
  }
}
