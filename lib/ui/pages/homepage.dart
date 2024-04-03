import 'package:flutter/material.dart';
import 'package:login_cadastro/ui/widgets/myAppBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(texto: "Lista de atividades para fazer"),
      body: ListaMaterias(),
    );
  }
}

class Materia {
  String nome;
  bool estudada;

  Materia(this.nome, this.estudada);
}

class ListaMaterias extends StatefulWidget {
  @override
  _ListaMateriasState createState() => _ListaMateriasState();
}

class _ListaMateriasState extends State<ListaMaterias> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _editController = TextEditingController();
  List<Materia> materias = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Nova matéria",
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    materias.add(Materia(_controller.text, false));
                    _controller.clear();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: materias.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    Checkbox(
                      value: materias[index].estudada,
                      onChanged: (value) {
                        setState(() {
                          materias[index].estudada = value!;
                        });
                      },
                    ),
                    Expanded(child: Text(materias[index].nome)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editController.text = materias[index].nome;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Editar Matéria"),
                              content: TextField(
                                controller: _editController,
                                decoration: InputDecoration(hintText: "Novo nome"),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      materias[index].nome = _editController.text;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Text('Salvar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancelar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          materias.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}