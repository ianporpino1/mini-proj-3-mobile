import 'package:f05_lugares_app/data/dados.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:flutter/material.dart';

class PaisesProvider with ChangeNotifier {
  final List<Pais> _paises = paises;

  List<Pais> get paisess => _paises;

  void adicionarPais(Pais pais) {
    _paises.add(pais);
    notifyListeners();
  }

  void removerPais(String id) {
    _paises.removeWhere((pais) => pais.id == id);
    notifyListeners();
  }

  void editarPais(String id, String novoNome) {
    Pais pais = _paises.firstWhere((pais) => pais.id == id);
    pais.titulo = novoNome;
    notifyListeners();
  }
}
