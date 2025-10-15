import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> getUser(String id) async {
    final snapshot = await _db.collection('users').doc(id).get();
    if (snapshot.exists) {
      return User.fromFirestore(snapshot, null);
    }
    return null;
  }
}
