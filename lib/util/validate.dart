bool isValidPhone(String? phone) {
  if (phone == null || phone.isEmpty) {
    return false;
  }
  return RegExp(r'^1[3-9]\d{9}$').hasMatch(phone);
}