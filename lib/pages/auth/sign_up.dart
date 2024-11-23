import 'package:flutter/material.dart';
import 'package:project_ss/pages/auth/authentication.dart';
import 'package:project_ss/pages/before_getting_start_page.dart';
import 'package:project_ss/pages/auth/login_page.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:project_ss/widgets/text_form.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form = GlobalKey<FormState>();

  var studentIDController = '';

  var emailController = '';

  var passwordController = '';

  var _isAuthenticating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CourseIn',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              'Just a few steps to get started',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      TextFormField(
                        key: const ValueKey('studentID'),
                        obscureText: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Your Student ID',
                          prefixIcon: Image.asset('lib/assets/id.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .transparent), // No border when enabled
                            borderRadius: BorderRadius.circular(
                                10.0), // More circular corners
                          ), // Optional: Customize the border
                          // Other decoration properties can be added here
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.length != 9) {
                            return 'Please enter your Student ID.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          studentIDController = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        key: const ValueKey('email'),
                        obscureText: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Your Email',
                          prefixIcon: Image.asset('lib/assets/email.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .transparent), // No border when enabled
                            borderRadius: BorderRadius.circular(
                                10.0), // More circular corners
                          ), // Optional: Customize the border
                          // Other decoration properties can be added here
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        key: const ValueKey('password'),
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Your Password',
                          prefixIcon: Image.asset('lib/assets/password.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .transparent), // No border when enabled
                            borderRadius: BorderRadius.circular(
                                10.0), // More circular corners
                          ), // Optional: Customize the border
                          // Other decoration properties can be added here
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordController = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (_isAuthenticating)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      if (!_isAuthenticating) ...[
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => BeforeGettingStarted()),
                            // );
                            _submit();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 221, 180, 212),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 40)),
                          child: Text("Sign Up",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('already have account?'),
                            TextButton(
                              onPressed: () {
                                final nav = Provider.of<NavigationService>(
                                    context,
                                    listen: false);
                                nav.goToLoginPage();
                                //Act when the button is pressed
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0)),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )
                      ]
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();

    final authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);

    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticationService.signUp(
        context: context,
        studentId: studentIDController,
        email: emailController,
        password: passwordController,
      );
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    } catch (error) {
      debugPrint('Authentication failed with error: $error');
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication failed with error: $error'),
          ),
        );
      }
    }
  }
}
