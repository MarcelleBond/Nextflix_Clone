import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';

import '../apis/client.dart';
import '../constants/appwrite_config.dart';
import '../models/movie.dart';

class WhatchlistProvider extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  Future<User> get user async {
    return await ApiClient.account.get();
  }

  Future<List<Movie>> list() async {
    final user = await this.user;

    final watchlist = await ApiClient.databases.listDocuments(
        collectionId: AppwriteConfig.watchlistsCollectionId,
        databaseId: AppwriteConfig.databaseId,
        queries: [
          Query.equal("userId", [user.$id])
        ]);

    final movieIds = watchlist.documents
        .map((document) => document.data["movieId"])
        .toList();
    final entries = (await ApiClient.databases.listDocuments(
            collectionId: AppwriteConfig.moviesCollectionId,
            databaseId: AppwriteConfig.databaseId))
        .documents
        .map((document) => Movie.fromMap(document.data))
        .toList();
    final filtered =
        entries.where((movie) => movieIds.contains(movie.id)).toList();

    _movies = filtered;

    notifyListeners();

    return _movies;
  }

  Future<void> add(Movie movie) async {
    final user = await this.user;

    var result = await ApiClient.databases.createDocument(
        collectionId: AppwriteConfig.watchlistsCollectionId,
        databaseId: AppwriteConfig.databaseId,
        documentId: 'unique()',
        data: {
          "userId": user.$id,
          "movieId": movie.id,
          "createdAt": (DateTime.now().second / 1000).round()
        });

    _movies.add(Movie.fromMap(result.data));

    list();
  }

  Future<void> remove(Movie movie) async {
    final user = await this.user;

    final result = await ApiClient.databases.listDocuments(
        collectionId: AppwriteConfig.watchlistsCollectionId,
        databaseId: AppwriteConfig.databaseId,
        queries: [
          Query.equal("userId", user.$id),
          Query.equal("movieId", movie.id)
        ]);

    final id = result.documents.first.$id;

    await ApiClient.databases.deleteDocument(
      collectionId: AppwriteConfig.watchlistsCollectionId,
      documentId: id,
      databaseId: AppwriteConfig.databaseId,
    );

    list();
  }

  Future<Uint8List> imageFor(Movie movie) async {
    return await ApiClient.storage.getFileView(fileId: movie.thumbnailImageId, bucketId: AppwriteConfig.bucketId);
  }

  bool isOnList(Movie movie) => _movies.any((e) => e.id == movie.id);
}
