import 'package:f05_lugares_app/components/drawer.dart';
import 'package:f05_lugares_app/screens/favoritos.dart';
import 'package:f05_lugares_app/screens/pais_screen.dart';
import 'package:flutter/material.dart';

class MinhasAbas extends StatefulWidget {
  const MinhasAbas({super.key});

  @override
  State<MinhasAbas> createState() => _MinhasAbasState();
}

class _MinhasAbasState extends State<MinhasAbas> {
  @override
  Widget build(BuildContext context) {
    return MinhasAbasBottom();
  }
}

class MinhasAbasBottom extends StatefulWidget {
  const MinhasAbasBottom({super.key});

  @override
  State<MinhasAbasBottom> createState() => _MinhasAbasBottomState();
}

class _MinhasAbasBottomState extends State<MinhasAbasBottom> {
  String _nomeTab = "Países";
  List<String> _nomeTabs = ["Países", "Favoritos"];

  void _getNomeTab(int index) {
    setState(() {
      _nomeTab = _nomeTabs[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _nomeTab,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ThemeData().primaryColor,
        ),
        drawer: MeuDrawer(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                children: [
                  PaisScreen(),
                  FavoritosScreen(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              decoration: BoxDecoration(
                color: ThemeData().primaryColor,
              ),
              child: TabBar(
                onTap: (index) {
                  _getNomeTab(index);
                },
                indicatorColor: Colors.amber,
                labelColor: Colors.amber,
                unselectedLabelColor: Colors.white60,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.category),
                    text: "Países",
                  ),
                  Tab(
                    icon: Icon(Icons.star),
                    text: "Favoritos",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}