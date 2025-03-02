abstract class AppValidation {
  static nameValidation() => (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name.';
    }
    List<String> nameParts = value.trim().split(' ');
    if (nameParts.length != 2) {
      return 'Full name must be two parts.';
    }
    if (nameParts.any((part) => part.length < 3)) {
      return 'Each part must be at least 3 characters.';
    }
    return null;
  };

  static emailValidation() => (String? email) {
    if (email!.isEmpty) {
      return 'Email Required';
    } else if (!RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
    ).hasMatch(email)) {
      return 'Email Bad Format';
    }
  };

  static String? Function(String?) genderValidation() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please select a gender.';
      }
      return null;
    };
  }

  static String? Function(String?) statusValidation() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please select a status.';
      }
      return null;
    };
  }
}
