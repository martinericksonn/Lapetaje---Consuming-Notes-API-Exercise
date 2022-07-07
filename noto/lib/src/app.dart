import 'package:flutter/material.dart';
import 'package:noto/src/theme.dart';
import 'package:noto/src/view/notes_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NotesView(),
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
    );
  }
}
