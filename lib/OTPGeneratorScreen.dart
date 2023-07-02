import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/LoginScreen.dart';
import 'package:graduation_project_app/RegisterScreen.dart';
import 'package:get/get.dart' hide Trans;

class OTPGeneratorScreen extends StatelessWidget {
  FirebaseAuth Auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Image(
                      image: NetworkImage(
                          'https://as1.ftcdn.net/v2/jpg/04/42/13/34/1000_F_442133421_UZGoJYPf2cLEPZTBmgeZabNLzgoiAyGg.jpg')),
                  //Text('Login', style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 40.0), // masaf ben login w textbox
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Pass_reset_Email'
                            .tr(), // aw hint text bs bttshal lma tktb
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
                        return 'Pass_reset_Email_Validation'.tr();
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Pass_reset_Email_Validation2".tr();
                      }
                      return null;
                    },
                  ),
                  // space fe el col --> height

                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        if (FormKey.currentState!.validate()) {
                          try {
                            await Auth.sendPasswordResetEmail(
                                email: emailController.text.trim());
                            final snackBar = SnackBar(
                              content: Text('Pass_reset_Successfully'.tr()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Get.to(() => LoginScreen(),
                                transition: Transition.leftToRight,
                                duration: Duration(milliseconds: 500));
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => LoginScreen()),
                            // );
                          } on FirebaseAuthException catch (e) {
                            print('auth/user-not-found');
                            final snackBar = SnackBar(
                                content: Text('Pass_reset_EmailNotFound'.tr()),
                                action: SnackBarAction(
                                  label: 'Pass_reset_Register'.tr(),
                                  onPressed: () {
                                    Get.to(() => RegisterScreen(),
                                        transition: Transition.rightToLeft,
                                        duration: Duration(milliseconds: 500));
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           RegisterScreen()),
                                    // );
                                    // Some code to undo the change.
                                  },
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          print(emailController.text);
                        }
                      },
                      child: Text(
                        'Pass_reset_Send_Link'
                            .tr(), // mafe4 width so wrap to container
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ), // onPressed ---> annonumse func --> (){}
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
