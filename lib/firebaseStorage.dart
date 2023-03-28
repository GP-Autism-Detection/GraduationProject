import 'User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:graduation_project_app/Centers.dart';

class firebaseStorage {
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

  Future<List<centers>> getAllData() async {
    List<centers> center = [];
    await firebaseFirestore.collection("Centers").get().then((value) {
      for (var element in value.docs) {
        center.add(centers.fromMap(element.data()));
      }
    });
    return center;
  }

  Future uploadUserData({required User user}) async {
    await firebaseFirestore
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.data);
  }

  Future updateUserData({required User user, required User newuser}) async {
    print(newuser.email);
    print(newuser.password);
    await firebaseAuth
        .signInWithEmailAndPassword(email: user.email, password: user.password)
        .then((userCredential) {
      userCredential.user!.updateEmail(newuser.email);
      userCredential.user!.updatePassword(newuser.password);
    });
    await firebaseAuth.signOut();
  }

  Future uploadCenterData({required centers center}) async {
    await firebaseFirestore.collection("Centers").doc().set(center.data);
  }
}
