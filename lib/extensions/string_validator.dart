// Validator accept null strings
extension Validator on String? {
  bool isGreatherThan(int? minLength) => (this)!.length >= minLength!;
  bool isLowerThan(int? maxLength) => (this)!.length <= maxLength!;

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this!);
  }
}
