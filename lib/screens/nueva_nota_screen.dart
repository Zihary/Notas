import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/note.dart';

class NuevaNotaScreen extends StatefulWidget {
  @override
  _NuevaNotaScreenState createState() => _NuevaNotaScreenState();
}

class _NuevaNotaScreenState extends State<NuevaNotaScreen> {

  final _formKey = GlobalKey<FormState>();
  final tituloController = TextEditingController();
  final contenidoController = TextEditingController();

  Color selectedColor = Colors.blue;

  final Box<Note> box = Hive.box<Note>('notas');

  final List<Color> colores = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor.withOpacity(0.15),

      appBar: AppBar(
        title: Text("Nueva Nota"),
        backgroundColor: selectedColor,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: tituloController,
                decoration: InputDecoration(labelText: "Título"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "El título es obligatorio";
                  }
                  return null;
                },
              ),

              SizedBox(height: 10),

              TextFormField(
                controller: contenidoController,
                decoration: InputDecoration(labelText: "Contenido"),
                maxLines: 3,
              ),

              SizedBox(height: 20),

              Text(
                "Selecciona un color",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              Wrap(
                spacing: 15,
                children: colores.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: color,
                      child: selectedColor == color
                          ? Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: Text("Cancelar"),
                    onPressed: () => Navigator.pop(context),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedColor,
                    ),
                    child: Text("Guardar"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        box.add(
                          Note(
                            titulo: tituloController.text,
                            contenido: contenidoController.text,
                            colorValue: selectedColor.value,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
