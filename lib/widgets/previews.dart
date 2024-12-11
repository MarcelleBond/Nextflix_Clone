import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/movie.dart';

class Previews extends StatelessWidget {
  const Previews({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = context.read<MovieProvider>().movies;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Previews",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 165,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 8.0,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                key: PageStorageKey(movie.id),
                onTap: () => print(movie.name),
                child: _renderStack(context, movie),
              );
            },
          ),
        )
      ],
    );
  }

  FutureBuilder<Uint8List> _renderStack(BuildContext context, Movie movie) {
    return FutureBuilder(
      future: context.read<MovieProvider>().imageFor(movie),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 130,
            width: 130,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: MemoryImage(snapshot.data!), fit: BoxFit.cover),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withAlpha(40),
                  width: 4.0,
                ),
              ),
            ),
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.black87, Colors.black45, Colors.transparent],
                  stops: [0, 0.25, 1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withAlpha(40),
                  width: 4.0,
                ),
              ),
            ),
            // TODO change out text title for image title
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                height: 60,
                child: Text(
                  movie.name.length > 14
                      ? movie.name.substring(0, 14)
                      : movie.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
