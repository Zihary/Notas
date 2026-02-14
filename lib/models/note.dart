import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {

  @HiveField(0)
  String titulo;

  @HiveField(1)
  String contenido;

  @HiveField(2)
  int colorValue;

  Note({
    required this.titulo,
    required this.contenido,
    required this.colorValue,
  });
}
