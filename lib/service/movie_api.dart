import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/utils/constants.dart';

class MovieApi {
  static String urlGetMovie = '${Const.baseURL}/movies';

  static Future getAllMovies() async {
    http.Response resp = await http.get(Uri.parse(urlGetMovie), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    if (resp.statusCode == 200) {
      return Movies.fromJson(json.decode(resp.body));
    } else {
      return throw Exception("Erro ao buscar livros na API");
    }
  }

  static Future getMovie({required int id}) async {
    http.Response resp =
        await http.get(Uri.parse('$urlGetMovie/$id'), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    if (resp.statusCode == 200) {
      return Movie.fromJson(json.decode(resp.body));
    } else {
      return throw Exception("Erro ao buscar livro na API");
    }
  }
}
