import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noto/src/app.dart';
import 'package:noto/src/models/note.dart';
import 'package:noto/src/models/note_for_listing.dart';
import 'package:noto/src/services/notes_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NotesService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}
