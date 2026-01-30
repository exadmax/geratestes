import '../services/document_generator_service.dart';

/// [CnhGeneratorController] gerencia a lógica de geração de CNH.
/// 
/// Esse controller atua como intermediário entre a view (página) e os serviços
/// de geração de dados, seguindo o padrão MVC. Responsável por coordenar
/// as ações do usuário com as operações necessárias nos serviços.
/// 
/// Funcionalidades:
/// - Gerar novas CNHs válidas
/// - Validar CNHs informadas pelo usuário
class CnhGeneratorController {
  /// Instância privada do serviço de geração de documentos.
  /// 
  /// Utilizada internamente para acessar métodos de geração e validação de CNH.
  final DocumentGeneratorService _documentGeneratorService;

  /// Construtor que requer uma instância de [DocumentGeneratorService].
  /// 
  /// A injeção de dependência garante que o controller seja independente
  /// da implementação específica do serviço.
  /// 
  /// Parâmetros:
  ///   - [documentGeneratorService]: Serviço responsável pelas operações com documentos
  CnhGeneratorController({
    required DocumentGeneratorService documentGeneratorService,
  }) : _documentGeneratorService = documentGeneratorService;

  /// Gera uma nova CNH válida.
  /// 
  /// Delega a operação de geração para o serviço de documentos,
  /// que valida automaticamente a CNH gerada.
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatada (XXXXXXXXXX-XX). Padrão: false
  /// 
  /// Retorna:
  ///   Uma string contendo uma CNH (com ou sem formatação).
  String generateCnh({bool formatted = false}) {
    return _documentGeneratorService.generateCnh(formatted: formatted);
  }

  /// Valida uma CNH informada pelo usuário.
  /// 
  /// Realiza verificações de:
  /// - Quantidade de dígitos
  /// - Validade dos dígitos verificadores (algoritmo CNH)
  /// - Rejeição de CNHs com todos os dígitos iguais
  /// 
  /// Parâmetros:
  ///   - [cnh]: CNH a ser validada (aceita formatação ou apenas dígitos)
  /// 
  /// Retorna:
  ///   `true` se a CNH é válida, `false` caso contrário
  bool isValidCnh(String cnh) {
    return _documentGeneratorService.isValidCnh(cnh);
  }
}
