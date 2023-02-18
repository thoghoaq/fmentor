import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyBanner extends StatefulWidget {
  @override
  State<MyBanner> createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {
  final List<String> imageUrls = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        itemCount: imageUrls.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            imageUrls[index],
            fit: BoxFit.cover,
          );
        },
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }
}
