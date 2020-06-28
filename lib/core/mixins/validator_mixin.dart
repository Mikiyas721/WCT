import 'package:validators/validators.dart';

mixin ValidatorMixin {
  String validateName(String name) {
    if (name == null || name.isEmpty) return "Name can't be empty";
    return isLength(name, 2, 72)
        ? null
        : name.length < 2 ? 'Name too short' : 'Name too long';
  }

  String validateAvailable(String text, [name = 'Field']) {
    return text == null || text.isEmpty ? "$name can't be empty" : null;
  }

  String validateEmail(String text) {
    return text != null && isEmail(text) ? null : 'Invalid Email Address';
  }

  String validatePhone(String text) {
    if (text == null || text.isEmpty) return 'Invalid Phone';
    if (text.startsWith('+251'))
      return matches(text.substring(4), '^0?9[0-9]{8}\$')
          ? null
          : 'Invalid Phone';
    return matches(text, '^0?9[0-9]{8}\$') ? null : 'Invalid Phone';
  }
  String validatePhone2(String text) {
    return RegExp(r'^09[0-9]{8}$').hasMatch(text)?null:'Invalid Phone';
  }

  String validateNumber(String text) {
    if (text == null || text.isEmpty) return 'Invalid Number';
    return isNumeric(text) ? null : "Invalid Number";
  }

  String validateOptional(String text, String Function(String text) validator) {
    return text == null || text.isEmpty ? null : validator(text);
  }

  String validateDateRange(int date1, int date2, [bool validateBefore = true]) {
    if (date1 == null)
      return '${validateBefore ? 'From Date' : 'To Date'} Required';
    return null;
  }

  String validateLinkOptional(String link, [name = 'Field']) {
    return link == null || link.isEmpty
        ? null
        : isURL(link) ? null : '$name should be a link';
  }

  String validateAmount(String text) {
    if (text == null || text.isEmpty) return "Amount cannot be empty";
    if (!isNumeric(text)) return "Amount should be a number";
    int amount = int.parse(text);
    if (amount < 5) return "Minimum amount possible is 5 Birr";
    if (amount > 1000000) return "Maximum amount possible is 1000,000 Birr";
    return null;
  }

  String validateFrequency(String text) {
    if (text == null || text.isEmpty) return "Frequency cannot be empty";
    if (!isNumeric(text)) return "Amount should be a number";
    int amount = int.parse(text);
    if (amount < 50) return "Minimum amount possible is 100 Birr";
    if (amount > 1000000) return "Maximum amount possible is 1000,000 Birr";
    return null;
  }

  String validateBankNo(String text) {
    if (text == null || text.isEmpty) return "Bank Number cannot be empty";
    if (!isNumeric(text)) return "Bank Number should be a number";
    return null;
  }
}

mixin SanitizerMixin {
  String sanitizePhone(String phone) {
    if (phone.startsWith('09')) return '+251${phone.substring(1)}';
    if (phone.startsWith('9')) return '+251$phone';
    return phone;
  }
}
