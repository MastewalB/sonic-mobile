import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:date_field/date_field.dart';

class SignUpPage extends StatelessWidget {
  //text editing controller for text field
  
  const SignUpPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('SignUp Page'),
      ),
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/album4.jpeg"),
            fit: BoxFit.cover,
          ),),
        alignment: Alignment.center,
        child: Card
        (color: Colors.black,
          child: SingleChildScrollView(
            
            padding: EdgeInsets.fromLTRB(30, 0, 30, 25),
            child: Container
          (
              child: SizedBox(
                width:500.0,
                height: 800.0,
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 50, 60),
                      child: Text("New Account",
                      style:TextStyle(
                        fontSize:20,
                        color: Colors.white))),
                      
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(97, 80, 73, 73),
                            enabledBorder: OutlineInputBorder( 
                              borderSide: BorderSide(color: Colors.blueGrey ),                   
                              
                            ),
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'Enter your username',
                          ),
                         
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(97, 80, 73, 73),
                            enabledBorder: OutlineInputBorder( 
                              borderSide: BorderSide(color: Colors.blueGrey ),
                            ),
                            labelText: 'Firstname',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'Enter Firstname',
                          ),
                         
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(97, 80, 73, 73),
                            enabledBorder: OutlineInputBorder( 
                              borderSide: BorderSide(color: Colors.blueGrey ),
                            ),
                            labelText: 'Lastname',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'Enter your username',
                          ),
                         
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              filled: true,
                            fillColor: Color.fromARGB(97, 80, 73, 73),
                            enabledBorder: OutlineInputBorder( 
                              borderSide: BorderSide(color: Colors.blueGrey ),
                            ),
                              suffixIcon: Icon(Icons.event_note,
                                                color: Colors.white,),
                              labelText: 'Date of Birth',
                              labelStyle: TextStyle(color: Colors.white)
                            ),
                            firstDate: DateTime.now().add(const Duration(days: 10)),
                            lastDate: DateTime.now().add(const Duration(days: 40)),
                            initialDate: DateTime.now().add(const Duration(days: 20)),
                            autovalidateMode: AutovalidateMode.always,
                            validator: (DateTime? e) =>
                                (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                            onDateSelected: (DateTime value) {
                              print(value);
                            },
                          ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(97, 80, 73, 73),
                            enabledBorder: OutlineInputBorder( 
                              borderSide: BorderSide(color: Colors.blueGrey ),
                            ),
                            labelText: 'Country',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'Enter country',
                          ),
                         
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                          ), 
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(97, 80, 73, 73),
                            enabledBorder: OutlineInputBorder( 
                              borderSide: BorderSide(color: Colors.blueGrey ),
                            ),
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Colors.white),
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
                          child: Text('Sign Up'),)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
       
    

