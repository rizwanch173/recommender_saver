import 'package:recommender_saver/data/service/note_service.dart';
import 'package:recommender_saver/hive/notes.dart';

import '../home/model/notes_model.dart';

class NoteRepository {
  final NoteService _service;

  NoteRepository(this._service);

  Future<List<NoteModel>> fetchAllNotes() async =>
      await _service.fetchAllNotes();

  Future<void> createNote({required NoteModel note}) async =>
      await _service.createNote(note);
}
