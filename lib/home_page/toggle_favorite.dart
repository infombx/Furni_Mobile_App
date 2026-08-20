import 'package:flutter/material.dart';

class FavoriteToggleButton extends StatefulWidget {
  const FavoriteToggleButton({super.key});

  @override
  State<FavoriteToggleButton> createState() => _FavoriteToggleButtonState();
}

class _FavoriteToggleButtonState extends State<FavoriteToggleButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite
            ? Colors.red
            : const Color.fromARGB(255, 131, 129, 129),
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite; // toggle state
        });
      },
    );
  }
}
