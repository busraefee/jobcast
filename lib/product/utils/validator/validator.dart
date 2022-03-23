class Validator {
  String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'name empty!!';
    }
    return null;
  }

  String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailReq = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email.isEmpty) {
      return 'dadawawd';
    } else if (!emailReq.hasMatch(email)) {
      return 'correct email needed';
    }
    return null;
  }

  String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'password empty!!';
    } else if (password.length < 6) {
      return 'enter at least 7 words';
    }
    return null;
  }
}
