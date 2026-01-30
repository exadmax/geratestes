import 'dart:math';

/// [DocumentGeneratorService] é responsável pela geração e validação de documentos.
/// 
/// Esse serviço encapsula toda a lógica de geração de CPF e CNPJ válidos,
/// bem como validação de documentos informados pelo usuário.
/// Utiliza o padrão de números aleatórios e algoritmos de checksum específicos
/// para cada tipo de documento brasileiro.
/// 
/// Responsabilidades:
/// - Gerar CPFs válidos
/// - Gerar CNPJs válidos
/// - Validar CPFs
/// - Validar CNPJs
/// - Calcular dígitos verificadores
class DocumentGeneratorService {
  /// Instância privada do gerador de números aleatórios.
  final Random _random;

  /// Construtor padrão que inicializa o gerador de números aleatórios.
  DocumentGeneratorService() : _random = Random();

  /// Gera um novo CPF válido.
  /// 
  /// Realiza:
  /// - Geração de 9 dígitos aleatórios
  /// - Rejeição de CPFs com todos os dígitos iguais (inválidos)
  /// - Cálculo dos dois dígitos verificadores (checksum)
  /// - Formatação do documento (opcional)
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatado (XXX.XXX.XXX-XX). Padrão: false
  /// 
  /// Retorna:
  ///   String com CPF (com ou sem formatação)
  String generateCpf({bool formatted = false}) {
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
      if (formatted) {
        return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.'
            '${cpf.substring(6, 9)}-${cpf.substring(9)}';
      } else {
        return cpf;
      }
    }
  }

  /// Gera um novo CNPJ válido.
  /// 
  /// Realiza:
  /// - Geração de 12 dígitos aleatórios
  /// - Rejeição de CNPJs com todos os dígitos iguais (inválidos)
  /// - Cálculo dos dois dígitos verificadores (checksum)
  /// - Formatação do documento (opcional)
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatado (XX.XXX.XXX/XXXX-XX). Padrão: false
  /// 
  /// Retorna:
  ///   String com CNPJ (com ou sem formatação)
  String generateCnpj({bool formatted = false}) {
    final base = List<int>.generate(12, (_) => _random.nextInt(10));
    if (_allSameDigits(base)) {
      return generateCnpj(formatted: formatted);
    }
    final firstDigit = _calculateCnpjDigit(base);
    base.add(firstDigit);
    final secondDigit = _calculateCnpjDigit(base);
    base.add(secondDigit);

    final cnpj = base.join();
    if (formatted) {
      return '${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.'
          '${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-'
          '${cnpj.substring(12)}';
    } else {
      return cnpj;
    }
  }

  /// Valida um CPF informado.
  /// 
  /// Realiza verificações de:
  /// - Extração apenas de dígitos
  /// - Quantidade obrigatória de 11 dígitos
  /// - Rejeição de CPFs com todos os dígitos iguais
  /// - Validação do primeiro dígito verificador
  /// - Validação do segundo dígito verificador
  /// 
  /// Parâmetros:
  ///   - [input]: String contendo o CPF (pode ter ou não formatação)
  /// 
  /// Retorna:
  ///   `true` se o CPF é válido, `false` caso contrário
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

  /// Valida um CNPJ informado.
  /// 
  /// Realiza verificações de:
  /// - Extração apenas de dígitos
  /// - Quantidade obrigatória de 14 dígitos
  /// - Rejeição de CNPJs com todos os dígitos iguais
  /// - Validação do primeiro dígito verificador
  /// - Validação do segundo dígito verificador
  /// 
  /// Parâmetros:
  ///   - [input]: String contendo o CNPJ (pode ter ou não formatação)
  /// 
  /// Retorna:
  ///   `true` se o CNPJ é válido, `false` caso contrário
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

  /// Gera uma nova CNH válida.
  /// 
  /// Realiza:
  /// - Geração de 9 dígitos aleatórios
  /// - Rejeição de CNHs com todos os dígitos iguais (inválidas)
  /// - Cálculo do primeiro e segundo dígitos verificadores
  /// - Formatação do documento (opcional)
  /// 
  /// A CNH possui 12 dígitos no total (9 dígitos base + 2 verificadores + 1 dígito de controle)
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatada (XXXXXXXXXX-XX). Padrão: false
  /// 
  /// Retorna:
  ///   String com CNH (com ou sem formatação)
  String generateCnh({bool formatted = false}) {
    while (true) {
      final digits = List<int>.generate(9, (_) => _random.nextInt(10));
      if (_allSameDigits(digits)) {
        continue;
      }
      
      // Calcula primeiro dígito verificador
      final firstDigit = _calculateCnhFirstDigit(digits);
      digits.add(firstDigit);
      
      // Calcula segundo dígito verificador
      final secondDigit = _calculateCnhSecondDigit(digits);
      digits.add(secondDigit);
      
      // Calcula dígito de controle
      final controlDigit = _calculateCnhControlDigit(digits);
      digits.add(controlDigit);

      final cnh = digits.join();
      if (formatted) {
        return '${cnh.substring(0, 10)}-${cnh.substring(10)}';
      } else {
        return cnh;
      }
    }
  }

  /// Valida uma CNH informada.
  /// 
  /// Realiza verificações de:
  /// - Extração apenas de dígitos
  /// - Quantidade obrigatória de 12 dígitos
  /// - Rejeição de CNHs com todos os dígitos iguais
  /// - Validação do primeiro dígito verificador
  /// - Validação do segundo dígito verificador
  /// - Validação do dígito de controle
  /// 
  /// Parâmetros:
  ///   - [input]: String contendo a CNH (pode ter ou não formatação)
  /// 
  /// Retorna:
  ///   `true` se a CNH é válida, `false` caso contrário
  bool isValidCnh(String input) {
    final digits = _onlyDigits(input);
    if (digits.length != 12) {
      return false;
    }
    
    final numbers = digits.split('').map(int.parse).toList();
    if (_allSameDigits(numbers)) {
      return false;
    }
    
    // Valida primeiro dígito
    final firstDigit = _calculateCnhFirstDigit(numbers.sublist(0, 9));
    if (numbers[9] != firstDigit) {
      return false;
    }
    
    // Valida segundo dígito
    final secondDigit = _calculateCnhSecondDigit(numbers.sublist(0, 10));
    if (numbers[10] != secondDigit) {
      return false;
    }
    
    // Valida dígito de controle
    final controlDigit = _calculateCnhControlDigit(numbers.sublist(0, 11));
    return numbers[11] == controlDigit;
  }

  /// Extrai apenas os dígitos de uma string.
  /// 
  /// Remove todos os caracteres que não são dígitos (0-9).
  /// Útil para aceitar CPF/CNPJ em múltiplos formatos.
  /// 
  /// Parâmetros:
  ///   - [input]: String a ser processada
  /// 
  /// Retorna:
  ///   String contendo apenas os dígitos
  String _onlyDigits(String input) {
    return input.replaceAll(RegExp(r'\D'), '');
  }

  /// Verifica se todos os dígitos são iguais.
  /// 
  /// CPFs e CNPJs com todos os dígitos iguais são considerados inválidos
  /// pela legislação brasileira.
  /// 
  /// Parâmetros:
  ///   - [digits]: Lista de dígitos a verificar
  /// 
  /// Retorna:
  ///   `true` se todos os dígitos são iguais, `false` caso contrário
  bool _allSameDigits(List<int> digits) {
    return digits.every((d) => d == digits.first);
  }

  /// Calcula o dígito verificador de um CPF.
  /// 
  /// Utiliza o algoritmo oficial de validação de CPF, que multiplica
  /// cada dígito por um peso decrescente e calcula o resto da divisão por 11.
  /// 
  /// Parâmetros:
  ///   - [digits]: Lista com os 9 ou 10 primeiros dígitos do CPF
  ///   - [weightStart]: Valor inicial do peso (10 para primeiro dígito, 11 para segundo)
  /// 
  /// Retorna:
  ///   Inteiro representando o dígito verificador
  int _calculateCpfDigit(List<int> digits, int weightStart) {
    var sum = 0;
    for (var i = 0; i < digits.length; i++) {
      sum += digits[i] * (weightStart - i);
    }
    final remainder = (sum * 10) % 11;
    return remainder == 10 ? 0 : remainder;
  }

  /// Calcula o dígito verificador de um CNPJ.
  /// 
  /// Utiliza o algoritmo oficial de validação de CNPJ, com uma sequência
  /// específica de pesos. Calcula o resto da divisão por 11.
  /// 
  /// Parâmetros:
  ///   - [digits]: Lista com os 12 ou 13 primeiros dígitos do CNPJ
  /// 
  /// Retorna:
  ///   Inteiro representando o dígito verificador
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

  /// Calcula o primeiro dígito verificador de uma CNH.
  /// 
  /// Usa o algoritmo oficial de validação de CNH com pesos específicos.
  /// 
  /// Parâmetros:
  ///   - [digits]: Lista com os 9 primeiros dígitos da CNH
  /// 
  /// Retorna:
  ///   Inteiro representando o primeiro dígito verificador
  int _calculateCnhFirstDigit(List<int> digits) {
    const weights = <int>[9, 8, 7, 6, 5, 4, 3, 2, 9];
    var sum = 0;
    for (var i = 0; i < digits.length; i++) {
      sum += digits[i] * weights[i];
    }
    final remainder = sum % 11;
    return remainder == 10 ? 0 : remainder;
  }

  /// Calcula o segundo dígito verificador de uma CNH.
  /// 
  /// Usa o algoritmo oficial de validação de CNH com pesos específicos.
  /// 
  /// Parâmetros:
  ///   - [digits]: Lista com os 10 primeiros dígitos da CNH (9 base + 1º verificador)
  /// 
  /// Retorna:
  ///   Inteiro representando o segundo dígito verificador
  int _calculateCnhSecondDigit(List<int> digits) {
    const weights = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 2];
    var sum = 0;
    for (var i = 0; i < digits.length; i++) {
      sum += digits[i] * weights[i];
    }
    final remainder = sum % 11;
    return remainder == 10 ? 0 : remainder;
  }

  /// Calcula o dígito de controle de uma CNH.
  /// 
  /// Usa o algoritmo oficial de validação de CNH com pesos específicos.
  /// 
  /// Parâmetros:
  ///   - [digits]: Lista com os 11 primeiros dígitos da CNH (9 base + 2 verificadores)
  /// 
  /// Retorna:
  ///   Inteiro representando o dígito de controle
  int _calculateCnhControlDigit(List<int> digits) {
    const weights = <int>[2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4];
    var sum = 0;
    for (var i = 0; i < digits.length; i++) {
      sum += digits[i] * weights[i];
    }
    final remainder = sum % 11;
    return remainder == 10 ? 0 : remainder;
  }

  /// Gera um novo RENAVAM válido.
  /// 
  /// Realiza:
  /// - Geração de 10 dígitos aleatórios
  /// - Rejeição de RENAVAMs com todos os dígitos iguais (inválidos)
  /// - Cálculo do dígito verificador (checksum)
  /// - Formatação do documento (opcional)
  /// 
  /// O RENAVAM possui 11 dígitos no total (10 dígitos base + 1 verificador)
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatado (XX.XXX.XXX.XXX-XX). Padrão: false
  /// 
  /// Retorna:
  ///   String com RENAVAM (com ou sem formatação)
  String generateRenavam({bool formatted = false}) {
    while (true) {
      final digits = List<int>.generate(10, (_) => _random.nextInt(10));
      if (_allSameDigits(digits)) {
        continue;
      }
      final verifyDigit = _calculateRenavamDigit(digits);
      digits.add(verifyDigit);

      final renavam = digits.join();
      if (formatted) {
        return '${renavam.substring(0, 2)}.${renavam.substring(2, 5)}.'
            '${renavam.substring(5, 8)}.${renavam.substring(8, 10)}-'
            '${renavam.substring(10)}';
      } else {
        return renavam;
      }
    }
  }

  /// Valida um RENAVAM informado.
  /// 
  /// Realiza verificações de:
  /// - Extração apenas de dígitos
  /// - Quantidade obrigatória de 11 dígitos
  /// - Rejeição de RENAVAMs com todos os dígitos iguais
  /// - Validação do dígito verificador
  /// 
  /// Parâmetros:
  ///   - [input]: String contendo o RENAVAM (pode ter ou não formatação)
  /// 
  /// Retorna:
  ///   `true` se o RENAVAM é válido, `false` caso contrário
  bool isValidRenavam(String input) {
    final digits = _onlyDigits(input);
    if (digits.length != 11) {
      return false;
    }
    final numbers = digits.split('').map(int.parse).toList();
    if (_allSameDigits(numbers)) {
      return false;
    }
    final verifyDigit = _calculateRenavamDigit(numbers.sublist(0, 10));
    return numbers[10] == verifyDigit;
  }

  /// Calcula o dígito verificador de um RENAVAM.
  /// 
  /// Utiliza o algoritmo oficial de validação de RENAVAM.
  /// A sequência de pesos é: 3, 2, 9, 8, 7, 6, 5, 4, 3, 2
  /// 
  /// Parâmetros:
  ///   - [digits]: Lista com os 10 primeiros dígitos do RENAVAM
  /// 
  /// Retorna:
  ///   Inteiro representando o dígito verificador
  int _calculateRenavamDigit(List<int> digits) {
    const weights = <int>[3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    var sum = 0;
    for (var i = 0; i < digits.length; i++) {
      sum += digits[i] * weights[i];
    }
    final remainder = sum % 11;
    return remainder == 10 ? 0 : remainder;
  }

  /// Gera um novo RG válido.
  /// 
  /// Realiza:
  /// - Geração de 8 dígitos aleatórios para o RG base
  /// - Rejeição de RGs com todos os dígitos iguais (inválidos)
  /// - Cálculo do dígito verificador usando o algoritmo SSP-SP
  /// - Formatação do documento (opcional)
  /// 
  /// O RG possui 9 dígitos no total (8 dígitos base + 1 dígito verificador).
  /// Este gerador utiliza a validação do Órgão Emissor (SSP-SP) como referência.
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatado (XX.XXX.XXX-X). Padrão: false
  /// 
  /// Retorna:
  ///   String com RG (com ou sem formatação)
  String generateRg({bool formatted = false}) {
    while (true) {
      final digits = List<int>.generate(8, (_) => _random.nextInt(10));
      if (_allSameDigits(digits)) {
        continue;
      }
      final verifyDigit = _calculateRgDigit(digits);
      digits.add(verifyDigit);

      final rg = digits.join();
      if (formatted) {
        return '${rg.substring(0, 2)}.${rg.substring(2, 5)}.'
            '${rg.substring(5, 8)}-${rg.substring(8)}';
      } else {
        return rg;
      }
    }
  }

  /// Valida um RG informado.
  /// 
  /// Realiza verificações de:
  /// - Extração apenas de dígitos
  /// - Quantidade obrigatória de 9 dígitos
  /// - Rejeição de RGs com todos os dígitos iguais
  /// - Validação do dígito verificador usando algoritmo SSP-SP
  /// 
  /// Parâmetros:
  ///   - [input]: String contendo o RG (pode ter ou não formatação)
  /// 
  /// Retorna:
  ///   `true` se o RG é válido, `false` caso contrário
  bool isValidRg(String input) {
    final digits = _onlyDigits(input);
    if (digits.length != 9) {
      return false;
    }
    final numbers = digits.split('').map(int.parse).toList();
    if (_allSameDigits(numbers)) {
      return false;
    }
    final verifyDigit = _calculateRgDigit(numbers.sublist(0, 8));
    return numbers[8] == verifyDigit;
  }

  /// Calcula o dígito verificador de um RG usando o algoritmo SSP-SP.
  /// 
  /// Utiliza o algoritmo oficial de validação de RG da Secretaria de Segurança Pública
  /// de São Paulo (SSP-SP). A sequência de pesos é: 2, 3, 4, 5, 6, 7, 8, 9
  /// 
  /// O algoritmo:
  /// 1. Multiplica cada dígito pelo seu respectivo peso
  /// 2. Soma todos os resultados
  /// 3. Calcula o resto da divisão por 11
  /// 4. Se o resto é 0, o dígito é 0; se é 1, o dígito é X; caso contrário o dígito é 11 - resto
  /// 
  /// Parâmetros:
  ///   - [digits]: Lista com os 8 primeiros dígitos do RG
  /// 
  /// Retorna:
  ///   Inteiro representando o dígito verificador (0-9)
  int _calculateRgDigit(List<int> digits) {
    const weights = <int>[2, 3, 4, 5, 6, 7, 8, 9];
    var sum = 0;
    for (var i = 0; i < digits.length; i++) {
      sum += digits[i] * weights[i];
    }
    final remainder = sum % 11;
    if (remainder == 0) {
      return 0;
    } else if (remainder == 1) {
      return 0; // Algumas implementações retornam X, mas usaremos 0 para simplicidade
    } else {
      return 11 - remainder;
    }
  }
}
