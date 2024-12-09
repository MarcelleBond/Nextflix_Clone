// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Movie {
  final String id;
  final String name;
  final String? description;
  final String ageRestriction;
  final Duration durationMinutes;
  final String thumbnailImageId;
  final String genres;
  final String tags;
  final DateTime? netflixReleaseDate;
  final DateTime? releaseDate;
  final num trendingIndex;
  final bool isOriginal;
  final String cast;

  Movie({
    required this.id,
    required this.name,
    this.description,
    required this.ageRestriction,
    required this.durationMinutes,
    required this.thumbnailImageId,
    required this.genres,
    required this.tags,
    this.netflixReleaseDate,
    this.releaseDate,
    required this.trendingIndex,
    required this.isOriginal,
    required this.cast,
  });

  Movie copyWith({
    String? id,
    String? name,
    String? description,
    String? ageRestriction,
    Duration? durationMinutes,
    String? thumbnailImageId,
    String? genres,
    String? tags,
    DateTime? netflixReleaseDate,
    DateTime? releaseDate,
    num? trendingIndex,
    bool? isOriginal,
    String? cast,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ageRestriction: ageRestriction ?? this.ageRestriction,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      thumbnailImageId: thumbnailImageId ?? this.thumbnailImageId,
      genres: genres ?? this.genres,
      tags: tags ?? this.tags,
      netflixReleaseDate: netflixReleaseDate ?? this.netflixReleaseDate,
      releaseDate: releaseDate ?? this.releaseDate,
      trendingIndex: trendingIndex ?? this.trendingIndex,
      isOriginal: isOriginal ?? this.isOriginal,
      cast: cast ?? this.cast,
    );
  }

  bool isEmpty() {
    if (id.isEmpty || name.isEmpty) {
      return true;
    }

    return false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'ageRestriction': ageRestriction,
      'durationMinutes': durationMinutes,
      'thumbnailImageId': thumbnailImageId,
      'genres': genres,
      'tags': tags,
      'netflixReleaseDate': netflixReleaseDate?.millisecondsSinceEpoch,
      'releaseDate': releaseDate?.millisecondsSinceEpoch,
      'trendingIndex': trendingIndex,
      'isOriginal': isOriginal,
      'cast': cast,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as String,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      ageRestriction: map['ageRestriction'] as String,
      durationMinutes: Duration(minutes: map['durationMinutes']),
      thumbnailImageId: map['thumbnailImageId'] as String,
      genres: map['genres'] as String,
      tags: map['tags'] as String,
      netflixReleaseDate: map['netflixReleaseDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['netflixReleaseDate'] as int)
          : null,
      releaseDate: map['releaseDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['releaseDate'] as int)
          : null,
      trendingIndex: map['trendingIndex'] as num,
      isOriginal: map['isOriginal'] as bool,
      cast: map['cast'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Movie.empty() {
    return Movie(
      id: '',
      name: '',
      description: '',
      ageRestriction: '',
      durationMinutes: const Duration(minutes: -1),
      thumbnailImageId: '',
      genres: '',
      tags: '',
      trendingIndex: -1,
      isOriginal: false,
      cast: '',
    );
  }

  @override
  String toString() {
    return 'Movie(id: $id, name: $name, description: $description, ageRestriction: $ageRestriction, durationMinutes: $durationMinutes, thumbnailImageId: $thumbnailImageId, genres: $genres, tags: $tags, netflixReleaseDate: $netflixReleaseDate, releaseDate: $releaseDate, trendingIndex: $trendingIndex, isOriginal: $isOriginal, cast: $cast)';
  }

  @override
  bool operator ==(covariant Movie other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.ageRestriction == ageRestriction &&
        other.durationMinutes == durationMinutes &&
        other.thumbnailImageId == thumbnailImageId &&
        other.genres == genres &&
        other.tags == tags &&
        other.netflixReleaseDate == netflixReleaseDate &&
        other.releaseDate == releaseDate &&
        other.trendingIndex == trendingIndex &&
        other.isOriginal == isOriginal &&
        other.cast == cast;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        ageRestriction.hashCode ^
        durationMinutes.hashCode ^
        thumbnailImageId.hashCode ^
        genres.hashCode ^
        tags.hashCode ^
        netflixReleaseDate.hashCode ^
        releaseDate.hashCode ^
        trendingIndex.hashCode ^
        isOriginal.hashCode ^
        cast.hashCode;
  }
}