import 'package:flutter/material.dart';

import '../constants/assets.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffSet;
  const CustomAppBar({super.key, this.scrollOffSet = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
      color: Colors.black.withOpacity(
        (scrollOffSet / 350).clamp(0, 1).toDouble(),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Image.asset(Assets.imagesNetflixLogo0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _AppBarButton(
                    title: "TV Shows",
                    onTap: () => print("TV Shows"),
                  ),
                  _AppBarButton(
                    title: "Movies",
                    onTap: () => print("Movies"),
                  ),
                  _AppBarButton(
                    title: "My List",
                    onTap: () => print("My List"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  const _AppBarButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
