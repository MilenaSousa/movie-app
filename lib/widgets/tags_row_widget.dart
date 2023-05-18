import 'package:flutter/material.dart';

import '../models/movie.dart';

class TagsRowWidget extends StatelessWidget {
  final Movie movie;
  const TagsRowWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: movie.genres?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TagItem(tag: movie.genres?[index]);
          }),
    );
  }
}

class TagItem extends StatelessWidget {
  final String tag;

  const TagItem({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 59,
      margin: EdgeInsets.only(right: 5),
      // padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey.shade300)),
      child: Text(
        tag,
        style: const TextStyle(fontSize: 10, color: Colors.black),
      ),
    );
  }
}
