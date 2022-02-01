String currencyFormatter(
  double? n, {
  Locale locale = Locale.us,
  int minIntegerDigits = 1,
  int? fractionDigits, // select between 0 - 2
  bool showPrefix = false,
  CurrencyPrefix prefixType = CurrencyPrefix.sign,
}) {
  n ??= 0;
  if (fractionDigits != null) {
    if (fractionDigits < 0) {
      fractionDigits = 0;
    } else if (fractionDigits > 2) {
      fractionDigits = 2;
    }
  } else {
    fractionDigits = locale.fractionDigits;
  }

  minIntegerDigits = minIntegerDigits < 1 ? 1 : minIntegerDigits;

  int integer = n.toInt();
  double fraction = ((n - integer) * 100).roundToDouble() / 100;

  String integerS = integer.toString();
  String fractionS = fraction.toString().substring(2);

  int numZero;
  numZero = fractionDigits - fractionS.length;
  for (var i = 0; i < numZero; i++) {
    fractionS += '0';
  }

  numZero = minIntegerDigits - integerS.length;
  for (var i = 0; i < numZero; i++) {
    integerS = '0' + integerS;
  }

  var i = integerS.length - locale.stepSeparator;
  while (i > 0) {
    integerS = integerS.substring(0, i) + ',' + integerS.substring(i);
    i = i - locale.stepSeparator;
  }

  String currency = integerS + (fractionDigits > 0 ? ('.' + fractionS) : '');
  if (showPrefix) {
    String prefix;
    switch (prefixType) {
      case CurrencyPrefix.sign:
        prefix = locale.sign;
        break;
      case CurrencyPrefix.code:
        prefix = locale.code;
        break;
      case CurrencyPrefix.codeAndSign:
        prefix = locale.codeAnsSign;
        break;
    }

    currency = prefix + currency;
  }

  return currency;
}

enum Locale {
  us,
  ca,
  ja,
}

enum CurrencyPrefix {
  sign,
  code,
  codeAndSign,
}

extension LocaleExtension on Locale {
  int get fractionDigits {
    switch (this) {
      case Locale.us:
        return 2;
      case Locale.ca:
        return 2;
      case Locale.ja:
        return 0;
    }
  }

  String get sign {
    switch (this) {
      case Locale.us:
        return '\$';
      case Locale.ca:
        return '\$';
      case Locale.ja:
        return '¥';
    }
  }

  String get code {
    switch (this) {
      case Locale.us:
        return 'USD';
      case Locale.ca:
        return 'CAD';
      case Locale.ja:
        return 'JPY';
    }
  }

  String get codeAnsSign {
    switch (this) {
      case Locale.us:
        return 'US\$';
      case Locale.ca:
        return 'CA\$';
      case Locale.ja:
        return 'JP¥';
    }
  }

  int get stepSeparator {
    switch (this) {
      case Locale.us:
        return 3;
      case Locale.ca:
        return 3;
      case Locale.ja:
        return 4;
    }
  }
}
