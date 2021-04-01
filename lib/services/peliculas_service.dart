import 'dart:async';
import 'dart:convert';
import 'package:peliculas_v2/models/Pelicula.dart';
import 'package:http/http.dart' as http;

class PeliculasService {
  String _apiKey = '636fc5531b530d22d014e0153533c084';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _page = '1';

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.https(_url, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    final resultados = await http.get(url);
    final decodedDate = json.decode(resultados.body);
    final peliculas = new Peliculas.fromJsonList(decodedDate['results']);

    print(peliculas.items[0].title);

    return peliculas.items;
  }
}
