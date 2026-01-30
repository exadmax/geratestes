import '../services/document_generator_service.dart';

/// [RgGeneratorController] gerencia a lógica de geração e validação de RG.
/// 
/// Esse controller atua como intermediário entre a view (página) e os serviços
/// de geração de dados, seguindo o padrão MVC. Responsável por coordenar
/// as ações do usuário com as operações necessárias nos serviços.
/// 
/// Funcionalidades:
/// - Gerar novos RGs válidos
/// - Validar RGs informados pelo usuário
/// - Suportar formatação com ou sem pontos
class RgGeneratorController {
  /// Instância privada do serviço de geração de documentos.
  /// 
  /// Utilizada internamente para acessar métodos de geração e validação de RG.
  final DocumentGeneratorService _documentGeneratorService;

  /// Construtor que requer uma instância de [DocumentGeneratorService].
  /// 
  /// A injeção de dependência garante que o controller seja independente
  /// da implementação específica do serviço.
  /// 
  /// Parâmetros:
  ///   - [documentGeneratorService]: Serviço responsável pelas operações com documentos
  RgGeneratorController({
    required DocumentGeneratorService documentGeneratorService,
  }) : _documentGeneratorService = documentGeneratorService;

  /// Gera um novo RG válido.
  /// 
  /// Delega a operação de geração para o serviço de documentos,
  /// que valida automaticamente o RG gerado.
  /// 
  /// Parâmetros:
  ///   - [formatted]: Se true, retorna formatado (XX.XXX.XXX-X). Padrão: false
  /// 
  /// Retorna:
  ///   Uma string contendo um RG (com ou sem formatação).
  String generateRg({bool formatted = false}) {
    return _documentGeneratorService.generateRg(formatted: formatted);
  }

  /// Valida um RG informado pelo usuário.
  /// 
  /// Realiza verificações de:
  /// - Quantidade de dígitos
  /// - Validade do dígito verificador (algoritmo SSP-SP)
  /// - Rejeição de RGs com todos os dígitos iguais
  /// 
  /// Parâmetros:
  ///   - [rg]: RG a ser validado (aceita formatação ou apenas dígitos)
  /// 
  /// Retorna:
  ///   `true` se o RG é válido, `false` caso contrário.
  bool isValidRg(String rg) {
    return _documentGeneratorService.isValidRg(rg);
  }
}
