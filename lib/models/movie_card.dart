import 'package:flutter/material.dart';

class MovieCard {
  final String imageBg;
  final String image;
  final String title;
  final List<String> tags;

  MovieCard(
      {required this.imageBg,
      required this.image,
      required this.title,
      required this.tags});
}
