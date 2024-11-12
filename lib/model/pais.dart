import 'package:flutter/material.dart';

class Pais {
  final String id;
  String titulo;
  final Color cor;

  Pais({
    required this.id,
    required this.titulo,
    this.cor = Colors.blue,
  });
}
