// ignore_for_file: must_be_immutable, prefer_const_constructors, unused_field

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get_it/get_it.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../models/api_response.dart';
import '../models/note_for_listing.dart';
import '../services/notes_service.dart';
import '../view/form.dart';
import 'note_delete.dart';

class NoteCard extends StatefulWidget {
  Function showAddTaskModal;
  Future<dynamic> fetchNotes;
  APIResponse<List<NoteForListing>> apiResponse;

  NoteCard({
    Key? key,
    required this.showAddTaskModal,
    required this.fetchNotes,
    required this.apiResponse,
  }) : super(key: key);
  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  NotesService get service => GetIt.I<NotesService>();

  APIResponse<List<NoteForListing>> get _apiResponse => widget.apiResponse;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return taskList();
  }

  @override
  void initState() {
    widget.fetchNotes;
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
    return Builder(builder: (_) {
      if (_isLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (_apiResponse.error) {
        return Center(child: Text(_apiResponse.errorMessage));
      }

      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(), //
        shrinkWrap: true,

        itemCount: _apiResponse.data!.length,
        itemBuilder: (_, index) => Dismissible(
          key: ValueKey(_apiResponse.data![index].noteID),
          onDismissed: (direction) {},
          confirmDismiss: (direction) async {
            final result = await showDialog(
                context: context, builder: (_) => NoteDelete());

            if (result) {
              final deleteResult =
                  await service.deleteNote(_apiResponse.data![index].noteID);
              var message = '';

              if (deleteResult.data == true) {
                message = 'The note was deleted successfully';
              } else {
                message = deleteResult.errorMessage;
              }
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                  duration: Duration(milliseconds: 1000)));

              return deleteResult.data ?? false;
            }
            return result;
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
                    cardButtons(context, _apiResponse.data![index].noteID),
                  ],
                ),
              )),
        ),
      );
    });
  }

  Padding cardButtons(context, id) {
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
              widget.showAddTaskModal(context: context, id: id);

              widget.fetchNotes;
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
                _apiResponse.data![index].noteTitle,
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
                    formatDateTime(
                        _apiResponse.data![index].latestEditDateTime),
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
