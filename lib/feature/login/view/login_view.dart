import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/feature/login/view/home_view.dart';
import 'package:jobjob/product/components/app_color.dart';
import 'package:jobjob/product/components/app_string.dart';
import 'package:jobjob/product/utils/validator/validator.dart';
import 'package:jobjob/product/widgets/costum_form_field.dart';
import 'package:jobjob/services/auth_service.dart';
import 'package:kartal/kartal.dart';

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

  bool _visible = true;

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
        backgroundColor: AppColor.backColor,
        body: FutureBuilder(
          future: Authentication().initializeFirebase(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: context.paddingMedium,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppString.loginTitle,
                          style: context.textTheme.headline2?.copyWith(
                            color: AppColor.darkBlue,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.manual,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomFormField(
                                focusnode: _focusEmail,
                                controller: _emailController,
                                inputType: TextInputType.emailAddress,
                                name: AppString.loginMail,
                                validator: (value) =>
                                    Validator().validateEmail(email: value),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomFormField(
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.lock_outline,
                                    color: AppColor.loginFormField,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _visible = !_visible;
                                    });
                                  },
                                ),
                                visible: _visible,
                                focusnode: _focusPassword,
                                controller: _passwordController,
                                name: AppString.loginPass,
                                inputType: TextInputType.visiblePassword,
                                validator: (value) => Validator()
                                    .validatePassword(password: value),
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 10,
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
                                                        mail: _emailController
                                                            .text,
                                                        password:
                                                            _passwordController
                                                                .text);
                                              }

                                              setState(() {
                                                changeLoading();
                                              });
                                            },
                                            child: Text(
                                              AppString.loginButton,
                                              style: context.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              primary: AppColor.darkBlue,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50,
                                                      vertical: 20),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                              /*ElevatedButton(
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeView(user: user)));
                                  }
                                },
                                child: Text("G"),
                                style: ElevatedButton.styleFrom(
                                    primary: AppColor.buttonREd,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    /*padding: const EdgeInsets.symmetric(
                                            horizontal: context.paddingLow, vertical: context.paddingLow),*/
                                    textStyle: context.textTheme.headline5
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold)),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: Authentication()
                            .initializeFirebase(context: context),
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
                              child: Text("G"),
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor.buttonREd,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  textStyle: context.textTheme.headline5
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      )
                    ],
                  ),
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
