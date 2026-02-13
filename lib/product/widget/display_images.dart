import 'package:flutter/material.dart';

class DisplayImages extends StatefulWidget {
  final List<String> display_image;

  const DisplayImages({super.key, required this.display_image});

  @override
  State<DisplayImages> createState() => _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages> {
  // 1. Controller to handle the sliding logic
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.display_image.isEmpty) {
      return const Center(child: Text('No images available'));
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // 2. Use PageView instead of ListView for "snapping" effect
        SizedBox(
          height: 414,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.display_image.length,
            itemBuilder: (context, index) {
              final imageUrl = widget.display_image[index];
              final imageProvider = imageUrl.startsWith('http')
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            },
          ),
        ),

        // 3. Left Arrow
        Positioned(
          left: 5,
          child: _buildArrowButton(
            icon: Icons.arrow_back_ios_new,
            onPressed: _prevPage,
          ),
        ),

        // 4. Right Arrow
        Positioned(
          right: 5,
          child: _buildArrowButton(
            icon: Icons.arrow_forward_ios,
            onPressed: _nextPage,
          ),
        ),
      ],
    );
  }

  // Helper widget for the circular buttons
  Widget _buildArrowButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5), // Semi-transparent background
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
