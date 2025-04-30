// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Color selectedColor = Colors.white;
  bool isFabExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: selectedColor,
        leading: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey.withOpacity(0.08),
            ),
            child: Center(
              child: Transform.translate(
                offset: Offset(2, 0),
                child: Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey.withOpacity(0.08),
              ),
              child: IconButton(
                icon: Icon(Icons.check_rounded, color: Colors.black),
                onPressed: () {
                  final title = _titleController.text.trim();
                  final content = _contentController.text.trim();

                  if (title.isEmpty && content.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Note is empty")),
                    );
                    return;
                  }

                  // Save logic here (replace with your actual storage call)
                  print("Saved Note: $title - $content");

                  // Example: Navigator.pop to go back after saving
                  Navigator.pop(context, {
                    'title': title,
                    'text': content,
                    'color': selectedColor,
                    'isImportant': false,
                  });
                  },

              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Type your note...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        height: 56,
        width: isFabExpanded ? 320 : 56,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          label: isFabExpanded
              ? Row(
                  children: [
                    _toolIcon(Icons.image, () {}),
                    _toolIcon(Icons.text_fields, () {}),
                    _toolIcon(Icons.attach_file, () {}),
                    _toolIcon(Icons.format_list_bulleted, () {}),
                    _toolIcon(Icons.color_lens, _showColorPicker),
                  ],
                )
              : Icon(Icons.add, color: Colors.white,),
          onPressed: () {
            setState(() => isFabExpanded = !isFabExpanded);
          },
        ),
      ),
    );
  }

  Widget _toolIcon(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onPressed,
    );
  }

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 10,
          children: [
            _colorOption(Color.fromRGBO(236, 223, 204, 1)),
            _colorOption(Color.fromRGBO(255, 180, 162, 1)),
            _colorOption(Color.fromRGBO(149, 210, 179, 1)),
            _colorOption(Color(0xFFBBDEFB)),
            _colorOption(Color(0xFFFFE0B2)),
          ],
        ),
      ),
    );
  }

  Widget _colorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
        Navigator.pop(context);
      },
      child: CircleAvatar(
        backgroundColor: color,
        radius: selectedColor == color ? 25 : 20,
        child: selectedColor == color ? Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
