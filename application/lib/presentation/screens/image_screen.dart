import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatelessWidget {
  final List<String> imageUrls;

  const ImageScreen({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: imageUrls.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.dialog(
                  Stack(
                    children: [
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withOpacity(0.5), // Adjust the opacity of the background
                          ),
                        ),
                      ),
                      // Dialog content
                      Center(
                        child: Dialog(
                          child: TapRegion(
                            onTapOutside: (event){
                              Get.back();
                            },
                            child: PhotoView(
                              imageProvider: CachedNetworkImageProvider(
                                imageUrls[index]
                              ),
                              tightMode: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: CachedNetworkImage( // Use CachedNetworkImage to load and cache network images
                imageUrl: imageUrls[index],
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()), // Placeholder widget while image is loading
                errorWidget: (context, url, error) => const Icon(Icons.error), // Widget to display if image fails to load
                fit: BoxFit.cover, // BoxFit.cover to maintain aspect ratio and fill the space
              ),
            );
          },
        ),
      ),
    );
  }
}
