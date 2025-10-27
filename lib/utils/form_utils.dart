import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    String formatted = '';
    if (text.isNotEmpty) {
      if (text.length >= 1) {
        formatted += text.substring(0, 1);
      }
      if (text.length >= 4) {
        formatted += ' (${text.substring(1, 4)})';
      } else if (text.length > 1) {
        formatted += ' (${text.substring(1)}';
      }
      if (text.length >= 7) {
        formatted += ' ${text.substring(4, 7)}';
      } else if (text.length > 4) {
        formatted += ' ${text.substring(4)}';
      }
      if (text.length >= 9) {
        formatted += ' ${text.substring(7, 9)}';
      } else if (text.length > 7) {
        formatted += ' ${text.substring(7)}';
      }
      if (text.length >= 11) {
        formatted += ' ${text.substring(9, 11)}';
      } else if (text.length > 9) {
        formatted += ' ${text.substring(9)}';
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class FormValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta alanı zorunludur';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Geçerli bir e-posta adresi girin';
    }
    return null;
  }

  static String? validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName alanı zorunludur';
    }
    if (value.length < 2) {
      return '$fieldName en az 2 karakter olmalıdır';
    }
    if (value.length > 50) {
      return '$fieldName en fazla 50 karakter olabilir';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefon numarası zorunludur';
    }
    String cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanPhone.length != 11 || !cleanPhone.startsWith('0')) {
      return 'Geçerli bir telefon numarası girin';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre alanı zorunludur';
    }
    if (value.length < 8) {
      return 'Şifre en az 8 karakter olmalıdır';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Şifre büyük harf, küçük harf ve rakam içermelidir';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'Şifre tekrarı zorunludur';
    }
    if (value != originalPassword) {
      return 'Şifreler eşleşmiyor';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName seçimi zorunludur';
    }
    return null;
  }
}
