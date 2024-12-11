import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../apis/client.dart';
import '../constants/appwrite_config.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  final Logger _logger = Logger();
  final Map<String, Uint8List> _imageCache = {};
  Movie? _selected;
  Movie _featured = Movie.empty();
  List<Movie> _movies = [];

  Movie? get selected => _selected;
  Movie? get featured => _featured;
  List<Movie> get movies => _movies;
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
    try {
      var result = await ApiClient.databases.listDocuments(
          collectionId: AppwriteConfig.moviesCollectionId,
          databaseId: AppwriteConfig.databaseId,
          queries: [
            Query.orderDesc('videoUrl'),
          ]);

      _movies = result.documents
          .map((document) => Movie.fromMap(document.data))
          .toList();
      _featured = _movies.isEmpty
          ? Movie.empty()
          : _movies.firstWhere((x) => x.name == "Sintel",
              orElse: () => Movie.empty());

      await imageFor(_featured);
      notifyListeners();
    } on Exception catch (e) {
      _logger.e(e);
    }
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
