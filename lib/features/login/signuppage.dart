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
        padding: EdgeInsets.fromLTRB(100, 0, 100, 25),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(50, 0, 50, 100),
              child: Text("Let's get you in",
              style:TextStyle(
                fontSize:35,
                color: Colors.white))),
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
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter your username',
                ),
               
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Firstname',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter Firstname',
                ),
               
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Lastname',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter your username',
                ),
               
              ),
              DateTimeFormField(
  decoration: const InputDecoration(
    hintStyle: TextStyle(color: Colors.white),
    errorStyle: TextStyle(color: Colors.redAccent),
    border: OutlineInputBorder(),
    suffixIcon: Icon(Icons.event_note),
    labelText: 'Only time',
    labelStyle: TextStyle(color: Colors.white)
  ),
  mode: DateTimeFieldPickerMode.time,
  autovalidateMode: AutovalidateMode.always,
  validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
  onDateSelected: (DateTime value) {
    print(value);
  },
),
DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'My Super Date Time Field',
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
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Country',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter country',
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
              TextFormField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.white),
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
                  child: Text('Sign Up'),)
              ),
             
              
            ],
          ),
        ),
      ),
    );
  }
}
       
    

