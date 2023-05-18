import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/pages/movie_details_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/details': (context) => MovieDetailsPage(
              movie: Movie(),
              index: 0,
            )
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    );
  }
}
