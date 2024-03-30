import 'package:dicoding_fundamental_submission_3_restaurant_app_final/data/db/database_helper.dart';
import 'package:dicoding_fundamental_submission_3_restaurant_app_final/data/model/restaurant_favorite_db.dart';
import 'package:flutter/material.dart';

class ListFavoriteButton extends StatefulWidget {
  const ListFavoriteButton({
    super.key,
    required this.restaurantId,
    required this.addToFav,
  });

  final String restaurantId;
  final FavoriteRestaurant addToFav;

  @override
  State<ListFavoriteButton> createState() => _ListFavoriteButtonState();
}

class _ListFavoriteButtonState extends State<ListFavoriteButton> {
  Future<void> onPressedFunction(String id, FavoriteRestaurant items) async {
    final favStatus = await DatabaseHelper().checkFavorite(id);
    favStatus
        ? DatabaseHelper().deleteFavorite(id)
        : DatabaseHelper().addFavorite(items);
  }

  Future<Color> colorCheck(String id) async {
    final favStatus = await DatabaseHelper().checkFavorite(id);
    return favStatus ? Colors.red : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color>(
      future: colorCheck(widget.restaurantId),
      builder: (context, snapshot) {
        final color = snapshot.data ?? Colors.grey;
        return IconButton(
          onPressed: () async {
            await onPressedFunction(widget.restaurantId, widget.addToFav);
            setState(() {});
          },
          icon: Icon(
            Icons.favorite,
            color: color,
          ),
        );
      },
    );
  }
}
