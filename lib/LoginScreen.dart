import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_app/OTPGeneratorScreen.dart';
import 'package:graduation_project_app/RegisterScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rive/rive.dart';
import 'package:get/get.dart' hide Trans;
import 'MenuScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth Auth = FirebaseAuth.instance; // server auth db
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  @override
  void initstate() {
    super.initState();
    Auth.authStateChanges().listen((User) {
      if (User == null) {
        print("no user");
      } else {
        print("there is a user");
      }
    });
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  var isPassword = true;

  @override
  Widget build(BuildContext context) {
    final Size Screensize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final AlertValue = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Alert"),
                content: const Text("Do you want to Exit ?"),
                actions: [
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No"),
                  ),
                  FilledButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text("Exit"),
                  )
                ],
              );
            });
        if (AlertValue != null) {
          return Future.value(AlertValue);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        //backgroundColor: Color(0xffD6E2EA),
        //appBar: AppBar(
        // title: Text('Login', style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,),),
        //),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: FormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Container(
                          width: Screensize.width,
                          height: 200,
                          child: RiveAnimation.asset(
                            'assets/Animations/animated-login-screen.riv',
                            stateMachines: const ["Login Machine"],
                            onInit: (artboard) {
                              controller = StateMachineController.fromArtboard(
                                  artboard, "Login Machine");
                              if (controller == null) return;
                              artboard.addController(controller!);
                              isChecking = controller?.findInput("isChecking");
                              isHandsUp = controller?.findInput("isHandsUp");
                              trigSuccess =
                                  controller?.findInput("trigSuccess");
                              trigFail = controller?.findInput("trigFail");
                            },
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    //SizedBox(height: 10.0), // masaf ben login w textbox
                    TextFormField(
                      onChanged: (value) {
                        if (isHandsUp != null) {
                          isHandsUp!.change(false);
                        }
                        if (isChecking == null) return;
                        isChecking!.change(true);
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Login_Email'
                              .tr(), // aw hint text bs bttshal lma tktb
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email) // icon fl a5er posticon
                          ),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (String value) {
                        // aw onchanged be return ay change
                        print(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Login_Email_Validation'.tr();
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Login_Email_validation2".tr();
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 15,
                    ), // space fe el col --> height
                    TextFormField(
                      onChanged: (value) {
                        if (isChecking != null) {
                          isChecking!.change(false);
                        }
                        if (isHandsUp == null) return;
                        isHandsUp!.change(true);
                      },
                      controller:
                          passwordController, // return el value le gwa el textbox
                      decoration: InputDecoration(
                          labelText: 'Login_Password'
                              .tr(), // aw hint text bs bttshal lma tktb
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                          prefixIcon:
                              Icon(Icons.lock), // icon fl a5er suffixicon

                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            child: Icon(isPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isPassword,
                      onFieldSubmitted: (String value) {
                        // aw onchanged be return ay change
                        print(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Login_Password_Validation'.tr();
                        }
                        //  if (value!.length > 0 && value!.length < 8) {
                        //  return ' password must be larger than 8 digits';
                        //}
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: FilledButton(
                        onPressed: () async {
                          if (FormKey.currentState!.validate()) {
                            try {
                              UserCredential Credentail =
                                  await Auth.signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              isHandsUp!.value = false;
                              isChecking!.value = false;
                              pref.setString("ID", "useremail@gmail.com");
                              Get.to(() => MenuScreen(),
                                  transition: Transition.rightToLeft,
                                  duration: Duration(milliseconds: 500));
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => MenuScreen()),
                              // );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'wrong-password') {
                                print('Login_wrong_pass'.tr());
                                final snackBar1 = SnackBar(
                                  content: Text('Login_wrong_pass'.tr()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar1);
                              } else if (e.code == 'user-not-found') {
                                print('Login_wrong_user'.tr());
                                final snackBar2 = SnackBar(
                                  content:
                                      Text('Login_wrong_user_SnackBar'.tr()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar2);
                              }
                              isHandsUp!.value = false;
                              isChecking!.value = false;
                              trigFail!.value = true;
                            }
                            print(emailController.text);
                            print(passwordController.text);
                          }
                        },
                        child: Text(
                          'Login_Login'
                              .tr(), // mafe4 width so wrap to container
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ), // onPressed ---> annonumse func --> (){}
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Login_no_account'.tr()),
                        TextButton(
                            onPressed: () {
                              Get.to(() => RegisterScreen(),
                                  transition: Transition.rightToLeftWithFade);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => RegisterScreen()),
                              // );
                            },
                            child: Text('Login_register'.tr(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary))),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Login_forget_pass'.tr()),
                        TextButton(
                            onPressed: () {
                              Get.to(() => OTPGeneratorScreen(),
                                  transition: Transition.rightToLeftWithFade);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => OTPGeneratorScreen()),
                              // );
                            },
                            child: Text('Login_pass_reset'.tr(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
