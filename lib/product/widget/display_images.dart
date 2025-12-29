import 'package:flutter/material.dart';

class DisplayImages extends StatelessWidget {
  final List<String> display_image; // required parameter

  const DisplayImages({super.key, required this.display_image});

  @override
  Widget build(BuildContext context) {
    if (display_image.isEmpty) {
      return const Center(child: Text('No images available'));
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: display_image.length,
      itemBuilder: (context, index) {
        final imageUrl = display_image[index];

        // Automatically choose between NetworkImage and AssetImage
        final imageProvider = imageUrl.startsWith('http')
            ? NetworkImage(imageUrl)
            : AssetImage(imageUrl) as ImageProvider;

        return Container(
          margin: const EdgeInsets.only(right: 10),
          width: 311, // you can adjust
          height: 414, // you can adjust
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
