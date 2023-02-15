import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login', style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,),),
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
                SizedBox( height: 15,),        // space fe el col --> height
                TextFormField(
                  controller: passwordController,       // return el value le gwa el textbox
                  decoration: InputDecoration(
                      labelText: 'Please Enter your Password',    // aw hint text bs bttshal lma tktb
                      border:OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock), // icon fl a5er suffixicon
                      suffixIcon: Icon(Icons.remove_red_eye)
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onFieldSubmitted: (String value){            // aw onchanged be return ay change
                    print(value);
                  },
                ),
                SizedBox( height: 15,),
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: MaterialButton(onPressed: (){
                      print(emailController.text);
                      print(passwordController.text);
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
                    Text('Don\'t have an account?'),
                    TextButton(onPressed: ( ){

                    }, child:
                        Text('Register Now')
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
