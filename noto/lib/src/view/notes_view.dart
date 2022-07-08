// ignore_for_file: prefer_const_constructors, avoid_print, unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noto/src/models/api_response.dart';
import 'package:noto/src/services/notes_service.dart';
import 'package:noto/src/view/form.dart';
import 'package:noto/src/widgets/note_card.dart';

import '../models/note_for_listing.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  NotesService get service => GetIt.I<NotesService>();

  late APIResponse<List<NoteForListing>> _apiResponse;

  bool _isLoading = false;

  _fetchNotes() async {
    _isLoading = true;

    _apiResponse = await service.getNotesList();
    setState(() {
      _isLoading = false;
    });
  }

  int? tempIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: appTitle(context),
        backgroundColor: Theme.of(context).primaryColor,
        body: appBody(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: appFloatingButton(context),
      ),
    );
  }

  FloatingActionButton appFloatingButton(context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showAddTaskModal(context: context);
        setState(() {});
      },
      label: Text(
        "Add Notes",
        style: TextStyle(
          letterSpacing: .5,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      icon: Icon(Icons.add_box_rounded),
    );
  }

  Widget appBody(BuildContext context) {
    return Builder(builder: (_) {
      if (_isLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (_apiResponse.error) {
        return Center(child: Text(_apiResponse.errorMessage));
      }

      return Center(
        child: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: NoteCard(
                showAddTaskModal: showAddTaskModal,
                fetchNotes: _fetchNotes(),
                apiResponse: _apiResponse,
              ),
            ),
          ),
        ]),
      );
    });
  }

  AppBar appTitle(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Nōto',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  showAddTaskModal({context, id = ""}) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (_) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: id == "" ? TaskForm() : TaskForm(noteID: id),
        );
      },
    );
  }
}
