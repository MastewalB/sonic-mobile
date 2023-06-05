import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/auth/auth.dart';
import 'package:sonic_mobile/features/auth/blocs/signup_bloc/signup_bloc.dart';
import 'package:sonic_mobile/features/library/presentation/library_page.dart';

import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "signup";

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool validated = true;
  bool emailValidator = true;
  bool passwordValidator = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    DateTime? dateOfBirth;

    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, LibraryPage.routeName);
          });
        }

        if (state.status.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          // backgroundColor: Colors.black,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 25),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: Text(
                      "Create new account",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: usernameController,
                      decoration: InputDecoration(
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
                        filled: true,
                        fillColor: Color.fromARGB(97, 80, 73, 73),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: firstNameController,
                      decoration: InputDecoration(
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
                        filled: true,
                        fillColor: Color.fromARGB(97, 80, 73, 73),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        labelText: 'First Name',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: lastNameController,
                      decoration: InputDecoration(
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
                        filled: true,
                        fillColor: Color.fromARGB(97, 80, 73, 73),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        labelText: 'Last Name',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: DateTimeFormField(
                      decoration: InputDecoration(
                          errorText:
                              !validated ? 'Value Can\'t Be Empty' : null,
                          hintStyle: TextStyle(color: Colors.white),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          filled: true,
                          fillColor: Color.fromARGB(97, 80, 73, 73),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                          suffixIcon: Icon(
                            Icons.event_note,
                            color: Colors.white,
                          ),
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(color: Colors.white)),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 500000)),
                      // lastDate: DateTime.now().add(const Duration(days: 40)),
                      // initialDate: DateTime.now().add(const Duration(days: 20)),
                      autovalidateMode: AutovalidateMode.always,
                      mode: DateTimeFieldPickerMode.date,
                      // validator: (DateTime? e) => (e?.day ?? 0) == 1
                      //     ? 'Please not the first day'
                      //     : null,
                      onDateSelected: (DateTime value) {
                        dateOfBirth = value;
                        print(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: countryController,
                      decoration: InputDecoration(
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
                        filled: true,
                        fillColor: Color.fromARGB(97, 80, 73, 73),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        labelText: 'Country',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: emailController,
                      decoration: InputDecoration(
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
                        filled: true,
                        fillColor: Color.fromARGB(97, 80, 73, 73),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
                        filled: true,
                        fillColor: Color.fromARGB(97, 80, 73, 73),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
                        filled: true,
                        fillColor: Color.fromARGB(97, 80, 73, 73),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        foregroundColor: (Colors.white),
                        backgroundColor: Colors.blue,
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: () {
                      if (usernameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          countryController.text.isEmpty ||
                          firstNameController.text.isEmpty ||
                          lastNameController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty ||
                          confirmPasswordController.text
                                  .compareTo(passwordController.text) !=
                              0 ||
                          dateOfBirth == null) {
                        setState(() {
                          validated = false;
                        });
                      } else {
                        context.read<SignupBloc>().add(
                              SignUpSubmitEvent(
                                username: usernameController.value.text,
                                firstName: firstNameController.value.text,
                                lastName: lastNameController.value.text,
                                country: countryController.value.text,
                                dateOfBirth:
                                    "${dateOfBirth!.year}-${dateOfBirth!.month}-${dateOfBirth!.day}",
                                email: emailController.value.text,
                                password: passwordController.value.text,
                              ),
                            );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: (state.status.isLoading)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text('Sign Up'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routeName);
                        });
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Already a member?  ',
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                              text: 'Login to your account',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
