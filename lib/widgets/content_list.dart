import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/movie.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Movie> contentList;
  final bool isOriginal;
  const ContentList({
    super.key,
    required this.title,
    required this.contentList,
    this.isOriginal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: isOriginal ? 500 : 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              itemCount: contentList.length,
              itemBuilder: (context, index) {
                final content = contentList[index];
                return GestureDetector(
                  key: PageStorageKey(content.id),
                  onTap: () => print(content.name),
                  child: _poster(context, content),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  FutureBuilder<Uint8List> _poster(BuildContext context, Movie content) {
    return FutureBuilder(
        future: context.read<MovieProvider>().imageFor(content),
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
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: isOriginal ? 400 : 200,
            width: isOriginal ? 200 : 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(snapshot.data!),
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }
}
