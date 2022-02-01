library flutter_validator;

class Validator {
  late ValidatorType type;
  String errorMessage;
  String? pattern;
  int minLength = 0;
  int maxLength = 100000;

  Validator.required({
    this.errorMessage = 'Required',
  }) {
    type = ValidatorType.required;
  }

  Validator.email({
    this.errorMessage = 'Invalid email',
  }) {
    type = ValidatorType.pattern;
    pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$";
  }

  Validator.password({
    this.errorMessage = 'Invalid password',
    this.pattern =
        r'^(?=.*[A-Z])(?=.*\d)[a-zA-Z\d.!#$%&*+-/=?^_`{|}~\]\*]{8,}$',
  }) {
    type = ValidatorType.pattern;
  }

  Validator.price({
    this.errorMessage = 'Invalid price',
    this.pattern = r'^\d{1,}(\.\d{1,2})?$',
  }) {
    type = ValidatorType.pattern;
  }

  Validator.minLength(
    this.minLength, {
    this.errorMessage = 'Too short',
  }) {
    type = ValidatorType.minLength;
  }
  Validator.maxLength(
    this.maxLength, {
    this.errorMessage = 'Too long',
  }) {
    type = ValidatorType.maxLength;
  }

  String? validate(String? value) {
    String? error;

    switch (type) {
      case ValidatorType.required:
        error = (value != null && value.isNotEmpty) ? null : errorMessage;
        break;
      case ValidatorType.pattern:
        error = (value == null ||
                pattern != null && RegExp(pattern!).hasMatch(value))
            ? null
            : errorMessage;
        break;
      case ValidatorType.minLength:
        error =
            (value == null || value.length >= minLength) ? null : errorMessage;
        break;
      case ValidatorType.maxLength:
        error =
            (value == null || value.length <= maxLength) ? null : errorMessage;
        break;
    }
    return error;
  }
}

enum ValidatorType {
  required,
  pattern,
  minLength,
  maxLength,
}
