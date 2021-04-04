import 'package:flutter/material.dart';
import 'package:peliculas_v2/models/Pelicula.dart';
import 'package:peliculas_v2/services/peliculas_service.dart';
import 'package:peliculas_v2/widgets/CardSwipper.dart';
import 'package:peliculas_v2/widgets/ListMovies.dart';

class HomePage extends StatelessWidget {
  final peliculasService = new PeliculasService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarCustom(),
      body: _customBody(context),
    );
  }

  // Appbar de la aplicación
  AppBar _appBarCustom() {
    return AppBar(
      title: Text('Peliculas en cines'),
      centerTitle: true,
      backgroundColor: Colors.blueGrey[900],
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }

  // Body de la aplicación
  Container _customBody(BuildContext context) {
    return Container(
      color: Colors.blueGrey[800],
      child: ListView(
        children: [
          nowPlaying(context),
          getPopulares(),
          getTopRated(),
          getUpComing(),
          SizedBox(
            height: 15.0,
          )
        ],
      ),
    );
  }

  // Muestra las peliculas en cines
  FutureBuilder<List<Pelicula>> nowPlaying(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final enCines = this.peliculasService.getEncines();
    return FutureBuilder(
      future: enCines,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return CardSwipper(peliculas: snapshot.data);
        } else {
          return Container(
            margin: EdgeInsets.only(top: _screenSize.height / 3),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget getPopulares() {
    peliculasService.getPopulares();
    Stream<List<Pelicula>> peliculas = peliculasService.popularesStream;
    return ListMovies(
      peliculas: peliculas,
      title: 'Populares',
    );
  }

  Widget getTopRated() {
    peliculasService.getTopRated();
    Stream<List<Pelicula>> peliculas = peliculasService.topRatedStream;
    return ListMovies(
      peliculas: peliculas,
      title: 'Más votadas',
    );
  }

  Widget getUpComing() {
    peliculasService.getUpComing();
    Stream<List<Pelicula>> peliculas = peliculasService.upComingStream;
    return ListMovies(
      peliculas: peliculas,
      title: 'Próximamente',
    );
  }
}
