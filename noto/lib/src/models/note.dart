import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  Note({
    required this.noteID,
    required this.noteTitle,
    required this.noteContent,
    required this.createDateTime,
    required this.latestEditDateTime,
  });

  static const fromJson = _$NoteFromJson;
}
