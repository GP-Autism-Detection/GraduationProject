import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/LoginScreen.dart';
import 'package:graduation_project_app/RegisterScreen.dart';

class OTPGeneratorScreen extends StatelessWidget {

  FirebaseAuth Auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var FormKey = GlobalKey<FormState>();

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
                  // space fe el col --> height

                  SizedBox( height: 15,),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(onPressed: ()async{
                      if(FormKey.currentState!.validate() ) {
                        try{
                          await Auth.sendPasswordResetEmail(email: emailController.text.trim());
                          final snackBar = SnackBar(
                            content: const Text('Email has been sent successfuly, reset password and login!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        }on FirebaseAuthException catch(e){
                             print ('auth/user-not-found');
                             final snackBar = SnackBar(
                               content: const Text('this mail not registered'),
                                 action: SnackBarAction(
                                   label: 'Register Now!',
                                   onPressed: () {
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => RegisterScreen()),
                                     );
                                     // Some code to undo the change.
                                   },
                                 )
                             );
                             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        print(emailController.text);

                      }
                    },
                      child: Text(
                        'Send a Link to your Email',           // mafe4 width so wrap to container
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
