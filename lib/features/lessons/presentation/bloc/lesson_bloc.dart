import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intello_new/features/lessons/data/models/lesson_model.dart';

import '../../domain/entities/lesson.dart';
import '../../domain/usecases/get_lessons_usecase.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {

  final GetSubjectsUseCase getSubjectsUseCase;

  LessonBloc(this.getSubjectsUseCase) : super(LessonInitial()) {
    on<LoadLessonsEvent>((event, emit) async{
      emit(LessonLoading());

      try {
        final lessons = await getSubjectsUseCase(event.subject,event.levelCode);
        print("lessons==>$lessons");
        emit(LessonLoaded(lessons));
      } catch (e) {
        print("Error==>$e");
        emit(LessonError(e.toString()));
      }
    });
  }
}
