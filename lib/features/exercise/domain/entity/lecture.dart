import 'package:equatable/equatable.dart';

class Lecture extends Equatable {
  final String pdfTitle;
  final String pdfUrl;
  final bool isRead;

  const Lecture({
    required this.pdfTitle,
    required this.pdfUrl,
    required this.isRead,
  });

  @override
  List<Object> get props => [pdfTitle, pdfUrl, isRead];
}