import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/rating_bar.dart';
import 'package:movie_app/widgets/tags_row_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  final int index;
  const MovieDetailsPage({super.key, required this.movie, required this.index});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool initAnimation = false;

  Movie get movie => widget.movie;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      setState(() {
        initAnimation = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final body = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                  height: 450,
                  width: size.width,
                  child: Hero(
                    tag: movie.id ?? "",
                    child: Image.network(
                      movie.thumbnailImage ?? "",
                      fit: BoxFit.fitWidth,
                    ),
                  )),
              PlayTrailerAnimatedButton(initAnimation: initAnimation),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            widget.movie.title ?? "",
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Rating(movie: movie),
          const SizedBox(height: 14),
          SizedBox(
            height: 20,
            child: TagsRowWidget(movie: movie),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CastAnimatedLabel(initAnimation: initAnimation, movie: movie),
                const SizedBox(height: 25),
                ProductionDetails(movie: movie),
                const SizedBox(height: 30),
                const Text(
                  "Enredo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  movie.resume ?? "",
                  style: const TextStyle(
                      height: 1.6, color: Colors.black87, letterSpacing: .3),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );

    return Scaffold(body: body);
  }
}

class ProductionDetails extends StatelessWidget {
  const ProductionDetails({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 240, 240, 240),
          border: Border.all(color: Colors.grey.shade400, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProductionDetailsRow(
              label1: "Dirigido por: ", label2: movie.directedBy ?? ""),
          ProductionDetailsRow(
            label1: "Ano: ",
            label2: movie.releaseYear ?? "",
          ),
          ProductionDetailsRow(
            label1: "Duração: ",
            label2: movie.duration ?? "",
          ),
          ProductionDetailsRow(
            label1: "Distribuição: ",
            label2: movie.distribution ?? "",
          ),
        ],
      ),
    );
  }
}

class ProductionDetailsRow extends StatelessWidget {
  final String label1;
  final String label2;

  const ProductionDetailsRow({
    super.key,
    required this.label1,
    required this.label2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label1,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
              letterSpacing: 0.5),
        ),
        const SizedBox(width: 3),
        Text(
          label2,
          style: TextStyle(color: Colors.grey.shade600, letterSpacing: 0.5),
        )
      ],
    );
  }
}

class CastAnimatedLabel extends StatelessWidget {
  const CastAnimatedLabel({
    super.key,
    required this.initAnimation,
    required this.movie,
  });

  final bool initAnimation;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
        duration: const Duration(milliseconds: 380),
        padding: EdgeInsets.only(top: initAnimation ? 0 : 190),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Elenco",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 135,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.cast?.length,
                  itemBuilder: (context, index) {
                    return CastComponent(cast: movie.cast?[index] ?? Cast());
                  }),
            ),
          ],
        ));
  }
}

class PlayTrailerAnimatedButton extends StatelessWidget {
  const PlayTrailerAnimatedButton({
    super.key,
    required this.initAnimation,
  });

  final bool initAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      right: 0,
      left: 0,
      bottom: 0,
      top: initAnimation ? 0 : 190,
      duration: const Duration(milliseconds: 380),
      child: AnimatedOpacity(
        opacity: initAnimation ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.5), shape: BoxShape.circle),
              child:
                  const Icon(Icons.play_arrow, size: 28, color: Colors.white),
            ),
            const SizedBox(height: 7),
            const Text(
              "Play Trailer",
              style: TextStyle(color: Colors.white, shadows: [
                Shadow(
                    color: Color.fromARGB(255, 25, 25, 25),
                    offset: Offset(1, 1),
                    blurRadius: 3)
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class CastComponent extends StatelessWidget {
  final Cast cast;

  const CastComponent({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 90,
            width: 85,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: cast.profileImage ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 65,
            child: AutoSizeText(
              "${cast.name}",
              maxFontSize: 13,
              maxLines: 2,
              style: const TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
