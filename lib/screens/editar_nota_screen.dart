import 'package:flutter/material.dart';
import '../models/note.dart';

class EditarNotaScreen extends StatefulWidget {

  final Note nota;

  EditarNotaScreen({required this.nota});

  @override
  _EditarNotaScreenState createState() => _EditarNotaScreenState();
}

class _EditarNotaScreenState extends State<EditarNotaScreen> {

  final _formKey = GlobalKey<FormState>();
  late TextEditingController tituloController;
  late TextEditingController contenidoController;
  late Color selectedColor;
  
  final List<Color> colores = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    tituloController = TextEditingController(text: widget.nota.titulo);
    contenidoController = TextEditingController(text: widget.nota.contenido);
    selectedColor = Color(widget.nota.colorValue);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: selectedColor.withOpacity(0.15),

      appBar: AppBar(
        title: Text("Editar Nota"),
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
                "Cambiar color",
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

                        widget.nota.titulo = tituloController.text;
                        widget.nota.contenido = contenidoController.text;
                        widget.nota.colorValue = selectedColor.value;

                        widget.nota.save();

                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
