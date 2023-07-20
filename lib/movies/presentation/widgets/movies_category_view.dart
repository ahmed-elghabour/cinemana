import 'package:animate_do/animate_do.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviesCategory extends StatelessWidget {
  final String category;
  final List<Movie> movies;
  const MoviesCategory(
      {super.key, required this.category, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: GoogleFonts.aBeeZee(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                ),
              ),
              InkWell(
                onTap: () {
                  /// TODO : NAVIGATION TO POPULAR SCREEN
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(
                    Icons.apps,
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        FadeIn(
          duration: const Duration(milliseconds: 500),
          child: SizedBox(
            height: 170.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(movie: movie);
              },
            ),
          ),
        ),
      ],
    );
  }
}
