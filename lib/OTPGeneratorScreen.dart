import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/OTPVerificationScreen.dart';

class OTPGeneratorScreen extends StatelessWidget {

  var emailController = TextEditingController();

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
                ),
                // space fe el col --> height

                SizedBox( height: 15,),
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: MaterialButton(onPressed: (){
                    print(emailController.text);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
                    );

                  },
                    child: Text(
                      'Send an OTP to your Email',           // mafe4 width so wrap to container
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
    );
  }
}
