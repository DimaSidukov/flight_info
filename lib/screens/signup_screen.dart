import 'package:firebase_auth/firebase_auth.dart';
import 'package:flight_info/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  bool _checkboxState = false;
  String _email = "";
  String _password = "";
  String _passwordConfirmation = "";

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
        appBar: null,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 38),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 38, right: 38),
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
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle:
                          TextStyle(fontSize: 18, color: AppColors.purple),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      filled: true,
                      fillColor: AppColors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 38, right: 38),
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle:
                            TextStyle(fontSize: 18, color: AppColors.purple),
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
                padding: const EdgeInsets.only(top: 30, left: 38, right: 38),
                child: TextField(
                    obscureText: true,
                    onChanged: (text) {
                      _passwordConfirmation = text;
                    },
                    style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.purple,
                        fontFamily: 'FiraSans'),
                    decoration: const InputDecoration(
                        labelText: "Confirm Password",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle:
                            TextStyle(fontSize: 18, color: AppColors.purple),
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
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 38),
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [AppColors.purple2, AppColors.purple],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(62),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.transparent),
                        onPressed: () async {
                          if (_email.isEmpty ||
                              _password.isEmpty ||
                              _passwordConfirmation.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Email or password is empty!"),
                            ));
                            return;
                          } else if (_password != _passwordConfirmation) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Email or password is empty!"),
                            ));
                            return;
                          } else if (!_checkboxState) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("You must agree to Terms & Conditions!"),
                            ));
                            return;
                          }
                          try {
                            await auth.createUserWithEmailAndPassword(
                                email: _email, password: _password);
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('is_logged_in', true);
                            if (mounted) {
                              context.go("/home");
                            }
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.message!),
                            ));
                          }
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontFamily: 'FiraSans',
                              fontSize: 20,
                              color: AppColors.white),
                        )),
                  ))
            ],
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 38, bottom: 30, right: 38),
            child: Row(
              children: [
                Checkbox(
                  value: _checkboxState,
                  fillColor: MaterialStateProperty.resolveWith(
                      (states) => AppColors.purple),
                  shape: const CircleBorder(),
                  onChanged: (bool? value) {
                    setState(() => _checkboxState = value!);
                  },
                ),
                RichText(
                    text: const TextSpan(
                        text: "I agree to ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'FiraSans',
                            color: AppColors.grey),
                        children: <TextSpan>[
                      TextSpan(
                          text: "Terms & Conditions ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'FiraSans',
                              color: AppColors.black)),
                      TextSpan(
                          text: "\nand ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'FiraSans',
                              color: AppColors.grey)),
                      TextSpan(
                          text: "Privacy Policy ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'FiraSans',
                              color: AppColors.black)),
                      TextSpan(
                          text: "of ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'FiraSans',
                              color: AppColors.grey)),
                      TextSpan(
                          text: "BookWorms.",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'FiraSans',
                              color: AppColors.black))
                    ]))
              ],
            )));
  }
}
