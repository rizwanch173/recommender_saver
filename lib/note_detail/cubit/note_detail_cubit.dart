import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../home/model/notes_model.dart';
part 'note_detail_state.dart';

class NoteDetailCubit extends Cubit<NoteDetailState> {
  NoteDetailCubit() : super(NoteDetailInitial());
}
