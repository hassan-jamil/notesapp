import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
  final String title;
  final String content;
  final DateTime creationDate;

  Note({
    required this.title,
    required this.content,
    required this.creationDate,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'creationDate': creationDate.toIso8601String(),
  };

  static Note fromJson(Map<String, dynamic> json) => Note(
    title: json['title'],
    content: json['content'],
    creationDate: DateTime.parse(json['creationDate']),
  );
}

class NotesProvider with ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> addNote(Note note) async {
    _notes.add(note);
    await saveNotes();
    notifyListeners();
  }

  Future<void> deleteNote(Note note) async {
    _notes.remove(note);
    await saveNotes();
    notifyListeners();
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_notes.map((note) => note.toJson()).toList());
    await prefs.setString('notes', jsonString);
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('notes');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _notes.clear();
      _notes.addAll(jsonList.map((json) => Note.fromJson(json)).toList());
      notifyListeners();
    }
  }
}
