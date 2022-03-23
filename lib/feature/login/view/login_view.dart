import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/feature/login/view/home_view.dart';
import 'package:jobjob/product/components/app_string.dart';
import 'package:jobjob/product/utils/validator/validator.dart';
import 'package:jobjob/services/auth_service.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  void changeLoading() {
    _isLoading = !_isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: FutureBuilder(
          future: Authentication().initializeFirebase(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("data"),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            focusNode: _focusEmail,
                            validator: (value) =>
                                Validator().validateEmail(email: value),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _focusPassword,
                            validator: (value) =>
                                Validator().validatePassword(password: value),
                          ),
                          _isLoading
                              ? CircularProgressIndicator()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          _focusEmail.unfocus();
                                          _focusPassword.unfocus();
                                          setState(() {
                                            changeLoading();
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            User? user = await Authentication()
                                                .mailSignIn(
                                                    mail: _emailController.text,
                                                    password:
                                                        _passwordController
                                                            .text);
                                          }

                                          setState(() {
                                            changeLoading();
                                          });
                                        },
                                        child: Text(AppString.loginButton),
                                      ),
                                    )
                                  ],
                                ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future:
                          Authentication().initializeFirebase(context: context),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('hata varrr');
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                changeLoading();
                              });
                              User? user =
                                  await Authentication().signInWithGoogle();
                              setState(() {
                                changeLoading();
                              });
                              if (user != null) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        HomeView(user: user)));
                              }
                            },
                            child: Text("google sign in"),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    )
                  ],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}



      // child: Scaffold(
      //   body: FutureBuilder(
      //     future: Authentication().initializeFirebase(context: context),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         return Scaffold(
      //           body: Padding(
      //             padding: EdgeInsets.all(10),
      //             child: SizedBox(
      //               height: MediaQuery.of(context).size.height,
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   const SizedBox(
      //                     height: 20,
      //                   ),
      //                   Form(
      //                     key: _formKey,
      //                     child: Column(
      //                       children: [
      //                         CustomFormField(
      //                           focusnode: _focusEmail,
      //                           controller: _emailController,
      //                           inputType: TextInputType.emailAddress,
      //                           name: AppString.loginMail,
      //                         ),
      //                         const SizedBox(
      //                           height: 10,
      //                         ),
      //                         CustomFormField(
      //                           focusnode: _focusPassword,
      //                           controller: _passwordController,
      //                           name: AppString.loginPass,
      //                           inputType: TextInputType.visiblePassword,
      //                           obscureText: true,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   _isLoading
      //                       ? CircularProgressIndicator()
      //                       : Row(
      //                           children: [
      //                             Expanded(
      //                               child: ElevatedButton(
      //                                 onPressed: () async {
      //                                   _focusEmail.unfocus();
      //                                   _focusPassword.unfocus();

      //                                   if (_formKey.currentState!.validate()) {
      //                                     setState(() {
      //                                       changeLoading();
      //                                     });
      //                                     User? user = await Authentication()
      //                                         .mailSignIn(
      //                                             mail: _emailController.text,
      //                                             password:
      //                                                 _passwordController.text);
      //                                     setState(() {
      //                                       changeLoading();
      //                                     });
      //                                   } 
      //                                 },
      //                                 child: Text(AppString.loginButton),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         );
