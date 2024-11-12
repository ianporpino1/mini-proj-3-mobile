import 'package:f05_lugares_app/model/lugar.dart';
import 'package:flutter/material.dart';

class FavoritosProvider with ChangeNotifier {
  final List<Lugar> _lugaresFavoritos = [];

  List<Lugar> get lugaresFavoritos => _lugaresFavoritos;

  void toggleFavorito(Lugar lugar) {
    if (_lugaresFavoritos.contains(lugar)) {
      _lugaresFavoritos.remove(lugar);
    } else {
      _lugaresFavoritos.add(lugar);
    }
    notifyListeners();
  }

  bool isFavorito(Lugar lugar) => _lugaresFavoritos.contains(lugar);
}
