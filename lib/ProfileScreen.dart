import 'package:flutter/material.dart';
import 'firebaseStorage.dart';
import 'User.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  _getData() async{
    user = await firebaseStorage().getUserData();
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user == null ? CircularProgressIndicator() : Text(user!.name),
    );
  }
}
