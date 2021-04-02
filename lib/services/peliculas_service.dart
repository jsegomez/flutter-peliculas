import 'dart:async';
import 'dart:convert';
import 'package:peliculas_v2/models/Pelicula.dart';
import 'package:http/http.dart' as http;

class PeliculasService {
  String _apiKey = '636fc5531b530d22d014e0153533c084';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _page = '1';

  List<Pelicula> _populares = [];

  final _popularesStreamCtrl = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularesSink => _popularesStreamCtrl.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamCtrl.stream;

  void disposeStreams() {
    _popularesStreamCtrl?.close();
  }

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.https(_url, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final List<Pelicula> enCines = await decodeDatosPelicula(url);
    return enCines;
  }

  void getPopulares() async {
    final url = Uri.https(_url, '/3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    final List<Pelicula> populares = await decodeDatosPelicula(url);
    _populares.addAll(populares);
    popularesSink(_populares);
  }

  Future<List<Pelicula>> decodeDatosPelicula(Uri url) async {
    final resultados = await http.get(url);
    final decodeData = json.decode(resultados.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }
}
