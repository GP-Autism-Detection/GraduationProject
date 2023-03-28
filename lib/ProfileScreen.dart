import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/LoginScreen.dart';
import 'firebaseStorage.dart';
import 'User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController namecontroller;
  late TextEditingController passwordcontroller;
  User? user;
  late bool _passwordVisible;

  _getData() async {
    user = await firebaseStorage().getUserData();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
    namecontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    namecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  //user == null ? CircularProgressIndicator() : Text(user!.name)
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My profile',
        ),
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: NetworkImage(
                              'https://ouch-cdn2.icons8.com/-JZptPGuKRXkyuzdLeFBi71mdKqKYQHlVYx_4AQFhdQ/rs:fit:256:256/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNTIx/LzYyOTBlMmU4LWQ2/NmMtNDgzMS1hOWFl/LTUwNDQ3M2ZkMWZj/NS5wbmc.png',
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Hello,',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            user!.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        TextField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            hintText: user!.name,
                            hintStyle: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Email:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            enabled: false,
                            hintText: user!.email,
                            hintStyle: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Password:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        TextField(
                          controller: passwordcontroller,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            hintText: _passwordVisible? user!.password:"********",
                            hintStyle: TextStyle(
                              fontSize: 18.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.indigoAccent,
                          child: MaterialButton(
                            onPressed: () async {
                              print('Save');
                              User newuser = user!.copyWith(
                                password: passwordcontroller.text,
                                name: namecontroller.text,
                              );
                              await firebaseStorage()
                                  .uploadUserData(user: newuser);
                              await firebaseStorage().updateUserData(
                                  user: user!, newuser: newuser);
                              setState(() {});
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()));
                            },
                            child: Text(
                              'save',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.red,
                          child: MaterialButton(
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.remove("ID");

                              setState(() {});
                              Navigator.of(context, rootNavigator: true)
                                  .pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return LoginScreen();
                                  },
                                ),
                                    (_) => false,
                              );
                            },
                            child: Text(
                              'log out',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
