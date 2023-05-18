import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/movie.dart';

class Rating extends StatelessWidget {
  final Movie movie;
  const Rating({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: movie.stars ?? 0,
      minRating: 1,
      itemSize: 14,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
