import 'package:f05_lugares_app/screens/gerenciar_lugares.dart';
import 'package:f05_lugares_app/screens/gerenciar_paises.dart';
import 'package:flutter/material.dart';

class MeuDrawer extends StatelessWidget {
  const MeuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ThemeData().primaryColor,
            ),
            child: Text(
              'Configurações',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: const Text('Países'),
            onTap: () {
              //context.pushReplacement('/');
              Navigator.of(context).pushReplacementNamed(
                '/',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.engineering),
            title: const Text('Configurações'),
            onTap: () {
              //context.pushReplacement('/configuracoes');
              Navigator.of(context).pushReplacementNamed(
                '/configuracoes',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: const Text('Adicionar Lugar'),
            onTap: () {
              //context.pushReplacement('/configuracoes');
              Navigator.of(context).pushReplacementNamed(
                '/cadastrarLugar',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Lugares'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GerenciarLugaresScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Paises'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GerenciarPaisesScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
