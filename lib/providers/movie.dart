import 'dart:math';

import 'package:flutter/foundation.dart';

import '../apis/client.dart';
import '../constants/appwrite_config.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  final Map<String, Uint8List> _imageCache = {};
  Movie? _selected;
  Movie _featured = Movie.empty();
  List<Movie> _movies = [];

  Movie? get selected => _selected;
  Movie? get featured => _featured;
  List<Movie> get entries => _movies;
  List<Movie> get originals =>
      _movies.where((e) => e.isOriginal == true).toList();
  List<Movie> get animations => _movies
      .where(
        (e) => e.genres.toLowerCase().contains('animation'),
      )
      .toList();
  List<Movie> get newReleases => _movies
      .where(
        (e) =>
            e.releaseDate != null &&
            e.releaseDate!.isAfter(DateTime.parse('2018-01-01')),
      )
      .toList();

  List<Movie> get trending {
    var trending = _movies;

    trending.sort((a, b) => b.trendingIndex.compareTo(a.trendingIndex));

    return trending;
  }

  void setSelected(Movie movie) {
    _selected = movie;

    notifyListeners();
  }

  Future<void> list() async {
    var result = await ApiClient.databases.listDocuments(
        collectionId: AppwriteConfig.moviesCollectionId,
        databaseId: AppwriteConfig.moviesCollectionId);

    _movies = result.documents
        .map((document) => Movie.fromMap(document.data))
        .toList();
    var rng = Random();
    _featured =
        _movies.isEmpty ? Movie.empty() : _movies[rng.nextInt(_movies.length)];

    notifyListeners();
  }

  Future<Uint8List> imageFor(Movie movie) async {
    if (_imageCache.containsKey(movie.thumbnailImageId)) {
      return _imageCache[movie.thumbnailImageId]!;
    }

    final result = await ApiClient.storage.getFileView(
      fileId: movie.thumbnailImageId,
      bucketId: AppwriteConfig.bucketId,
    );

    _imageCache[movie.thumbnailImageId] = result;

    return result;
  }
}
