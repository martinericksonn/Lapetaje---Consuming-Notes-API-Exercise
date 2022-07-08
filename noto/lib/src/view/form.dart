// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noto/src/services/notes_service.dart';

import '../models/note.dart';
import '../models/note_insert.dart';

// ignore: must_be_immutable
class TaskForm extends StatefulWidget {
  final String? noteID;
  const TaskForm({Key? key, this.noteID}) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  bool get isEditing => widget.noteID != null;

  NotesService get notesService => GetIt.I<NotesService>();

  String? errorMessage;
  Note? note;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  // final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.noteID!).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        note = response.data;
        _titleController.text = note!.noteTitle;
        _contentController.text = note!.noteContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                formTitle(),
                formTitleField(),
                formButtons(context),
              ],
            ),
          ),
        ));
  }

  Expanded formButtons(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              child: Text(
                "Cancel",
                style: TextStyle(
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (isEditing) {
                setState(() {
                  _isLoading = true;
                });
                final note = NoteManipulation(
                    noteTitle: _titleController.text,
                    noteContent: _contentController.text);
                final result =
                    await notesService.updateNote(widget.noteID!, note);

                setState(() {
                  _isLoading = false;
                });

                final title = 'Done';
                final text = result.error
                    ? (result.errorMessage ?? 'An error occurred')
                    : 'Your note was updated';

                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )).then((data) {
                  if (result.data!) {
                    Navigator.of(context).pop();
                  }
                });
              } else {
                setState(() {
                  _isLoading = true;
                });
                final note = NoteManipulation(
                    noteTitle: _titleController.text,
                    noteContent: _contentController.text);
                final result = await notesService.createNote(note);

                setState(() {
                  _isLoading = false;
                });

                final title = 'Done';
                final text = result.error
                    ? (result.errorMessage ?? 'An error occurred')
                    : 'Your note was created';

                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )).then((data) {
                  if (result.data!) {
                    Navigator.of(context).pop();
                  }
                });
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                child: Text(
                  "Save",
                  style: TextStyle(
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding formTitleField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: _titleController,
        autofocus: true,
        style: TextStyle(fontWeight: FontWeight.bold),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text("Title"),

          // label:
        ),
      ),
    );
  }

  Padding formTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text(
        isEditing ? "Edit Note" : "Create Note",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
      ),
    );
  }
}
