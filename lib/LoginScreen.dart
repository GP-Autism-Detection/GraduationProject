import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/OTPGeneratorScreen.dart';
import 'package:graduation_project_app/RegisterScreen.dart';

import 'MenuScreen.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FirebaseAuth Auth = FirebaseAuth.instance;    // server auth db
  @override
  void initstate(){
    super.initState();
    Auth.authStateChanges().listen((User) {
      if(User == null) {
        print("no user");
      }
        else{
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
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),

                  SizedBox( height: 15,),        // space fe el col --> height
                  TextFormField(
                    controller: passwordController,       // return el value le gwa el textbox
                    decoration: InputDecoration(
                        labelText: 'Please Enter your Password',    // aw hint text bs bttshal lma tktb
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
                    //  if (value!.length > 0 && value!.length < 8) {
                      //  return ' password must be larger than 8 digits';
                      //}
                      return null;
                    },

                  ),
                  SizedBox( height: 15,),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(onPressed: () async{
                      if(FormKey.currentState!.validate() ) {

                        try{
                          UserCredential Credentail = await Auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuScreen()),
                          );
                        }on FirebaseAuthException catch(e){
                          if(e.code == 'wrong-password'){
                            print('wrong password');
                            final snackBar1 = SnackBar(
                              content: const Text('Wrong Passwsord'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                          }
                          else if(e.code == 'user-not-found'){
                            print('User not found');
                            final snackBar2 = SnackBar(
                              content: const Text('User not registered'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                          }
                        }


                        print(emailController.text);
                        print(passwordController.text);

                      }
                    },
                    child: Text(
                      'LOGIN',           // mafe4 width so wrap to container
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    ),
                  ),                 // onPressed ---> annonumse func --> (){}
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account ?'),
                      TextButton(onPressed: ( ){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      }, child:
                          Text('Register Now')
                      ),

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Forgot your Password ?'),
                      TextButton(onPressed: ( ){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OTPGeneratorScreen()),
                        );
                      }, child:
                      Text('Reset Password')
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
