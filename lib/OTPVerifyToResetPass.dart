import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/ResetPasswordScreen.dart';

class OTPVerifyToResetPass extends StatelessWidget {

  var OtpController = TextEditingController();

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
                  controller: OtpController,
                  decoration: InputDecoration(
                      labelText: 'Please Enter the Verification Code',    // aw hint text bs bttshal lma tktb
                      border:OutlineInputBorder(),
                      prefixIcon: Icon(Icons.verified)                          // icon fl a5er posticon
                  ),
                  keyboardType: TextInputType.number,
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
                    print(OtpController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                    );

                  },
                    child: Text(
                      'Verify',           // mafe4 width so wrap to container
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
