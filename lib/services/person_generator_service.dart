import 'dart:math';

import '../models/city_entry.dart';
import '../models/name_entry.dart';
import '../models/person_data.dart';
import 'document_generator_service.dart';

/// [PersonGeneratorService] é responsável pela geração de dados completos de pessoas.
/// 
/// Esse serviço encapsula toda a lógica de geração de dados realistas de pessoas,
/// incluindo nome, sobrenome, gênero, endereço completo, documentação, etc.
/// Utiliza listas pré-definidas de nomes, sobrenomes, cidades e outros dados
/// brasileiros para gerar informações que parecem realistas.
/// 
/// Responsabilidades:
/// - Gerar dados completos de pessoa
/// - Selecionar aleatoriamente nomes, sobrenomes, endereços, etc
/// - Gerar documentos válidos para acompanhar a pessoa
/// - Criar uma [PersonData] consistente e realista
class PersonGeneratorService {
  /// Instância privada do gerador de números aleatórios.
  final Random _random;

  /// Instância privada do serviço de geração de documentos.
  /// 
  /// Utilizada para gerar CPF válido junto com os dados da pessoa.
  final DocumentGeneratorService _documentGeneratorService;

  /// Construtor padrão que inicializa o gerador de números aleatórios
  /// e injeta o serviço de documentos.
  PersonGeneratorService({
    DocumentGeneratorService? documentGeneratorService,
  })  : _random = Random(),
        _documentGeneratorService =
            documentGeneratorService ?? DocumentGeneratorService();

  /// Lista estática de nomes próprios com seus gêneros associados.
  /// 
  /// Contém 40 nomes brasileiros divididos entre masculinos (H) e femininos (M).
  static const _names = <NameEntry>[
    NameEntry('Miguel', 'H'),
    NameEntry('Arthur', 'H'),
    NameEntry('Heitor', 'H'),
    NameEntry('Theo', 'H'),
    NameEntry('Davi', 'H'),
    NameEntry('Bernardo', 'H'),
    NameEntry('Gabriel', 'H'),
    NameEntry('Pedro', 'H'),
    NameEntry('Lucas', 'H'),
    NameEntry('Mateus', 'H'),
    NameEntry('Rafael', 'H'),
    NameEntry('Guilherme', 'H'),
    NameEntry('Gustavo', 'H'),
    NameEntry('Henrique', 'H'),
    NameEntry('Bruno', 'H'),
    NameEntry('João', 'H'),
    NameEntry('Caio', 'H'),
    NameEntry('Felipe', 'H'),
    NameEntry('Thiago', 'H'),
    NameEntry('Leonardo', 'H'),
    NameEntry('Alice', 'M'),
    NameEntry('Helena', 'M'),
    NameEntry('Laura', 'M'),
    NameEntry('Maria', 'M'),
    NameEntry('Cecília', 'M'),
    NameEntry('Sophia', 'M'),
    NameEntry('Júlia', 'M'),
    NameEntry('Manuela', 'M'),
    NameEntry('Isabella', 'M'),
    NameEntry('Luiza', 'M'),
    NameEntry('Valentina', 'M'),
    NameEntry('Heloísa', 'M'),
    NameEntry('Lívia', 'M'),
    NameEntry('Beatriz', 'M'),
    NameEntry('Carolina', 'M'),
    NameEntry('Mariana', 'M'),
    NameEntry('Ana', 'M'),
    NameEntry('Camila', 'M'),
    NameEntry('Larissa', 'M'),
    NameEntry('Juliana', 'M'),
  ];

  /// Lista estática de sobrenomes brasileiros comuns.
  /// 
  /// Contém 25 dos sobrenomes mais comuns no Brasil.
  static const _surnames = <String>[
    'Silva',
    'Santos',
    'Oliveira',
    'Souza',
    'Rodrigues',
    'Ferreira',
    'Almeida',
    'Costa',
    'Gomes',
    'Martins',
    'Lima',
    'Barbosa',
    'Ribeiro',
    'Carvalho',
    'Dias',
    'Teixeira',
    'Araújo',
    'Melo',
    'Moreira',
    'Pereira',
    'Cardoso',
    'Correia',
    'Nogueira',
    'Monteiro',
    'Rocha',
  ];

  /// Lista estática de tipos de logradouros.
  /// 
  /// Utilizados para gerar nomes de endereços realistas.
  static const _streetTypes = <String>[
    'Rua',
    'Avenida',
    'Travessa',
    'Alameda',
    'Praça',
    'Estrada',
  ];

  /// Lista estática de nomes de ruas/avenidas.
  /// 
  /// Utilizados para gerar endereços realistas.
  static const _streetNames = <String>[
    'das Flores',
    'dos Pinheiros',
    'São João',
    'Paulista',
    'Independência',
    'Sete de Setembro',
    'Castro Alves',
    'Rio Branco',
    'Dom Pedro',
    'Bela Vista',
    'Boa Esperança',
    'Vila Nova',
    'Brasil',
    'Parque Central',
    'Santa Clara',
  ];

  /// Lista estática de bairros.
  /// 
  /// Utilizados para completar o endereço gerado.
  static const _neighborhoods = <String>[
    'Centro',
    'Jardins',
    'Boa Vista',
    'Vila Mariana',
    'Copacabana',
    'Santa Luzia',
    'Nova Esperança',
    'Pioneiros',
    'Parque das Nações',
    'Jardim América',
  ];

  /// Lista estática de cidades com seus estados.
  /// 
  /// Contém as 15 maiores cidades do Brasil como referência.
  static const _cities = <CityEntry>[
    CityEntry('São Paulo', 'SP'),
    CityEntry('Rio de Janeiro', 'RJ'),
    CityEntry('Belo Horizonte', 'MG'),
    CityEntry('Curitiba', 'PR'),
    CityEntry('Florianópolis', 'SC'),
    CityEntry('Porto Alegre', 'RS'),
    CityEntry('Salvador', 'BA'),
    CityEntry('Fortaleza', 'CE'),
    CityEntry('Recife', 'PE'),
    CityEntry('Brasília', 'DF'),
    CityEntry('Goiânia', 'GO'),
    CityEntry('Manaus', 'AM'),
    CityEntry('Belém', 'PA'),
    CityEntry('Vitória', 'ES'),
    CityEntry('Natal', 'RN'),
  ];

  /// Lista estática de todos os estados brasileiros (UF).
  /// 
  /// Utilizada para gerar estados alternativos ao selecionado da cidade.
  static const _states = <String>[
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO',
  ];

  /// Lista estática de complementos de endereço.
  /// 
  /// Utilizados para adicionar detalhes ao endereço quando aplicável.
  static const _complements = <String>[
    'Apto 101',
    'Apto 202',
    'Casa 3',
    'Bloco B',
    'Fundos',
    'Sala 5',
    'Cobertura',
    'Lote 12',
    'Loja 2',
  ];

  /// Gera uma nova pessoa com dados completos e realistas.
  /// 
  /// Combina:
  /// - Um nome aleatório com gênero associado
  /// - Um sobrenome (simples ou composto)
  /// - Uma cidade e estado do Brasil
  /// - Um endereço completo (tipo de via, nome, número, bairro)
  /// - Um CEP aleatório
  /// - Uma idade entre 1 e 99 anos
  /// - Um complemento de endereço opcional
  /// - Um CPF válido
  /// - Uma CNH válida
  /// 
  /// Retorna:
  ///   Uma instância de [PersonData] com todos os dados preenchidos.
  PersonData generate() {
    final entry = _names[_random.nextInt(_names.length)];
    final lastName = _randomLastName();
    final cityEntry = _cities[_random.nextInt(_cities.length)];
    final state = _states[_random.nextInt(_states.length)];
    final number = (1 + _random.nextInt(9999)).toString();
    final complement = _random.nextBool()
        ? _complements[_random.nextInt(_complements.length)]
        : 'Sem complemento';

    return PersonData(
      firstName: entry.name,
      lastName: lastName,
      gender: entry.gender,
      cpf: _documentGeneratorService.generateCpf(),
      cnh: _documentGeneratorService.generateCnh(),
      rg: _documentGeneratorService.generateRg(),
      address: _generateAddress(),
      cep: _generateCep(),
      age: _randomAge(),
      state: state,
      city: cityEntry.name,
      number: number,
      complement: complement,
    );
  }

  /// Seleciona um sobrenome aleatório, podendo ser simples ou composto.
  /// 
  /// Com 50% de chance, combina dois sobrenomes aleatórios.
  /// Se os dois forem iguais, retorna apenas um.
  /// 
  /// Retorna:
  ///   String contendo um ou dois sobrenomes separados por espaço.
  String _randomLastName() {
    final first = _surnames[_random.nextInt(_surnames.length)];
    if (_random.nextBool()) {
      final second = _surnames[_random.nextInt(_surnames.length)];
      if (second == first) {
        return first;
      }
      return '$first $second';
    }
    return first;
  }

  /// Gera uma idade aleatória entre 1 e 99 anos.
  /// 
  /// Retorna:
  ///   Inteiro entre 1 e 99 (inclusive).
  int _randomAge() => 1 + _random.nextInt(99);

  /// Gera um endereço realista combinando tipo de via, nome e bairro.
  /// 
  /// Formato: "[Tipo] [Nome], [Bairro]"
  /// Exemplo: "Rua das Flores, Centro"
  /// 
  /// Retorna:
  ///   String contendo o endereço sem número ou complemento.
  String _generateAddress() {
    final type = _streetTypes[_random.nextInt(_streetTypes.length)];
    final name = _streetNames[_random.nextInt(_streetNames.length)];
    final neighborhood =
        _neighborhoods[_random.nextInt(_neighborhoods.length)];
    return '$type $name, $neighborhood';
  }

  /// Gera um CEP (Código de Endereçamento Postal) aleatório.
  /// 
  /// Não valida se o CEP existe, apenas gera um formato válido.
  /// Formato: "XXXXX-XXX"
  /// 
  /// Retorna:
  ///   String com CEP formatado no padrão brasileiro.
  String _generateCep() {
    final digits = List<int>.generate(8, (_) => _random.nextInt(10));
    final cep = digits.join();
    return '${cep.substring(0, 5)}-${cep.substring(5)}';
  }
}
