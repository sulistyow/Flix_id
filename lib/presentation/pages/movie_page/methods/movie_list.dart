import 'package:flix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/movie.dart';

List<Widget> movieList({
  required String title,
  void Function(Movie movie)? onTap,
  required AsyncValue<List<Movie>> movies,
}) =>
    [
      Padding(
        padding: EdgeInsets.only(left: 24, bottom: 15),
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(
        height: 228,
        child: movies.when(
            data: (movies) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: movies
                        .map((movie) => Padding(
                              padding: EdgeInsets.only(
                                  left: movie == movies.first ? 24 : 10,
                                  right: movie == movies.last ? 24 : 10),
                              child: NetworkImageCard(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                                fit: BoxFit.contain,
                                onTap: () => onTap?.call(movie),
                              ),
                            ))
                        .toList(),
                  ),
                ),
            error: (error, stackTrace) => const SizedBox(),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )),
      )
    ];
