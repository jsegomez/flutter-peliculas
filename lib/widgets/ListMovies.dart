import 'package:flutter/material.dart';
import 'package:peliculas_v2/models/Pelicula.dart';

class ListMovies extends StatelessWidget {
  ListMovies({@required this.peliculas, @required this.title});
  // ====================== Propiedades de la clase ======================
  final Stream<List<Pelicula>> peliculas;
  final String title;
  final EdgeInsets margenesPersonalizados = EdgeInsets.only(
    top: 5.0,
    left: 6.0,
    right: 6.0,
    bottom: 10.0,
  );
  final TextStyle styleText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontSize: 16.0,
  );
  // =====================================================================

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: peliculas,
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.0),
                child: Text(title, style: styleText),
              ),
              Container(
                margin: margenesPersonalizados,
                height: 195,
                width: double.infinity,
                child: listViewMovies(snapshot.data),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget listViewMovies(peliculas) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: peliculas.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 180.0,
          width: 130.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
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
    );
  }
}
