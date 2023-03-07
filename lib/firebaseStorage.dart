import 'User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';

class firebaseStorage{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  fb.FirebaseAuth firebaseAuth = fb.FirebaseAuth.instance;

  Future<User> getUserData() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    User user = User.fromMap(snapshot.data() as dynamic);
    return user;
  }

  Future uploadUserData({required User user}) async {
    await firebaseFirestore
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.data);
  }
}