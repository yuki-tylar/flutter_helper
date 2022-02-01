enum Validator {
  required,
  email,
  password,
  price,
}

extension FormValidatorExtension on Validator {
  String errorMessage(String? label) {
    String s;
    switch (this) {
      case Validator.required:
        s = 'Please enter $label';
        break;
      case Validator.email:
        s = 'Please enter valid email';
        break;
      case Validator.password:
        s = 'Please enter valid password';
        break;
      case Validator.price:
        s = 'Please enter valid price';
        break;
    }
    return s;
  }

  bool validate(String? value) {
    bool valid = false;

    switch (this) {
      case Validator.required:
        valid = value != null && value.isNotEmpty;
        break;
      case Validator.email:
        valid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value ?? '');
        break;
      case Validator.password:
        valid = value == null ||
            (value.length >= 8 &&
                RegExp(r'A-Z').hasMatch(value) &&
                RegExp(r'0-9').hasMatch(value) &&
                RegExp(r'[a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]*').hasMatch(value));
        break;
      case Validator.price:
        valid = value == null ||
            RegExp(r'^[0-9]{1,}(\\.[0-9]{1,2})?$').hasMatch(value);
        break;
    }
    return valid;
  }
}
