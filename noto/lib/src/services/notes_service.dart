import 'dart:convert';

import 'package:noto/src/models/api_response.dart';
import 'package:noto/src/models/note.dart';
import 'package:noto/src/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:noto/src/models/note_insert.dart';

class NotesService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': 'b94e2721-fc17-4532-b4e6-570cf8d6951d',
    'Content-Type': 'application/json'
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse('$API/notes'), headers: headers).then((data) {
      print(data.statusCode);
      if (data.statusCode == 200) {
        print("1");
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        print(jsonData.length);
        for (var item in jsonData) {
          print(item);
          print(NoteForListing.fromJson(item));
          notes.add(NoteForListing.fromJson(item));
          print("yes");
        }
        print("in2");
        var result = APIResponse<List<NoteForListing>>(data: notes);
        print(result);
        return result;
      }
      print("2");
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((error) {
      print("3");
      print(error);
      APIResponse<List<NoteForListing>>(error: true, errorMessage: error);
    });
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http
        .get(Uri.parse('$API/notes/$noteID'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<Note>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http
        .post(Uri.parse('$API/notes'),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http
        .put(Uri.parse('$API/notes/$noteID'),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http
        .delete(Uri.parse('$API/notes/$noteID'), headers: headers)
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}
