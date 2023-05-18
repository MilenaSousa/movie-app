class Movies {
  List<Movie>? listMovies;

  Movies({this.listMovies});

  factory Movies.fromJson(Map json) {
    List list = json['payload'] as List;
    List<Movie> movieList = [];
    movieList = list.map((element) => Movie.fromJson(element)).toList();
    return Movies(listMovies: movieList);
  }
}

class Movie {
  String? backgroundImage;
  List<Cast>? cast;
  String? directedBy;
  String? distribution;
  String? duration;
  List? genres;
  int? id;
  String? releaseYear;
  String? resume;
  double? stars;
  String? thumbnailImage;
  String? title;

  Movie(
      {this.backgroundImage,
      this.cast,
      this.directedBy,
      this.distribution,
      this.duration,
      this.genres,
      this.id,
      this.releaseYear,
      this.resume,
      this.stars,
      this.thumbnailImage,
      this.title});

  Movie.fromJson(Map<String, dynamic> json) {
    backgroundImage = json['background_image'];
    if (json['cast'] != null) {
      cast = <Cast>[];
      json['cast'].forEach((v) {
        cast!.add(Cast.fromJson(v));
      });
    }
    directedBy = json['directed_by'];
    distribution = json['distribution'];
    duration = json['duration'];
    genres = json['genres'];
    id = json['id'];
    releaseYear = json['release_year'];
    resume = json['resume'];
    stars = json['stars'];
    thumbnailImage = json['thumbnail_image'];
    title = json['title'];
  }
}

class Cast {
  String? name;
  String? profileImage;

  Cast({this.name, this.profileImage});

  Cast.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profile_image'];
  }
}
