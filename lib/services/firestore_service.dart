import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getCollectionData(
      String collectionPath) async {
    QuerySnapshot querySnapshot = await _db.collection(collectionPath).get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<Map<String, dynamic>?> getDocumentData(
      String collectionPath, String documentId) async {
    DocumentSnapshot documentSnapshot =
        await _db.collection(collectionPath).doc(documentId).get();
    return documentSnapshot.data() as Map<String, dynamic>?;
  }
}
