import 'package:flutter/material.dart';
import 'package:jobjob/feature/login/view/login_view.dart';
import 'package:jobjob/product/components/app_color.dart';
import 'package:jobjob/product/components/app_string.dart';
import 'package:jobjob/product/utils/validator/validator.dart';
import 'package:jobjob/product/widgets/costum_form_field.dart';
import 'package:jobjob/services/auth_service.dart';
import 'package:kartal/kartal.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _againpassController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusName = FocusNode();
  final _focusAgainPass = FocusNode();

  Authentication _authService = Authentication();

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
        _focusAgainPass.unfocus();
        _focusName.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.backColor,
        body: FutureBuilder(
          future: Authentication().initializeSignUp(context: context),
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
                          AppString.registerTitle,
                          style: context.textTheme.headline2?.copyWith(
                            color: AppColor.darkBlue,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomFormField(
                              focusnode: _focusName,
                              controller: _nameController,
                              inputType: TextInputType.text,
                              name: AppString.registerName,
                              validator: (value) =>
                                  Validator().validateEmail(email: value),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomFormField(
                              focusnode: _focusEmail,
                              controller: _emailController,
                              inputType: TextInputType.emailAddress,
                              name: AppString.registerMail,
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
                              name: AppString.registerPass,
                              inputType: TextInputType.visiblePassword,
                              validator: (value) =>
                                  Validator().validatePassword(password: value),
                              obscureText: true,
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
                              focusnode: _focusAgainPass,
                              controller: _againpassController,
                              name: AppString.regisAgainPass,
                              inputType: TextInputType.visiblePassword,
                              validator: (value) =>
                                  Validator().validatePassword(password: value),
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _isLoading
                                ? CircularProgressIndicator()
                                : Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _authService
                                                .createPerson(
                                                    _nameController.text,
                                                    _emailController.text,
                                                    _passwordController.text)
                                                .then((value) {
                                              return Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginView()));
                                            });
                                          },
                                          child: Text(
                                            AppString.registerTitle,
                                            style: context.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            primary: AppColor.darkBlue,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50, vertical: 20),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
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
