import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes_provider.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note? note;

  NoteDetailScreen({this.note});

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);

    if (note != null) {
      _titleController.text = note!.title;
      _contentController.text = note!.content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                final newNote = Note(
                  title: _titleController.text,
                  content: _contentController.text,
                  creationDate: note?.creationDate ?? DateTime.now(),
                );
                if (note == null) {
                  notesProvider.addNote(newNote);
                } else {
                  notesProvider.deleteNote(note!);
                  notesProvider.addNote(newNote);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
