import 'dart:math';

import 'package:flutter/material.dart';

/// Builds user-friendly TextField hints and keyboard settings from the expected answer.
class AnswerInputHint {
  AnswerInputHint._();

  static final _random = Random();

  /// Randomized placeholder for hint text only (does not expose the real answer).
  static String forHint(String correctAnswer) {
    final answer = correctAnswer.trim();
    if (answer.isEmpty) return answer;

    if (_isNumeric(answer)) {
      return _randomNumericWithSameLength(answer);
    }

    if (_isComparison(answer) || _isMathExpression(answer)) {
      return _replaceNumbersPreservingLength(answer);
    }

    return answer;
  }

  static String _randomNumericWithSameLength(String value) {
    final normalized = value.replaceAll(',', '.');
    final isNegative = normalized.startsWith('-');
    final unsigned = isNegative ? normalized.substring(1) : normalized;

    if (unsigned.contains('.')) {
      final parts = unsigned.split('.');
      final intPart = _randomDigits(parts[0].length, allowLeadingZero: false);
      final decPart = _randomDigits(parts[1].length, allowLeadingZero: true);
      return '${isNegative ? '-' : ''}$intPart.$decPart';
    }

    return '${isNegative ? '-' : ''}${_randomDigits(unsigned.length, allowLeadingZero: false)}';
  }

  static String _randomDigits(int length, {required bool allowLeadingZero}) {
    if (length <= 0) return '${_random.nextInt(9) + 1}';

    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      if (i == 0 && !allowLeadingZero) {
        buffer.write(_random.nextInt(9) + 1);
      } else {
        buffer.write(_random.nextInt(10));
      }
    }
    return buffer.toString();
  }

  static String _replaceNumbersPreservingLength(String input) {
    return input.replaceAllMapped(RegExp(r'-?\d+(?:[.,]\d+)?'), (match) {
      return _randomNumericWithSameLength(match.group(0)!);
    });
  }

  static String hintText({
    required String correctAnswer,
    required bool isShortAnswer,
    String? validation,
  }) {
    final answer = correctAnswer.trim();

    if (answer.isEmpty) {
      return isShortAnswer
          ? 'Décrivez votre réponse en une ou plusieurs phrases...'
          : 'Complétez le blanc avec un mot ou un nombre';
    }

    if (_isNumeric(answer)) {
      return 'Entrez un nombre (ex: $answer)';
    }

    if (_isComparison(answer)) {
      return 'Entrez une comparaison (ex: $answer)';
    }

    if (_isMathExpression(answer)) {
      return 'Entrez le résultat ou l\'expression (ex: $answer)';
    }

    if (_isSingleToken(answer)) {
      return isShortAnswer
          ? 'Entrez un mot ou une courte expression'
          : 'Entrez un mot pour compléter la phrase';
    }

    if (isShortAnswer) {
      return 'Écrivez votre réponse en une ou plusieurs phrases...';
    }

    return 'Entrez votre réponse';
  }

  static TextInputType keyboardType(String correctAnswer) {
    if (_isNumeric(correctAnswer.trim())) {
      return const TextInputType.numberWithOptions(decimal: true, signed: true);
    }
    return TextInputType.text;
  }

  static int? maxLines({
    required bool isShortAnswer,
    required String correctAnswer,
  }) {
    if (isShortAnswer &&
        (correctAnswer.trim().isEmpty || !_isSingleToken(correctAnswer.trim()))) {
      return 3;
    }
    return 1;
  }

  static bool _isNumeric(String value) {
    return RegExp(r'^-?\d+([.,]\d+)?$').hasMatch(value);
  }

  static bool _isComparison(String value) {
    return RegExp(r'[<>]=?|=').hasMatch(value) && RegExp(r'\d').hasMatch(value);
  }

  static bool _isMathExpression(String value) {
    return RegExp(r'[\d+\-×÷*/]').hasMatch(value) &&
        value.split(RegExp(r'\s+')).length > 1;
  }

  static bool _isSingleToken(String value) {
    return value.split(RegExp(r'\s+')).length == 1;
  }
}
