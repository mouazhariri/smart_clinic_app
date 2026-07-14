import 'package:flutter/material.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';

class ImageGallerySheet extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImageGallerySheet({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  State<ImageGallerySheet> createState() => _ImageGallerySheetState();
}

class _ImageGallerySheetState extends State<ImageGallerySheet> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: const TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemCount: widget.images.length,
        itemBuilder: (_, i) {
          return InteractiveViewer(
            child: Center(
              child: Image.network(
                widget.images[i],
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  color: AppColors.white,
                  size: 64,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
