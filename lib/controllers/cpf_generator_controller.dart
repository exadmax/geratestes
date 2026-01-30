import '../services/document_generator_service.dart';

/// [CpfGeneratorController] gerencia a lógica de geração de CPF.
/// 
/// Esse controller atua como intermediário entre a view (página) e os serviços
/// de geração de dados, seguindo o padrão MVC. Responsável por coordenar
/// as ações do usuário com as operações necessárias nos serviços.
/// 
/// Funcionalidades:
/// - Gerar novos CPFs válidos
/// - Validar CPFs informados pelo usuário
class CpfGeneratorController {
  /// Instância privada do serviço de geração de documentos.
  /// 
  /// Utilizada internamente para acessar métodos de geração e validação de CPF.
  final DocumentGeneratorService _documentGeneratorService;

  /// Construtor que requer uma instância de [DocumentGeneratorService].
  /// 
  /// A injeção de dependência garante que o controller seja independente
  /// da implementação específica do serviço.
  /// 
  /// Parâmetros:
  ///   - [documentGeneratorService]: Serviço responsável pelas operações com documentos
  CpfGeneratorController({
    required DocumentGeneratorService documentGeneratorService,
  }) : _documentGeneratorService = documentGeneratorService;

  /// Gera um novo CPF válido.
  /// 
  /// Delega a operação de geração para o serviço de documentos,
  /// que valida automaticamente o CPF gerado.
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatado (XXX.XXX.XXX-XX). Padrão: false
  /// 
  /// Retorna:
  ///   Uma string contendo um CPF (com ou sem formatação).
  String generateCpf({bool formatted = false}) {
    return _documentGeneratorService.generateCpf(formatted: formatted);
  }

  /// Valida um CPF informado pelo usuário.
  /// 
  /// Realiza verificações de:
  /// - Quantidade de dígitos
  /// - Validade dos dígitos verificadores (algoritmo CPF)
  /// - Rejeição de CPFs com todos os dígitos iguais
  /// 
  /// Parâmetros:
  ///   - [cpf]: CPF a ser validado (aceita formatação ou apenas dígitos)
  /// 
  /// Retorna:
  ///   `true` se o CPF é válido, `false` caso contrário.
  bool isValidCpf(String cpf) {
    return _documentGeneratorService.isValidCpf(cpf);
  }
}
