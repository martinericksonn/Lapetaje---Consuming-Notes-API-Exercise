import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noto/src/app.dart';
import 'package:noto/src/models/note.dart';
import 'package:noto/src/models/note_for_listing.dart';
import 'package:noto/src/services/notes_service.dart';

Future<Request> authHeaderRequestInterceptor(Request request) async {
  final headers = Map<String, String>.from(request.headers);

  headers['apiKey'] = 'e5245278-ed86-4196-81d6-cdf608b02623';

  request = request.copyWith(headers: headers);
  return request;
}

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NotesService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}
