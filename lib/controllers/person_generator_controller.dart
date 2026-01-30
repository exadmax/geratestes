import '../models/person_data.dart';
import '../services/person_generator_service.dart';

/// [PersonGeneratorController] gerencia a lógica de geração de dados de pessoa.
/// 
/// Esse controller atua como intermediário entre a view (página) e os serviços
/// de geração de dados, seguindo o padrão MVC. Responsável por coordenar
/// as ações do usuário com as operações de geração de dados de pessoa.
/// 
/// Funcionalidades:
/// - Gerar novas pessoas com dados completos
/// - Fornecer acesso aos dados da pessoa gerada
class PersonGeneratorController {
  /// Instância privada do serviço de geração de pessoa.
  /// 
  /// Utilizada internamente para acessar métodos de geração de dados completos de pessoa.
  final PersonGeneratorService _personGeneratorService;

  /// Construtor que requer uma instância de [PersonGeneratorService].
  /// 
  /// A injeção de dependência garante que o controller seja independente
  /// da implementação específica do serviço.
  /// 
  /// Parâmetros:
  ///   - [personGeneratorService]: Serviço responsável pelas operações de geração de pessoa
  PersonGeneratorController({
    required PersonGeneratorService personGeneratorService,
  }) : _personGeneratorService = personGeneratorService;

  /// Gera uma nova pessoa com dados completos aleatórios.
  /// 
  /// Delega a operação de geração para o serviço de pessoa, que combina
  /// informações de múltiplas fontes (nomes, cidades, documentos, endereços)
  /// para criar um perfil completo e realista.
  /// 
  /// Retorna:
  ///   Uma instância de [PersonData] contendo todos os dados gerados da pessoa.
  PersonData generatePerson() {
    return _personGeneratorService.generate();
  }
}
