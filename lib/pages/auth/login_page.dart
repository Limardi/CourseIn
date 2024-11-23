import 'package:flutter/material.dart';
import 'package:project_ss/pages/auth/authentication.dart';
import 'package:project_ss/pages/schedule_page.dart';
import 'package:project_ss/pages/auth/sign_up.dart';
import 'package:project_ss/services/fetch.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:project_ss/widgets/bottom_navbar.dart';
import 'package:project_ss/widgets/text_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();

  var emailController = '';

  var passwordController = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/assets/Logo.png'),
            Text(
              'CourseIn',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              'Please enter your ID and Password',
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
                        key: const ValueKey('email'),
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
                        obscureText: false,
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
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        key: const ValueKey('password'),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Password',
                          prefixIcon: Image.asset('lib/assets/password.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .transparent), // No border when enabled
                            borderRadius: BorderRadius.circular(
                                10.0), // More circular corners
                          ),
                          // Other decoration properties can be added here
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordController = value!;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submit();
                        // final nav =
                        //     Provider.of<NavigationService>(context, listen: false);
                        //     nav.alrLoginPage();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 221, 180, 212),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40)),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Do not have an account?'),
                        TextButton(
                          onPressed: () {
                            final nav = Provider.of<NavigationService>(context,
                                listen: false);
                            nav.goToSignUpPage();
                            //Act when the button is pressed
                          },
                          style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0)),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();

    final authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);

    try {
      await authenticationService.logIn(
        email: emailController,
        password: passwordController,
      );
    } catch (e) {
      debugPrint('Login failed with error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Loginfailed with error: $e'),
          ),
        );
      }
    }
  }
}
