import 'dart:convert';
import 'package:flutter/material.dart';

class Note {
  final String content;
  final Color color;
  final bool isImportant;

  Note({
    required this.content,
    required this.color,
    required this.isImportant,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'color': color.value,
      'isImportant': isImportant,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      content: map['content'],
      color: Color(map['color']),
      isImportant: map['isImportant'],
    );
  }

  static String encode(List<Note> notes) => json.encode(
        notes.map<Map<String, dynamic>>((note) => note.toMap()).toList(),
      );

  static List<Note> decode(String notes) =>
      (json.decode(notes) as List<dynamic>)
          .map<Note>((item) => Note.fromMap(item))
          .toList();
}
