import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../product/components/app_color.dart';
import '../../../product/components/app_string.dart';
import '../../../product/utils/validator/validator.dart';
import '../../../product/widgets/costum_form_field.dart';
import '../../../services/auth_service.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userSurnameController = TextEditingController();
  final TextEditingController _againpassController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusName = FocusNode();
  final _focusAgainPass = FocusNode();
  final _focusSurname = FocusNode();

  final Authentication _authService = Authentication();

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
        backgroundColor: AppColor.white,
        body: FutureBuilder(
          future: Authentication().initializeSignUp(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: context.paddingMedium,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppString.registerTitle,
                            style: context.textTheme.headline2?.copyWith(
                              color: AppColor.darkgreen,
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
                                focusnode: _focusSurname,
                                controller: _userSurnameController,
                                inputType: TextInputType.text,
                                name: AppString.registerSurname,
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
                                name: AppString.registerPass,
                                inputType: TextInputType.visiblePassword,
                                validator: (value) => Validator()
                                    .validatePassword(password: value),
                                obscureText: true,
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
                                focusnode: _focusAgainPass,
                                controller: _againpassController,
                                name: AppString.regisAgainPass,
                                inputType: TextInputType.visiblePassword,
                                validator: (value) => Validator()
                                    .validatePassword(password: value),
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              _isLoading
                                  ? const CircularProgressIndicator()
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _authService
                                                  .createPerson(
                                                      _nameController.text,
                                                      _emailController.text,
                                                      _passwordController.text,
                                                      _userSurnameController
                                                          .text)
                                                  .then((value) {
                                                return Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginView()));
                                              });
                                            },
                                            child: Text(
                                              AppString.registerTitle,
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
                            ],
                          ),
                        ),
                      ],
                    ),
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
