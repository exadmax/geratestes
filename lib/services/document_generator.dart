import 'dart:math';

class DocumentGenerator {
  DocumentGenerator() : _random = Random();

  final Random _random;

  String generateCpf() {
    while (true) {
      final digits = List<int>.generate(9, (_) => _random.nextInt(10));
      if (_allSameDigits(digits)) {
        continue;
      }
      final firstDigit = _calculateCpfDigit(digits, 10);
      digits.add(firstDigit);
      final secondDigit = _calculateCpfDigit(digits, 11);
      digits.add(secondDigit);

      final cpf = digits.join();
      return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.'
          '${cpf.substring(6, 9)}-${cpf.substring(9)}';
    }
  }

  String generateCnpj() {
    final base = List<int>.generate(12, (_) => _random.nextInt(10));
    if (_allSameDigits(base)) {
      return generateCnpj();
    }
    final firstDigit = _calculateCnpjDigit(base);
    base.add(firstDigit);
    final secondDigit = _calculateCnpjDigit(base);
    base.add(secondDigit);

    final cnpj = base.join();
    return '${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.'
        '${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-'
        '${cnpj.substring(12)}';
  }

  bool isValidCpf(String input) {
    final digits = _onlyDigits(input);
    if (digits.length != 11) {
      return false;
    }
    final numbers = digits.split('').map(int.parse).toList();
    if (_allSameDigits(numbers)) {
      return false;
    }
    final first = _calculateCpfDigit(numbers.sublist(0, 9), 10);
    final second = _calculateCpfDigit(numbers.sublist(0, 10), 11);
    return numbers[9] == first && numbers[10] == second;
  }

  bool isValidCnpj(String input) {
    final digits = _onlyDigits(input);
    if (digits.length != 14) {
      return false;
    }
    final numbers = digits.split('').map(int.parse).toList();
    if (_allSameDigits(numbers)) {
      return false;
    }
    final first = _calculateCnpjDigit(numbers.sublist(0, 12));
    final second = _calculateCnpjDigit(numbers.sublist(0, 13));
    return numbers[12] == first && numbers[13] == second;
  }

  String _onlyDigits(String input) {
    return input.replaceAll(RegExp(r'\D'), '');
  }

  bool _allSameDigits(List<int> digits) {
    return digits.every((d) => d == digits.first);
  }

  int _calculateCpfDigit(List<int> digits, int weightStart) {
    var sum = 0;
    for (var i = 0; i < digits.length; i++) {
      sum += digits[i] * (weightStart - i);
    }
    final remainder = (sum * 10) % 11;
    return remainder == 10 ? 0 : remainder;
  }

  int _calculateCnpjDigit(List<int> digits) {
    const weights = <int>[6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    final offset = weights.length - digits.length;
    var sum = 0;
    for (var i = 0; i < digits.length; i++) {
      sum += digits[i] * weights[i + offset];
    }
    final remainder = sum % 11;
    return remainder < 2 ? 0 : 11 - remainder;
  }
}
