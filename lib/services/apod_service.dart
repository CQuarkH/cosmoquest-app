import 'package:cosmo_quest/models/photo.dart';
import 'package:cosmo_quest/services/firestore_service.dart';

const String APOD_COLLECTION = "nasaAPOD";

class APODService {
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<Photo>> fetchAPODPhotos({int? limit}) async {
    try {
      List<Map<String, dynamic>> photos =
          await _firestoreService.getCollectionData(APOD_COLLECTION);

      if (limit != null && photos.length > limit) {
        return photos.reversed
            .toList()
            .take(limit)
            .map((photoData) => Photo.fromJson(photoData))
            .toList();
      }

      return photos
          .map((photoData) => Photo.fromJson(photoData))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Photo>> findPhotosByName(String name) async {
    try {
      List<Map<String, dynamic>> photos =
          await _firestoreService.getCollectionData(APOD_COLLECTION);

      return photos
          .map((photoData) => Photo.fromJson(photoData))
          .where(
              (photo) => photo.title.toLowerCase().contains(name.toLowerCase()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
