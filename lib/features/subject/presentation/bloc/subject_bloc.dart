import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/subject_repository.dart';
import 'subject_event.dart';
import 'subject_state.dart';

class SubjectBloc
    extends Bloc<SubjectEvent, SubjectState> {

  final SubjectRepository repository;

  SubjectBloc(this.repository)
      : super(SubjectInitial()) {

    on<LoadSubjectsEvent>((event, emit) async {
      emit(SubjectLoading());

      try {
        final subjects =
        await repository.getSubjects(
            event.levelCode);

        emit(SubjectLoaded(subjects));
      } catch (e) {
        emit(SubjectFailure(
            "Erreur lors du chargement des sujets"));
      }
    });
  }
}