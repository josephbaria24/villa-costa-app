// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fitness_tracker/model/note_model.dart';
import 'note_storage.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _controller = TextEditingController();
  Color selectedColor = Colors.yellow;
  bool isImportant = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your note...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
              _colorOption(Color(0xFFFFF9C4)), // Pastel Yellow
              _colorOption(Color(0xFFC8E6C9)), // Pastel Green
              _colorOption(Color(0xFFF8BBD0)), // Pastel Pink
              _colorOption(Color(0xFFBBDEFB)), // Pastel Blue
              _colorOption(Color(0xFFFFE0B2)), // Pastel Orange

              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mark as Important"),
                  Switch(
                    value: isImportant,
                    onChanged: (val) => setState(() => isImportant = val),
                  )
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newNote = Note(
                  content: _controller.text,
                  color: selectedColor,
                  isImportant: isImportant,
                );

                final notes = await NoteStorage.loadNotes();
                notes.add(newNote);
                await NoteStorage.saveNotes(notes);

                Navigator.pop(context, {
                  'text': _controller.text,
                  'color': selectedColor,
                  'isImportant': false, // Or true if you allow setting this
                });
                // Go back to previous screen
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  Widget _colorOption(Color color) {
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: CircleAvatar(
        backgroundColor: color,
        radius: selectedColor == color ? 25 : 20,
        child: selectedColor == color ? Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
