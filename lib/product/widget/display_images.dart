import 'package:flutter/material.dart';

class DisplayImages extends StatefulWidget {
  const DisplayImages({super.key, required this.images});
  final List<String> images;

  @override
  State<DisplayImages> createState() => _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages> {
  int current = 0;

  // Logic to prevent index errors if the list is empty
  void swipeLeft() {
    if (widget.images.isEmpty) return;
    setState(() {
      current = (current - 1 + widget.images.length) % widget.images.length;
    });
  }

  void swipeRight() {
    if (widget.images.isEmpty) return;
    setState(() {
      current = (current + 1) % widget.images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    // FALLBACK: If images list is empty or the current string is empty
    if (widget.images.isEmpty || widget.images[current].isEmpty) {
      return _buildPlaceholder();
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // THE PRODUCT IMAGE (From Internet/Strapi)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.images[current],
                width: 311,
                height: 414,
                fit: BoxFit.cover,
                // This prevents the "Map/String" or "404" errors from crashing the UI
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    width: 311,
                    height: 414,
                    child: Center(child: CircularProgressIndicator(color: Colors.black)),
                  );
                },
              ),
            ),

            // NAVIGATION ARROWS (From Local Assets)
            if (widget.images.length > 1) ...[
              Positioned(
                left: -5,
                child: IconButton(
                  onPressed: swipeLeft,
                  icon: Image.asset(
                    'assets/images/Left_arrow.png', // Ensure this exists in pubspec.yaml
                    width: 60,
                  ),
                ),
              ),
              Positioned(
                right: -5,
                child: IconButton(
                  onPressed: swipeRight,
                  icon: Image.asset(
                    'assets/images/Right_arrow.png', // Ensure this exists in pubspec.yaml
                    width: 60,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // A simple placeholder widget to show when an image fails to load
  Widget _buildPlaceholder() {
    return Container(
      width: 311,
      height: 414,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
          SizedBox(height: 10),
          Text("No Image Available", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}