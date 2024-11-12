import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/providers/LugaresProvider.dart';
import 'package:f05_lugares_app/screens/abas.dart';
import 'package:flutter/material.dart';
import 'package:f05_lugares_app/data/dados.dart';
import 'package:provider/provider.dart';

class CadastrarLugarScreen extends StatefulWidget {
  final Lugar? lugar; // Parâmetro opcional para edição

  // Construtor modificado para aceitar um lugar existente para edição
  CadastrarLugarScreen({this.lugar});

  @override
  State<CadastrarLugarScreen> createState() => _CadastrarLugarScreenState();
}

class _CadastrarLugarScreenState extends State<CadastrarLugarScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _avaliacaoController = TextEditingController();
  final TextEditingController _custoMedioController = TextEditingController();
  final TextEditingController _imagemUrlController = TextEditingController();
  final TextEditingController _recomendacaoController = TextEditingController();

  List<String> _paisesSelecionados = [];
  List<String> _recomendacoes = [];

  @override
  void initState() {
    super.initState();
    if (widget.lugar != null) {
      // Preencher os campos com os dados do lugar
      _tituloController.text = widget.lugar!.titulo;
      _avaliacaoController.text = widget.lugar!.avaliacao.toString();
      _custoMedioController.text = widget.lugar!.custoMedio.toString();
      _imagemUrlController.text = widget.lugar!.imagemUrl;
      _paisesSelecionados = List.from(widget.lugar!.paises);
      _recomendacoes = List.from(widget.lugar!.recomendacoes);
    }
  }

  void _salvarLugar() {
    if (_paisesSelecionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecione ao menos um país.')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final novoLugar = Lugar(
        id: widget.lugar?.id ??
            'p${DateTime.now().millisecondsSinceEpoch}', // Se não for edição, cria um novo ID
        titulo: _tituloController.text,
        paises: _paisesSelecionados,
        avaliacao: double.parse(_avaliacaoController.text),
        custoMedio: double.parse(_custoMedioController.text),
        recomendacoes: _recomendacoes,
        imagemUrl: _imagemUrlController.text,
      );

      if (widget.lugar != null) {
        // Se for edição, atualiza o lugar
        Provider.of<LugaresProvider>(context, listen: false)
            .atualizarLugar(novoLugar);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Lugar "${novoLugar.titulo}" atualizado com sucesso!')),
        );
      } else {
        // Se for criação, adiciona o novo lugar
        Provider.of<LugaresProvider>(context, listen: false)
            .adicionarLugar(novoLugar);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Lugar "${novoLugar.titulo}" cadastrado com sucesso!')),
        );
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MinhasAbas()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.lugar == null
          ? AppBar(
              title: Text('Cadastrar Lugar'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MinhasAbas()),
                  );
                },
              ),
            )
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _avaliacaoController,
                decoration: InputDecoration(labelText: 'Avaliação'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma avaliação';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor numérico válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _custoMedioController,
                decoration: InputDecoration(labelText: 'Custo Médio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um custo médio';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor numérico válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imagemUrlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma URL de imagem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Selecione os Países',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildPaisesSelection(),
              const SizedBox(height: 10),
              const Text(
                'Adicione Recomendações',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildRecomendacoesInput(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _salvarLugar,
                child: Text(
                    widget.lugar != null ? 'Salvar Alterações' : 'Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaisesSelection() {
    return Column(
      children: paises.map((pais) {
        return CheckboxListTile(
          title: Text(pais.titulo),
          value: _paisesSelecionados.contains(pais.id),
          onChanged: (bool? selected) {
            setState(() {
              if (selected == true) {
                _paisesSelecionados.add(pais.id);
              } else {
                _paisesSelecionados.remove(pais.id);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRecomendacoesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _recomendacaoController,
          decoration: InputDecoration(
            labelText: 'Recomendação',
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _adicionarRecomendacao,
          child: Text('Adicionar Recomendação'),
        ),
        SizedBox(height: 10),
        Text('Recomendações:'),
        ..._recomendacoes.map((recomendacao) {
          return ListTile(
            title: Text(recomendacao),
          );
        }).toList(),
      ],
    );
  }

  void _adicionarRecomendacao() {
    setState(() {
      if (_recomendacaoController.text.isNotEmpty) {
        _recomendacoes.add(_recomendacaoController.text);
        _recomendacaoController.clear();
      }
    });
  }
}
