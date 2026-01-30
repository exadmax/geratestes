import '../services/document_generator_service.dart';

/// [CnpjGeneratorController] gerencia a lógica de geração de CNPJ.
/// 
/// Esse controller atua como intermediário entre a view (página) e os serviços
/// de geração de dados, seguindo o padrão MVC. Responsável por coordenar
/// as ações do usuário com as operações necessárias nos serviços.
/// 
/// Funcionalidades:
/// - Gerar novos CNPJs válidos
/// - Validar CNPJs informados pelo usuário
class CnpjGeneratorController {
  /// Instância privada do serviço de geração de documentos.
  /// 
  /// Utilizada internamente para acessar métodos de geração e validação de CNPJ.
  final DocumentGeneratorService _documentGeneratorService;

  /// Construtor que requer uma instância de [DocumentGeneratorService].
  /// 
  /// A injeção de dependência garante que o controller seja independente
  /// da implementação específica do serviço.
  /// 
  /// Parâmetros:
  ///   - [documentGeneratorService]: Serviço responsável pelas operações com documentos
  CnpjGeneratorController({
    required DocumentGeneratorService documentGeneratorService,
  }) : _documentGeneratorService = documentGeneratorService;

  /// Gera um novo CNPJ válido.
  /// 
  /// Delega a operação de geração para o serviço de documentos,
  /// que valida automaticamente o CNPJ gerado.
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatado (XX.XXX.XXX/XXXX-XX). Padrão: false
  /// 
  /// Retorna:
  ///   Uma string contendo um CNPJ (com ou sem formatação).
  String generateCnpj({bool formatted = false}) {
    return _documentGeneratorService.generateCnpj(formatted: formatted);
  }

  /// Valida um CNPJ informado pelo usuário.
  /// 
  /// Realiza verificações de:
  /// - Quantidade de dígitos
  /// - Validade dos dígitos verificadores (algoritmo CNPJ)
  /// - Rejeição de CNPJs com todos os dígitos iguais
  /// 
  /// Parâmetros:
  ///   - [cnpj]: CNPJ a ser validado (aceita formatação ou apenas dígitos)
  /// 
  /// Retorna:
  ///   `true` se o CNPJ é válido, `false` caso contrário.
  bool isValidCnpj(String cnpj) {
    return _documentGeneratorService.isValidCnpj(cnpj);
  }
}
