import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/auth/auth.dart';
import 'package:sonic_mobile/features/auth/blocs/login_bloc/login_bloc.dart';
import 'package:sonic_mobile/features/library/presentation/library_page.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool emailValidator = true;
  bool passwordValidator = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocBuilder<LoginBloc, LoginState>(
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
          backgroundColor: Colors.black,
          body: Container(
            padding: const EdgeInsets.fromLTRB(100, 150, 100, 25),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login to Your Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: emailController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        // hintText: 'Enter your email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        // hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.blue),
                        icon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            foregroundColor: (Colors.white),
                            backgroundColor: Colors.blue,
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () {
                          if (emailController.text.isEmpty) {
                            setState(() {
                              emailValidator = false;
                            });
                          } else if (passwordController.text.isEmpty) {
                            setState(() {
                              passwordValidator = false;
                            });
                          }
                          context.read<LoginBloc>().add(
                                LoginSubmitEvent(
                                  email: emailController.value.text,
                                  password: passwordController.value.text,
                                ),
                              );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Log in'),
                        )),
                    Padding(
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushReplacementNamed(
                              context,
                              SignUpPage.routeName,
                            );
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Dont have an account?  ',
                                  style: TextStyle(color: Colors.white)),
                              TextSpan(
                                text: 'Sign up',
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
          ),
        );
      },
    );
  }
}
