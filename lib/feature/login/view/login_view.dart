import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register_view.dart';
import '../../homepage/view/home_page_view.dart';
import '../../../product/components/app_color.dart';
import '../../../product/components/app_string.dart';
import '../../../product/utils/validator/validator.dart';
import '../../../product/widgets/costum_form_field.dart';
import '../../../services/auth_service.dart';
import 'package:kartal/kartal.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

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
        backgroundColor: AppColor.white,
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
                            color: AppColor.darkgreen,
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
                                    color: AppColor.orange,
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
                                  ? const Center(
                                      child: CircularProgressIndicator())
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
                                                await Authentication()
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
                                              primary: AppColor.darkgreen,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50,
                                                      vertical: 20),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                              SizedBox(
                                height: context.lowValue,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterView(),
                                      ));
                                },
                                child: Text(
                                  AppString.kayitOl,
                                  style: context.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.orange),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: Authentication()
                            .initializeFirebase(context: context),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('hata varrr');
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
                                      builder: (context) => const HomePage()));
                                }
                              },
                              child: const Text("G"),
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor.orange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  textStyle: context.textTheme.headline5
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
