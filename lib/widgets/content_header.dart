import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../extensions/build_context_extension.dart';
import '../models/movie.dart';
import '../providers/movie.dart';
import 'widgets.dart';

class ContentHeader extends StatelessWidget {
  final Movie feature;
  const ContentHeader({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.read<MovieProvider>();
    return FutureBuilder(
        future: movieProvider.imageFor(feature),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(snapshot.data!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 500,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black,
                    Colors.transparent,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
              ),
              Positioned(
                bottom: 110,
                child: Text(
                  movieProvider.featured!.name,
                  style: context.textTheme.displayMedium,
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    VerticalIconButton(
                      icon: Icons.add,
                      title: "List",
                      onTap: () => print("add to my list"),
                    ),
                    _PlayButton(),
                    VerticalIconButton(
                      icon: Icons.info_outline,
                      title: "Info",
                      onTap: () => print("Info"),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => print("Play movie"),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(15, 5, 20, 5),
      ),
      icon: const Icon(
        Icons.play_arrow,
        size: 30,
      ),
      label: const Text(
        "Play",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }
}
