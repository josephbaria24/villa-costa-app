import 'package:shared_preferences/shared_preferences.dart';
import 'package:villa_costa/model/note_model.dart';

class NoteStorage {
  static const String _key = 'notes';

  static Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = Note.encode(notes);
    await prefs.setString(_key, encoded);
  }

  static Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    return Note.decode(data);
  }
}
