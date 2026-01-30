class MovieDetails {
  bool adult;
  String? backdropPath;
  int id;
  String? imdbId;
  int budget;
  List<Genre> genres;
  String? homepage;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String? tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  dynamic belongsToCollection; // can be null or Map

  MovieDetails({
    required this.adult,
    this.backdropPath,
    required this.id,
    this.imdbId,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.belongsToCollection,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
    adult: json['adult'] ?? false,
    backdropPath: json['backdrop_path'],
    id: json['id'],
    imdbId: json['imdb_id'],
    budget: json['budget'] ?? 0,
    genres: (json['genres'] as List<dynamic>? ?? []).map((e) => Genre.fromJson(e)).toList(),
    homepage: json['homepage'],
    originalLanguage: json['original_language'] ?? '',
    originalTitle: json['original_title'] ?? '',
    overview: json['overview'] ?? '',
    popularity: (json['popularity'] ?? 0).toDouble(),
    posterPath: json['poster_path'],
    productionCompanies: (json['production_companies'] as List<dynamic>? ?? [])
        .map((e) => ProductionCompany.fromJson(e))
        .toList(),
    productionCountries: (json['production_countries'] as List<dynamic>? ?? [])
        .map((e) => ProductionCountry.fromJson(e))
        .toList(),
    releaseDate: json['release_date'] ?? '',
    revenue: json['revenue'] ?? 0,
    runtime: json['runtime'] ?? 0,
    spokenLanguages: (json['spoken_languages'] as List<dynamic>? ?? []).map((e) => SpokenLanguage.fromJson(e)).toList(),
    status: json['status'] ?? '',
    tagline: json['tagline'],
    title: json['title'] ?? '',
    video: json['video'] ?? false,
    voteAverage: (json['vote_average'] ?? 0).toDouble(),
    voteCount: json['vote_count'] ?? 0,
    belongsToCollection: json['belongs_to_collection'],
  );

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'backdrop_path': backdropPath,
    'id': id,
    'imdb_id': imdbId,
    'budget': budget,
    'genres': genres.map((e) => e.toJson()).toList(),
    'homepage': homepage,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'production_companies': productionCompanies.map((e) => e.toJson()).toList(),
    'production_countries': productionCountries.map((e) => e.toJson()).toList(),
    'release_date': releaseDate,
    'revenue': revenue,
    'runtime': runtime,
    'spoken_languages': spokenLanguages.map((e) => e.toJson()).toList(),
    'status': status,
    'tagline': tagline,
    'title': title,
    'video': video,
    'vote_average': voteAverage,
    'vote_count': voteCount,
    'belongs_to_collection': belongsToCollection,
  };
}

class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(id: json['id'], name: json['name'] ?? '');

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class ProductionCompany {
  int id;
  String name;
  String? logoPath;
  String originCountry;

  ProductionCompany({required this.id, required this.name, this.logoPath, required this.originCountry});

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
    id: json['id'],
    name: json['name'] ?? '',
    logoPath: json['logo_path'],
    originCountry: json['origin_country'] ?? '',
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'logo_path': logoPath, 'origin_country': originCountry};
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({required this.iso31661, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(iso31661: json['iso_3166_1'] ?? '', name: json['name'] ?? '');

  Map<String, dynamic> toJson() => {'iso_3166_1': iso31661, 'name': name};
}

class SpokenLanguage {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguage({required this.englishName, required this.iso6391, required this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json['english_name'] ?? '',
    iso6391: json['iso_639_1'] ?? '',
    name: json['name'] ?? '',
  );

  Map<String, dynamic> toJson() => {'english_name': englishName, 'iso_639_1': iso6391, 'name': name};
}
