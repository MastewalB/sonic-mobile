import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/profile/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:sonic_mobile/features/profile/bloc/view_profile/profile_bloc.dart';
import 'package:sonic_mobile/features/profile/presentation/profile.dart';

class EditProfilePage extends StatefulWidget {
  static const String routeName = "editProfile";
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool validated = true;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool _passwordsMatch = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    setState(() {
      _passwordsMatch =
          _passwordController.text == _repeatPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          if (state is EditProfileInitial) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _firstNameController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 243, 237, 237)),
                        decoration: InputDecoration(
                            errorText:
                                !validated ? 'Value Can\'t Be Empty' : null,
                            fillColor: Colors.white,
                            labelText: 'First Name',
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                      TextField(
                        controller: _lastNameController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 243, 237, 237)),
                        decoration: InputDecoration(
                            errorText:
                                !validated ? 'Value Can\'t Be Empty' : null,
                            fillColor: Colors.white,
                            labelText: 'Last Name',
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                      TextField(
                        controller: _passwordController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 243, 237, 237)),
                        decoration: InputDecoration(
                            errorText:
                                !validated ? 'Value Can\'t Be Empty' : null,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white)),
                        obscureText: true,
                        onChanged: (_) => _validatePasswords(),
                      ),
                      TextField(
                        controller: _repeatPasswordController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 243, 237, 237)),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'Repeat Password',
                          labelStyle: TextStyle(color: Colors.white),
                          errorText: !_passwordsMatch
                              ? 'Passwords do not match'
                              : null,
                        ),
                        obscureText: true,
                        onChanged: (_) => _validatePasswords(),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          foregroundColor: (Colors.white),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          // Handle submit button press
                          print("edit attempted");
                          if (_firstNameController.text.isEmpty ||
                              _lastNameController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            setState(() {
                              validated = false;
                            });
                          }
                          context.read<EditProfileBloc>().add(
                              SubmitEditedProfile(
                                  firstName: _firstNameController.value.text,
                                  lastName: _lastNameController.value.text,
                                  password: _passwordController.value.text));
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is SubmittingEditedProfile) {
            return Center(
              child: Column(children: const [
                CircularProgressIndicator(),
                Text("Updating Profile")
              ]),
            );
          } else if (state is EditProfileSubmitted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, ProfilePage.routeName);
            });
          }
          return Container();
        },
      ),
    );
  }
}
