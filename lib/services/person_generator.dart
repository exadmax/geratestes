import 'dart:math';

import '../models/city_entry.dart';
import '../models/name_entry.dart';
import '../models/person_data.dart';
import 'document_generator.dart';

class PersonGenerator {
  PersonGenerator()
      : _random = Random(),
        _documentGenerator = DocumentGenerator();

  final Random _random;
  final DocumentGenerator _documentGenerator;

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

  static const _streetTypes = <String>[
    'Rua',
    'Avenida',
    'Travessa',
    'Alameda',
    'Praça',
    'Estrada',
  ];

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
      cpf: _documentGenerator.generateCpf(),
      address: _generateAddress(),
      cep: _generateCep(),
      age: _randomAge(),
      state: state,
      city: cityEntry.name,
      number: number,
      complement: complement,
    );
  }

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

  int _randomAge() => 1 + _random.nextInt(99);

  String _generateAddress() {
    final type = _streetTypes[_random.nextInt(_streetTypes.length)];
    final name = _streetNames[_random.nextInt(_streetNames.length)];
    final neighborhood =
        _neighborhoods[_random.nextInt(_neighborhoods.length)];
    return '$type $name, $neighborhood';
  }

  String _generateCep() {
    final digits = List<int>.generate(8, (_) => _random.nextInt(10));
    final cep = digits.join();
    return '${cep.substring(0, 5)}-${cep.substring(5)}';
  }
}
