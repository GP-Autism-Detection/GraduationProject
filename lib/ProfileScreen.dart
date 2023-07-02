import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'Localization/localiation_checker.dart';
import 'Provider/theme_provider.dart';
import 'firebaseStorage.dart';
import 'User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;

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
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Profile_MyProfile'.tr()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: () {
              provider.toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              LocalizationChecker.changeLanguage(context);
            },
          )
        ],
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
                            'Profile_Hello'.tr(),
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
                          'Profile_Name:'.tr(),
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
                          'Profile_Email:'.tr(),
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
                          'Profile_Password:'.tr(),
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
                            hintText:
                                _passwordVisible ? user!.password : "********",
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
                          height: 60.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      print('Profile_Save:'.tr());
                                      User newuser = user!.copyWith(
                                        password: passwordcontroller.text,
                                        name: namecontroller.text,
                                      );
                                      await firebaseStorage()
                                          .uploadUserData(user: newuser);
                                      await firebaseStorage().updateUserData(
                                          user: user!, newuser: newuser);
                                      setState(() {});
                                      Get.to(() => LoginScreen(),
                                          transition: Transition.downToUp,
                                          duration:
                                          Duration(milliseconds: 500));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (_) => LoginScreen()));
                                    },
                                    padding: EdgeInsetsDirectional.symmetric(
                                        vertical: 0, horizontal: 130),
                                    color: Colors.blue[500],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Text(
                                      'Profile_Save:'.tr(),
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      pref.remove("ID");

                                      setState(() {});
                                      Get.to(() => LoginScreen(),
                                          transition: Transition.downToUp,
                                          duration:
                                              Duration(milliseconds: 500));
                                      // Navigator.of(context, rootNavigator: true)
                                      //     .pushAndRemoveUntil(
                                      //   MaterialPageRoute(
                                      //     builder: (BuildContext context) {
                                      //       return LoginScreen();
                                      //     },
                                      //   ),
                                      //   (_) => false,
                                      // );
                                    },
                                    padding: EdgeInsetsDirectional.symmetric(
                                        vertical: 0, horizontal: 120),
                                    color: Colors.red[500],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Text(
                                      'Profile_Log_Out:'.tr(),
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   child: Consumer<ThemeProvider>(
                        //     builder: (context,provider,child) {
                        //       return DropdownButton<String>(
                        //       value: provider.currentTheme,
                        //         items: const [
                        //           DropdownMenuItem<String>(
                        //             value: 'light',
                        //             child: Text(
                        //               'Light',
                        //             ),
                        //           ),
                        //           DropdownMenuItem<String>(
                        //             value: 'dark',
                        //             child: Text('Dark',),
                        //           ),
                        //           DropdownMenuItem<String>(
                        //             value: 'system',
                        //             child: Text(
                        //               'System',
                        //             ),
                        //           ),
                        //         ],
                        //         onChanged: (String? value) {
                        //         provider.changeTheme(value??'system');
                        //         },
                        //       );
                        //         }),
                        //   ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
