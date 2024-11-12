import 'package:f05_lugares_app/data/dados.dart';
import 'package:flutter/material.dart';
import 'package:f05_lugares_app/model/lugar.dart';

class LugaresProvider extends ChangeNotifier {
  final List<Lugar> _lugares = lugares;

  List<Lugar> get lugaress => _lugares;

  void adicionarLugar(Lugar lugar) {
    _lugares.add(lugar);
    notifyListeners();
  }

  void removerLugar(String id) {
    _lugares.removeWhere((lugar) => lugar.id == id);
    notifyListeners();
  }

  void atualizarLugar(Lugar lugarAtualizado) {
    final index =
        _lugares.indexWhere((lugar) => lugar.id == lugarAtualizado.id);
    if (index != -1) {
      _lugares[index] = lugarAtualizado;
      notifyListeners();
    }
  }
}
