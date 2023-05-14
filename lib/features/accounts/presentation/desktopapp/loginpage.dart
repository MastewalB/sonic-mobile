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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/album4.jpeg"),
            fit: BoxFit.cover,
          ),),
        alignment: Alignment.center,
        child: Card(
          color: Colors.black,
          child: SizedBox(
            width:500.0,
            height: 500.0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'SONIC ', 
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                        fillColor: Color.fromARGB(97, 80, 73, 73),
                        enabledBorder: OutlineInputBorder( 
                          borderSide: BorderSide(color: Colors.blueGrey ),                   
                          
                        ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter your email',
                          hintStyle:TextStyle(color: Colors.blue),
                          icon: Icon(Icons.email,
                                     color: Colors.white,),
                        ),
                        
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(97, 80, 73, 73),
                          enabledBorder: OutlineInputBorder( 
                            borderSide: BorderSide(color: Colors.blueGrey ),                   
                            
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter your password',
                          hintStyle:TextStyle(color: Colors.blue),
                          icon: Icon(Icons.lock,
                                    color: Colors.white,),
                        ),
                        
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
                    Padding(padding: EdgeInsets.fromLTRB(0, 65, 0, 0),
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
          ),
        ),
      ),
    );
  }
}
       
    

