import 'package:flutter/material.dart';
import 'package:peliculas_v2/models/Pelicula.dart';

class ListMovies extends StatelessWidget {
  final List<Pelicula> peliculas;

  ListMovies({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            width: 120.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/loading.gif'),
                image: NetworkImage(peliculas[index].getPosterImg()),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
