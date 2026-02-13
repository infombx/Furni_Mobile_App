// ...existing code...
import 'dart:async';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int currentPage = 0;

  final List<String> images = [
    'assets/images/pic1.png',
    'assets/images/pic2.png',
    'assets/images/pic3.png',
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || images.isEmpty) return;
      currentPage = (currentPage + 1) % images.length;
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = 16.0;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxWidth = (screenWidth - horizontalPadding * 2).clamp(
      0.0,
      800.0,
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            width: maxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black12,
            ),
            clipBehavior: Clip.hardEdge,
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) => setState(() => currentPage = index),
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Dots indicator
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(images.length, (index) {
              final bool active = index == currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active ? Colors.black87 : Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
// ...existing code...
