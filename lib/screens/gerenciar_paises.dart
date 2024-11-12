import 'package:f05_lugares_app/model/pais.dart';
import 'package:f05_lugares_app/providers/PaisesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GerenciarPaisesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Países"),
      ),
      body: Consumer<PaisesProvider>(
        builder: (context, paisProvider, child) {
          return ListView.builder(
            itemCount: paisProvider.paisess.length,
            itemBuilder: (context, index) {
              final pais = paisProvider.paisess[index];
              return ListTile(
                title: Text(pais.titulo),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editarPais(context, pais);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        paisProvider.removerPais(pais.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _adicionarPais(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _adicionarPais(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cadastrar País"),
        content: TextField(
          controller: nomeController,
          decoration: InputDecoration(hintText: "Nome do País"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nomeController.text.isNotEmpty) {
                final pais = Pais(
                  id: 'c${DateTime.now().millisecondsSinceEpoch}',
                  titulo: nomeController.text,
                );
                Provider.of<PaisesProvider>(context, listen: false)
                    .adicionarPais(pais);
                Navigator.pop(context);
              }
            },
            child: Text("Salvar"),
          ),
        ],
      ),
    );
  }

  void _editarPais(BuildContext context, Pais pais) {
    final TextEditingController nomeController =
        TextEditingController(text: pais.titulo);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Editar País"),
        content: TextField(
          controller: nomeController,
          decoration: InputDecoration(hintText: "Nome do País"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nomeController.text.isNotEmpty) {
                Provider.of<PaisesProvider>(context, listen: false)
                    .editarPais(pais.id, nomeController.text);
                Navigator.pop(context);
              }
            },
            child: Text("Salvar"),
          ),
        ],
      ),
    );
  }
}
