String sentenceCaseFormatter(String? str) {
  str ??= '';
  str = str.trim().replaceAllMapped(RegExp(r'(\s*)([^.]+\.*)'), (Match match) {
    String spacesPre = match[1] ?? '';
    String body = match[2] ?? '';

    String result = spacesPre;

    if (body.isNotEmpty) {
      result += body[0].toUpperCase();

      if (body.length > 1) {
        result += body.substring(1);
      }
    }

    return result;
  });

  return str;
}
