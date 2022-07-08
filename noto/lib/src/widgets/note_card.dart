// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get_it/get_it.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../models/note_for_listing.dart';
import '../services/notes_service.dart';

class NoteCard extends StatefulWidget {
  NoteCard({
    Key? key,
    // required this.editTask,
  }) : super(key: key);

  // Function editTask;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  NotesService get service => GetIt.I<NotesService>();

  List<NoteForListing> notes = [];
  @override
  Widget build(BuildContext context) {
    return taskList();
  }

  @override
  void initState() {
    notes = service.getNotesList();
    super.initState();
  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  Widget deleteBkg(int index) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            Icons.delete,
            size: 28,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            height: 20,
            child: Text(
              "Deleted",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget taskList() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(), //
      shrinkWrap: true,
      itemCount: notes.length,
      itemBuilder: (_, index) => Dismissible(
        key: ValueKey(notes[index].noteID),
        onDismissed: (direction) {
          setState(() {});
        },
        background: deleteBkg(index),
        direction: DismissDirection.startToEnd,
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.black),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  cardTitle(index, context),
                  cardButtons(index),
                ],
              ),
            )),
      ),
    );
  }

  Padding cardButtons(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              // widget.editTask(widget.todoController.activeTask[index]);
            },
          ),
          RoundCheckBox(
            borderColor: Colors.white,
            checkedColor: Colors.white,
            uncheckedWidget: Container(
              color: Colors.white,
              child: Icon(
                Icons.radio_button_off_rounded,
                color: Colors.black,
              ),
            ),
            checkedWidget: Container(
              color: Colors.white,
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.black,
              ),
            ),
            onTap: (selected) {
              setState(() {
                // widget.todoController
                //     .toggleDone(widget.todoController.activeTask[index]);
                // Timer(Duration(milliseconds: 1000), () {});
              });
            },
          ),
        ],
      ),
    );
  }

  Expanded cardTitle(int index, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(minHeight: 40),
              // color: Colors.pink,
              child: Text(
                notes[index].noteTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              // color: Colors.red,
              height: 40,
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    formatDateTime(notes[index].latestEditDateTime),
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
