import 'package:flutter/material.dart';
import 'package:peliculas_v2/models/Pelicula.dart';
import 'package:peliculas_v2/services/peliculas_service.dart';
import 'package:peliculas_v2/widgets/CardSwipper.dart';

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
    final _screenSize = MediaQuery.of(context).size;
    print(_screenSize.height);
    final peliculas = this.peliculasService.getEncines();
    return Container(
      padding: EdgeInsets.only(top: 25),
      width: double.infinity,
      height: double.infinity,
      color: Colors.blueGrey[800],
      child: Column(
        children: [
          nowPlaying(peliculas, _screenSize),
        ],
      ),
    );
  }

  // Muestra las peliculas en cines
  FutureBuilder<List<Pelicula>> nowPlaying(
      Future<List<Pelicula>> peliculas, Size _screenSize) {
    return FutureBuilder(
      future: peliculas,
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
}
