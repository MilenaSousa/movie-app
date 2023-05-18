import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/service/movie_api.dart';
import 'package:movie_app/widgets/rating_bar.dart';
import 'package:movie_app/widgets/tags_row_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexMovie = 0;
  bool open = false;

  Movies moviesList = Movies();
  bool loading = true;

  @override
  void initState() {
    MovieApi.getAllMovies().then((value) {
      setState(() {
        loading = false;
        moviesList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final body = Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 0,
            child: FadedBackgroundImage(
                indexMovie: indexMovie, moviesList: moviesList)),
        Positioned(
            bottom: 30,
            child: SizedBox(
              height: 655,
              width: size.width,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return MovieCardComponent(
                      movie: moviesList.listMovies?[index] ?? Movie(),
                      index: index);
                },
                itemCount: moviesList.listMovies?.length ?? 0,
                fade: .5,
                viewportFraction: 0.74,
                scale: 0.79,
                onIndexChanged: (index) {
                  setState(() {
                    indexMovie = index;
                  });
                },
              ),
            )),
        Positioned(
            top: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: size.width,
              height: 80,
              child: const MyAppBar(),
            ))
      ],
    );

    return Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: loading
            // ignore: prefer_const_constructors
            ? LinearProgressIndicator()
            : body);
  }
}

class MovieCardComponent extends StatelessWidget {
  final Movie movie;
  final int index;

  const MovieCardComponent(
      {super.key, required this.movie, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, top: 10),
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                spreadRadius: 4,
                blurRadius: 10)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(150),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 405,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Hero(
                    tag: movie.id ?? "",
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(128),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: movie.thumbnailImage ?? "",
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                const SizedBox(height: 5),
                Text(movie.title ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                Rating(movie: movie),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 15),
                    child: TagsRowWidget(movie: movie)),
                const Spacer(),
                Container(
                  alignment: Alignment.topCenter,
                  height: 53,
                  width: 160,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 18),
                    child: Text(
                      'Ler Mais',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              right: 12,
              top: 410,
              child: Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.only(left: 3),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
                child: LikeButton(
                  size: 22,
                  circleColor: const CircleColor(
                      start: Color.fromARGB(255, 255, 72, 0),
                      end: Color.fromARGB(255, 0, 129, 204)),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Color.fromARGB(255, 229, 51, 182),
                    dotSecondaryColor: Color.fromARGB(255, 232, 255, 81),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked
                          ? const Color.fromARGB(255, 231, 135, 135)
                          : const Color.fromARGB(255, 255, 255, 255),
                      size: 22,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailsPage(
                      movie: movie,
                      index: index,
                    )));
      },
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Icon(
            Icons.favorite_outline,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class FadedBackgroundImage extends StatelessWidget {
  const FadedBackgroundImage({
    super.key,
    required this.indexMovie,
    required this.moviesList,
  });

  final int indexMovie;
  final Movies moviesList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: 350,
        width: size.width,
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: ShaderMask(
              key: ValueKey<int>(indexMovie),
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                height: 350,
                image: moviesList.listMovies?[indexMovie].backgroundImage ?? "",
                fit: BoxFit.cover,
              )),
        ));
  }
}
