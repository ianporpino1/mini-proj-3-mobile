import 'package:f05_lugares_app/components/item_pais.dart';
import 'package:f05_lugares_app/data/dados.dart';
import 'package:f05_lugares_app/providers/PaisesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaisScreen extends StatelessWidget {
  const PaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> getPaises() {
      Provider.of<PaisesProvider>(context).paisess;
      return paises.map((pais) => ItemPais(pais: pais)).toList();
    }

    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          "Países",
          style: TextStyle(color: Colors.white),
        ),
      ), */
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 120,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
        ),
        children: getPaises(),
      ),
    );
  }
}
