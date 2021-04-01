import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_v2/models/Pelicula.dart';

class CardSwipper extends StatelessWidget {
  final List<Pelicula> peliculas;
  CardSwipper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getPosterImg()),
              placeholder: AssetImage('assets/images/loading.gif'),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: peliculas.length,
        itemHeight: 320,
        itemWidth: 210,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
