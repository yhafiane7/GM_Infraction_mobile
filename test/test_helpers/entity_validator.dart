/// Simple validation utilities for testing
class ValidationUtils {
  /// Validate name field (2-50 characters)
  static bool isValidName(String? name) {
    if (name == null || name.isEmpty) return false;
    return name.length >= 2 && name.length <= 50;
  }

  /// Validate phone number (exactly 10 digits)
  static bool isValidPhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) return false;
    return RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }

  /// Validate CIN (1-12 characters, uppercase letters and numbers)
  static bool isValidCIN(String? cin) {
    if (cin == null || cin.isEmpty) return false;
    return RegExp(r'^[A-Z0-9]{1,12}$').hasMatch(cin);
  }

  /// Validate degree (non-negative integer)
  static bool isValidDegree(int? degree) {
    if (degree == null) return false;
    return degree >= 0;
  }
}
