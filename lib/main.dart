import 'package:f05_lugares_app/providers/FavoritosProvider.dart';
import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/providers/LugaresProvider.dart';
import 'package:f05_lugares_app/providers/PaisesProvider.dart';
import 'package:f05_lugares_app/screens/abas.dart';
import 'package:f05_lugares_app/screens/cadastro_lugares.dart';
import 'package:f05_lugares_app/screens/configuracoes.dart';
import 'package:f05_lugares_app/screens/detalhes_lugar.dart';
import 'package:f05_lugares_app/screens/lugares_por_pais.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LugaresProvider()),
        ChangeNotifierProvider(create: (context) => FavoritosProvider()),
        ChangeNotifierProvider(create: (context) => PaisesProvider())
      ],
      child: MeuApp(),
    ),
  );
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Lugar> _lugaresFavoritos = [];

  void toggleLugarFavorito(Lugar place) {
    setState(() {
      _lugaresFavoritos.contains(place)
          ? _lugaresFavoritos.remove(place)
          : _lugaresFavoritos.add(place);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => MinhasAbas(),
        '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
        '/detalheLugar': (ctx) => DetalhesLugarScreen(),
        '/configuracoes': (ctx) => ConfigracoesScreen(),
        '/cadastrarLugar': (ctx) => CadastrarLugarScreen()
      },
    );

    /* return MaterialApp.router(
      routerConfig: minhasRotas.getRouter(),
    ); */
  }
}
