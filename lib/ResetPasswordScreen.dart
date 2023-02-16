import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/OTPGeneratorScreen.dart';
import 'package:graduation_project_app/OTPVerificationScreen.dart';
import 'package:graduation_project_app/OTPVerifyToResetPass.dart';

class ResetPasswordScreen extends StatefulWidget {

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var ConfirmpasswordController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  var isPassword = true;
  var isPassword2 = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  Image(image: NetworkImage('https://as1.ftcdn.net/v2/jpg/04/42/13/34/1000_F_442133421_UZGoJYPf2cLEPZTBmgeZabNLzgoiAyGg.jpg')),
                  //Text('Login', style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,),),
                  SizedBox(height : 40.0),     // masaf ben login w textbox
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Please Enter your Email Address',    // aw hint text bs bttshal lma tktb
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)                          // icon fl a5er posticon
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (String value){            // aw onchanged be return ay change
                      print(value);
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'email address must not be empty';
                      }
                      return null;
                    },
                  ),
                  // space fe el col --> height
                  SizedBox( height: 15,),
                  TextFormField(
                    controller: passwordController,       // return el value le gwa el textbox
                    decoration: InputDecoration(
                        labelText: 'Please Create your Password',    // aw hint text bs bttshal lma tktb
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock), // icon fl a5er suffixicon
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          child: Icon(isPassword ? Icons.visibility : Icons.visibility_off),
                        )
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isPassword,
                    onFieldSubmitted: (String value){            // aw onchanged be return ay change
                      print(value);
                    },
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'password must not be empty';
                      }
                      if (value!.length > 0 && value!.length < 8) {
                        return ' password must be larger than 8 digits';
                      }
                      if(passwordController.text != ConfirmpasswordController.text){
                        return 'Password are not identical';
                      }

                      return null;
                    },
                  ),
                  SizedBox( height: 15,),
                  TextFormField(
                    controller: ConfirmpasswordController,       // return el value le gwa el textbox
                    decoration: InputDecoration(
                        labelText: 'Please Confirm your Password',    // aw hint text bs bttshal lma tktb
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock), // icon fl a5er suffixicon
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              isPassword2 = !isPassword2;
                            });
                          },
                          child: Icon(isPassword2 ? Icons.visibility : Icons.visibility_off),
                        )
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isPassword2,
                    onFieldSubmitted: (String value){            // aw onchanged be return ay change
                      print(value);
                    },
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'password must not be empty';
                      }
                      if (value!.length > 0 && value!.length < 8) {
                        return ' password must be larger than 8 digits';
                      }
                      if(passwordController.text != ConfirmpasswordController.text){
                        return'Password are not identical ';
                      }

                      return null;
                    },
                  ),
                  SizedBox( height: 15,),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(onPressed: (){
                      if(FormKey.currentState!.validate() ) {
                        print(emailController.text);
                        print(passwordController.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
                        );
                      }


                    },
                      child: Text(
                        'Reset Password',           // mafe4 width so wrap to container
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),                 // onPressed ---> annonumse func --> (){}

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
