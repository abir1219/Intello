import '../../domain/entity/lecture.dart';

class LectureModel extends Lecture {
  const LectureModel({
    required super.pdfTitle,
    required super.pdfUrl,
    required super.isRead,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      pdfTitle: json['pdfTitle'],
      pdfUrl: json['pdfUrl'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pdfTitle": pdfTitle,
      "pdfUrl": pdfUrl,
      "isRead": isRead,
    };
  }
}