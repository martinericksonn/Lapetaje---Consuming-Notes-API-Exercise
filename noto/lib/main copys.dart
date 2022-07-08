import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:noto/src/services/notes_service.dart';

import 'src/app.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NotesService());
}

void main() async {
  setupLocator();
  runApp(const MyApp());
}
