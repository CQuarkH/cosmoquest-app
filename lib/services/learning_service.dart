import 'package:cosmo_quest/models/celestial_body.dart';
import 'package:cosmo_quest/models/question.dart';
import 'package:cosmo_quest/services/firestore_service.dart';

const CELESTIAL_BODIES_COLLECTION = 'celestialBodies';
const ANSWERS_TO_BIG_QUESTIONS_COLLECTION = 'answers';

class LearningService {
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<CelestialBody>> fetchCelestialBodies({int? limit}) async {
    try {
      final List<Map<String, dynamic>> celestialBodies = await _firestoreService
          .getCollectionData(CELESTIAL_BODIES_COLLECTION);

      if (limit != null && celestialBodies.length > limit) {
        return celestialBodies.reversed
            .toList()
            .take(limit)
            .map((bodyData) => CelestialBody.fromJson(bodyData))
            .toList();
      }
      return celestialBodies
          .map((bodyData) => CelestialBody.fromJson(bodyData))
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<CelestialBody>> findCelestialBodiesByName(String name) async {
    try {
      final List<Map<String, dynamic>> celestialBodies = await _firestoreService
          .getCollectionData(CELESTIAL_BODIES_COLLECTION);

      return celestialBodies
          .map((bodyData) => CelestialBody.fromJson(bodyData))
          .where((body) =>
              body.englishName.toLowerCase().contains(name.toLowerCase()))
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Question>> fetchAnswersToBigQuestions({int? limit}) async {
    try {
      final List<Map<String, dynamic>> questions = await _firestoreService
          .getCollectionData(ANSWERS_TO_BIG_QUESTIONS_COLLECTION);

      if (limit != null && questions.length > limit) {
        return questions.reversed
            .toList()
            .take(limit)
            .map((questionData) => Question.fromJson(questionData))
            .toList();
      }

      return questions
          .map((questionData) => Question.fromJson(questionData))
          .toList();
    } catch (error) {
      rethrow;
    }
  }
}
