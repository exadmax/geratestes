import '../services/document_generator_service.dart';

/// [RenavamGeneratorController] gerencia a lógica de geração de RENAVAM.
/// 
/// Esse controller atua como intermediário entre a view (página) e os serviços
/// de geração de dados, seguindo o padrão MVC. Responsável por coordenar
/// as ações do usuário com as operações necessárias nos serviços.
/// 
/// Funcionalidades:
/// - Gerar novos RENAVAMs válidos
/// - Validar RENAVAMs informados pelo usuário
class RenavamGeneratorController {
  /// Instância privada do serviço de geração de documentos.
  /// 
  /// Utilizada internamente para acessar métodos de geração e validação de RENAVAM.
  final DocumentGeneratorService _documentGeneratorService;

  /// Construtor que requer uma instância de [DocumentGeneratorService].
  /// 
  /// A injeção de dependência garante que o controller seja independente
  /// da implementação específica do serviço.
  /// 
  /// Parâmetros:
  ///   - [documentGeneratorService]: Serviço responsável pelas operações com documentos
  RenavamGeneratorController({
    required DocumentGeneratorService documentGeneratorService,
  }) : _documentGeneratorService = documentGeneratorService;

  /// Gera um novo RENAVAM válido.
  /// 
  /// Delega a operação de geração para o serviço de documentos,
  /// que valida automaticamente o RENAVAM gerado.
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatado (XX.XXX.XXX.XXX-XX). Padrão: false
  /// 
  /// Retorna:
  ///   Uma string contendo um RENAVAM (com ou sem formatação).
  String generateRenavam({bool formatted = false}) {
    return _documentGeneratorService.generateRenavam(formatted: formatted);
  }

  /// Valida um RENAVAM informado pelo usuário.
  /// 
  /// Realiza verificações de:
  /// - Quantidade de dígitos (obrigatoriamente 11)
  /// - Validade do dígito verificador (algoritmo RENAVAM)
  /// - Rejeição de RENAVAMs com todos os dígitos iguais
  /// 
  /// Parâmetros:
  ///   - [renavam]: RENAVAM a ser validado (aceita formatação ou apenas dígitos)
  /// 
  /// Retorna:
  ///   `true` se o RENAVAM é válido, `false` caso contrário.
  bool isValidRenavam(String renavam) {
    return _documentGeneratorService.isValidRenavam(renavam);
  }
}
