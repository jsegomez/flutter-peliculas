import 'dart:async';
import 'dart:convert';
import 'package:peliculas_v2/models/Pelicula.dart';
import 'package:http/http.dart' as http;

class PeliculasService {
  String _apiKey = '636fc5531b530d22d014e0153533c084';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Pelicula> _populares = [];
  List<Pelicula> _topRated = [];
  List<Pelicula> _upComing = [];

  // ============================= Streams de la aplicación =============================

  // Stream para peliculas populares
  final _popularesStreamCtrl = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularesSink => _popularesStreamCtrl.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamCtrl.stream;

  // Stream para más votadas
  final _topRatedStreamCtrl = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get topRatedSink => _topRatedStreamCtrl.sink.add;
  Stream<List<Pelicula>> get topRatedStream => _topRatedStreamCtrl.stream;

  // Stream para peliculas próximamente
  final _upComingStreamCtrl = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get upComingSink => _upComingStreamCtrl.sink.add;
  Stream<List<Pelicula>> get upComingStream => _upComingStreamCtrl.stream;

  // Cerramos los streams
  void disposeStreams() {
    _popularesStreamCtrl?.close();
    _topRatedStreamCtrl?.close();
    _upComingStreamCtrl?.close();
  }

  // ============================= Funciones para obtener datos =============================
  Future<List<Pelicula>> getEncines() async {
    String page = '1';
    final url = Uri.https(_url, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': page});

    final List<Pelicula> enCines = await decodeDatosPelicula(url);
    return enCines;
  }

  void getPopulares() async {
    String page = '1';
    final url = Uri.https(_url, '/3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': page});

    final List<Pelicula> populares = await decodeDatosPelicula(url);
    _populares.addAll(populares);
    popularesSink(_populares);
  }

  void getTopRated() async {
    String page = '1';
    final url = Uri.https(_url, '/3/movie/top_rated',
        {'api_key': _apiKey, 'language': _language, 'page': page});

    final List<Pelicula> topRated = await decodeDatosPelicula(url);
    _topRated.addAll(topRated);
    topRatedSink(_topRated);
  }

  void getUpComing() async {
    String page = '1';
    final url = Uri.https(_url, '/3/movie/upcoming',
        {'api_key': _apiKey, 'language': _language, 'page': page});

    final List<Pelicula> upComing = await decodeDatosPelicula(url);
    _upComing.addAll(upComing);
    upComingSink(_upComing);
  }

  Future<List<Pelicula>> decodeDatosPelicula(Uri url) async {
    final resultados = await http.get(url);
    final decodeData = json.decode(resultados.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }
}
