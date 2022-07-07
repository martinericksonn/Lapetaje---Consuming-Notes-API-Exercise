class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  NoteForListing({
    required this.noteID,
    required this.noteTitle,
    required this.latestEditDateTime,
    required this.createDateTime,
  });
}
