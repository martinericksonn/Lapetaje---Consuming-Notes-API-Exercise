// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$NotesService extends NotesService {
  _$NotesService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NotesService;

  @override
  Future<Response<List<dynamic>>> getNotesList() {
    final $url = '/notes';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<dynamic>, List<dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> getNote(String noteID) {
    final $url = '/notes/${noteID}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createNote(dynamic item) {
    final $url = '/notes';
    final $body = item;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateNote(String noteID, dynamic item) {
    final $url = '/notes/${noteID}';
    final $body = item;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteNote(String noteID) {
    final $url = '/notes/${noteID}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
