import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes_provider.dart';
import 'note_detail_screen.dart';
import 'calendar_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notesProvider.notes.length,
        itemBuilder: (context, index) {
          final note = notesProvider.notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.creationDate.toString().substring(0, 10)),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                notesProvider.deleteNote(note);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteDetailScreen()),
          );
        },
      ),
    );
  }
}
