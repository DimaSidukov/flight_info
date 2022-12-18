import 'package:firebase_auth/firebase_auth.dart';
import 'package:flight_info/colors/AppColors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  String _email = "";
  String _password = "";
  bool _stayLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
        appBar: null,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          fontFamily: 'FiraSans',
                          fontSize: 42,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 38, right: 38),
                    child: TextField(
                        obscureText: false,
                        onChanged: (text) {
                          _email = text;
                        },
                        style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.purple,
                            fontFamily: 'FiraSans'),
                        decoration: const InputDecoration(
                            labelText: "Email",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                                fontSize: 18, color: AppColors.purple),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            filled: true,
                            fillColor: AppColors.white)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 38, right: 38),
                    child: TextField(
                        obscureText: true,
                        onChanged: (text) {
                          _password = text;
                        },
                        style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.purple,
                            fontFamily: 'FiraSans'),
                        decoration: const InputDecoration(
                            labelText: "Password",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                                fontSize: 18, color: AppColors.purple),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            filled: true,
                            fillColor: AppColors.white)),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 38, top: 50),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _stayLoggedIn,
                            fillColor: MaterialStateProperty.resolveWith(
                                (states) => AppColors.purple),
                            shape: const CircleBorder(),
                            onChanged: (bool? value) {
                              setState(() => _stayLoggedIn = value!);
                            },
                          ),
                          const Text(
                            "Stay logged in",
                            style: TextStyle(
                                color: AppColors.grey,
                                fontFamily: 'FiraSans',
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )
                        ],
                      )),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 38, right: 38, top: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [AppColors.purple2, AppColors.purple],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(62),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                backgroundColor: Colors.transparent),
                            onPressed: () async {
                              if (_email.isEmpty || _password.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Email or password is empty!"),
                                ));
                                return;
                              }
                              try {
                                await auth.signInWithEmailAndPassword(
                                    email: _email, password: _password);
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('is_logged_in', true);
                                if (mounted) {
                                  context.go("/home");
                                }
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(e.message!),
                                ));
                              }
                            },
                            child: const Text(
                              "Log in",
                              style: TextStyle(
                                  fontFamily: 'FiraSans',
                                  fontSize: 20,
                                  color: AppColors.white),
                            )),
                      ))
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 36, bottom: 48),
              child: RichText(
                text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSans',
                        color: AppColors.grey),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Sign Up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push('/signup');
                            },
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'FiraSans',
                              fontWeight: FontWeight.w500,
                              color: AppColors.purple))
                    ]),
              ),
            )
          ],
        ));
  }
}
