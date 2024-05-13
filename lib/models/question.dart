import 'package:cosmo_quest/models/photo.dart';

class Question {
  String title;
  String answer;
  Photo photo;

  Question({required this.title, required this.answer, required this.photo});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      title: json['title'],
      answer: json['answer'],
      photo: Photo.fromJson(json['photo']),
    );
  }
}
