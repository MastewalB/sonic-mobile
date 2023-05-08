import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(100, 150, 100, 25),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter your email',
                  icon: Icon(Icons.email,
                             color: Colors.white,),
                ),
                
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter your password',
                  hintStyle:TextStyle(color: Colors.blue),
                  icon: Icon(Icons.lock,
                            color: Colors.white,),
                ),
                
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  foregroundColor: (Colors.white),
                  backgroundColor: Colors.blue, 
                  minimumSize: const Size.fromHeight(50)
  ),
                onPressed: () {
                  
                },
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('Log in'),)
              ),
              Padding (
                padding: EdgeInsets.all(15),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Forgot your Password?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),),
              Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child:RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Dont have an account?  ', 
                        style: TextStyle(color: Colors.white)),
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),),
              
            ],
          ),
        ),
      ),
    );
  }
}
       
    

