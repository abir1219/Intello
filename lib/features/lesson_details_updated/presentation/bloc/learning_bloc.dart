import 'package:bloc/bloc.dart';
import '../../domain/entities/level.dart';
import '../../domain/usecases/get_levels.dart';

part 'learning_event.dart';
part 'learning_state.dart';

class LearningBloc extends Bloc<LearningEvent, LearningState> {
  final GetLevels getLevels;

  LearningBloc(this.getLevels) : super(LearningInitial()) {
    on<LearningEvent>((event, emit) async {
      emit(LearningLoading());
      try {
        final data = await getLevels();
        emit(LearningLoaded(data));
      } catch (e) {
        emit(LearningError());
      }
    });
  }
}
