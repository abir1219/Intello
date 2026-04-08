
import '../../domain/entities/lecture.dart';

class LectureModel extends Lecture {

  const LectureModel({
    required super.pdf,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      pdf: json['pdf_url'],
    );
  }
}
