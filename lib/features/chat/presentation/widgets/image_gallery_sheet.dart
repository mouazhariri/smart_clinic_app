import 'package:flutter/material.dart';

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: const TextStyle(color: Colors.white),
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
                  color: Colors.white,
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