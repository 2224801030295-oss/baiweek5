import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<void> loadNotes() async {
    _notes = await _db.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _db.insertNote(note);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await _db.updateNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _db.deleteNote(id);
    await loadNotes();
  }
}
