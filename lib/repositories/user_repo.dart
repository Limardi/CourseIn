import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ss/model/user.dart';


class UserRepo{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> streamUser(String userId) {
    return _db
          .collection('apps/coursein/users')
          .doc(userId)
          .snapshots()
          .map((snapshot){
            return snapshot.data() == null
              ? null
              : User.fromMap(snapshot.data()!,snapshot.id);
          });
  }

  Future<void> createOrUpdateUser(User user) async {
    Map<String, dynamic> userMap = user.toMap();
    try{
      await _db
        .collection('apps/coursein/users')
        .doc(user.id)
        .set(userMap); // write to local cache immediately
    }
    catch(e){
      print('Error updating user: $e');
    }
    
  }

  Future<User?> getUserByEmail(String email) async {
    QuerySnapshot querySnapshot = await _db
          .collection('apps/coursein/users')
          .where('email', isEqualTo: email)
          .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    return User.fromMap(querySnapshot.docs.first.data() as Map<String, dynamic>,
        querySnapshot.docs.first.id);
  }

}