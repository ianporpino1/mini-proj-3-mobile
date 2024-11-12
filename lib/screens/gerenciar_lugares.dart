import 'package:f05_lugares_app/screens/cadastro_lugares.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f05_lugares_app/providers/LugaresProvider.dart';

class GerenciarLugaresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Lugares'),
      ),
      body: Consumer<LugaresProvider>(
        builder: (context, lugaresProvider, _) {
          return ListView.builder(
            itemCount: lugaresProvider.lugaress.length,
            itemBuilder: (context, index) {
              final lugar = lugaresProvider.lugaress[index];
              return ListTile(
                title: Text(lugar.titulo),
                subtitle: Text('Avaliação: ${lugar.avaliacao}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            insetPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 50),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Scaffold(
                                appBar: AppBar(
                                  title: Text('Editar Lugar'),
                                  leading: IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Voltar para a tela anterior
                                    },
                                  ),
                                ),
                                body: CadastrarLugarScreen(lugar: lugar),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, lugar.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String lugarId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmar Remoção'),
        content: Text('Tem certeza que deseja remover este lugar?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<LugaresProvider>(context, listen: false)
                  .removerLugar(lugarId);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Lugar removido com sucesso!'),
              ));
              Navigator.of(ctx).pop();
            },
            child: Text('Remover'),
          ),
        ],
      ),
    );
  }
}
