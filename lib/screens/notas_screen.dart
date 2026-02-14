import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';
import 'nueva_nota_screen.dart';
import 'editar_nota_screen.dart';

class NotasScreen extends StatelessWidget {

  final Box<Note> box = Hive.box<Note>('notas');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Notas"),
        centerTitle: true,
        backgroundColor: Color(0xFF00529e),
        elevation: 4,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFf8bb00),
        elevation: 6,
        child: Icon(Icons.add, size: 30),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NuevaNotaScreen(),
            ),
          );
        },
      ),

      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Note> box, _) {

          if (box.values.isEmpty) {
            return Center(
              child: Text(
                "No hay notas aún",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.8,
            ),
            itemCount: box.length,
            itemBuilder: (context, index) {

              Note nota = box.getAt(index)!;

              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Color(nota.colorValue),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(14),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            nota.titulo,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Row(
                          children: [

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditarNotaScreen(nota: nota),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),

                            SizedBox(width: 8),

                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Text("Eliminar nota"),
                                    content: Text(
                                        "¿Seguro que deseas eliminarla?"),
                                    actions: [
                                      TextButton(
                                        child: Text("Cancelar"),
                                        onPressed: () =>
                                            Navigator.pop(context),
                                      ),
                                      TextButton(
                                        child: Text(
                                          "Eliminar",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          nota.delete();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.delete,
                                size: 18,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 10),

                    Expanded(
                      child: Text(
                        nota.contenido,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
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
}
