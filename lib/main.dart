import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const GeratestesApp());
}

class GeratestesApp extends StatelessWidget {
  const GeratestesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );

    return MaterialApp(
      title: 'Geratestes',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomeMenuPage(),
    );
  }
}

class HomeMenuPage extends StatelessWidget {
  const HomeMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geratestes'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MenuCard(
            title: 'Gerador de CPF',
            subtitle: 'Gere CPFs válidos com padrão brasileiro',
            icon: Icons.badge_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CpfGeneratorPage()),
            ),
          ),
          _MenuCard(
            title: 'Gerador de CNPJ',
            subtitle: 'Gere CNPJs válidos com padrão brasileiro',
            icon: Icons.apartment_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CnpjGeneratorPage()),
            ),
          ),
          _MenuCard(
            title: 'Checagem de CPF',
            subtitle: 'Valide CPFs informados',
            icon: Icons.verified_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CpfCheckPage()),
            ),
          ),
          _MenuCard(
            title: 'Checagem de CNPJ',
            subtitle: 'Valide CNPJs informados',
            icon: Icons.domain_verification_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CnpjCheckPage()),
            ),
          ),
          _MenuCard(
            title: 'Gerador de Pessoa Física',
            subtitle: 'Dados completos para testes',
            icon: Icons.person_outline,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PersonGeneratorPage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class CpfGeneratorPage extends StatefulWidget {
  const CpfGeneratorPage({super.key});

  @override
  State<CpfGeneratorPage> createState() => _CpfGeneratorPageState();
}

class _CpfGeneratorPageState extends State<CpfGeneratorPage> {
  final _generator = DocumentGenerator();
  late String _cpf;

  @override
  void initState() {
    super.initState();
    _cpf = _generator.generateCpf();
  }

  void _regenerate() {
    setState(() {
      _cpf = _generator.generateCpf();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerador de CPF')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('CPF gerado'),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  _cpf,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _regenerate,
              icon: const Icon(Icons.refresh),
              label: const Text('Gerar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}

class CnpjGeneratorPage extends StatefulWidget {
  const CnpjGeneratorPage({super.key});

  @override
  State<CnpjGeneratorPage> createState() => _CnpjGeneratorPageState();
}

class _CnpjGeneratorPageState extends State<CnpjGeneratorPage> {
  final _generator = DocumentGenerator();
  late String _cnpj;

  @override
  void initState() {
    super.initState();
    _cnpj = _generator.generateCnpj();
  }

  void _regenerate() {
    setState(() {
      _cnpj = _generator.generateCnpj();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerador de CNPJ')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('CNPJ gerado'),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  _cnpj,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _regenerate,
              icon: const Icon(Icons.refresh),
              label: const Text('Gerar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}

class CpfCheckPage extends StatefulWidget {
  const CpfCheckPage({super.key});

  @override
  State<CpfCheckPage> createState() => _CpfCheckPageState();
}

class _CpfCheckPageState extends State<CpfCheckPage> {
  final _controller = TextEditingController();
  final _generator = DocumentGenerator();
  String? _result;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    final value = _controller.text;
    final isValid = _generator.isValidCpf(value);
    setState(() {
      _result = isValid ? 'CPF válido' : 'CPF inválido';
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(title: const Text('Checagem de CPF')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o CPF',
                hintText: '000.000.000-00',
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _check,
              child: const Text('Checar'),
            ),
            const SizedBox(height: 16),
            if (_result != null)
              Text(
                _result!,
                style: resultStyle,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}

class CnpjCheckPage extends StatefulWidget {
  const CnpjCheckPage({super.key});

  @override
  State<CnpjCheckPage> createState() => _CnpjCheckPageState();
}

class _CnpjCheckPageState extends State<CnpjCheckPage> {
  final _controller = TextEditingController();
  final _generator = DocumentGenerator();
  String? _result;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    final value = _controller.text;
    final isValid = _generator.isValidCnpj(value);
    setState(() {
      _result = isValid ? 'CNPJ válido' : 'CNPJ inválido';
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(title: const Text('Checagem de CNPJ')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o CNPJ',
                hintText: '00.000.000/0000-00',
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _check,
              child: const Text('Checar'),
            ),
            const SizedBox(height: 16),
            if (_result != null)
              Text(
                _result!,
                style: resultStyle,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}

class PersonGeneratorPage extends StatefulWidget {
  const PersonGeneratorPage({super.key});

  @override
  State<PersonGeneratorPage> createState() => _PersonGeneratorPageState();
}

class _PersonGeneratorPageState extends State<PersonGeneratorPage> {
  final _generator = PersonGenerator();
  late PersonData _person;

  @override
  void initState() {
    super.initState();
    _person = _generator.generate();
  }

  void _regenerate() {
    setState(() {
      _person = _generator.generate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerador de Pessoa Física')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Dados brasileiros para testes',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _PersonInfoCard(person: _person),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _regenerate,
                icon: const Icon(Icons.refresh),
                label: const Text('Gerar novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonInfoCard extends StatelessWidget {
  const _PersonInfoCard({required this.person});

  final PersonData person;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _FieldRow(label: 'Nome', value: person.fullName),
            _FieldRow(label: 'Sexo', value: person.gender),
            _FieldRow(label: 'Sobrenome', value: person.lastName),
            _FieldRow(label: 'Idade', value: person.age.toString()),
            _FieldRow(label: 'Estado', value: person.state),
            _FieldRow(label: 'Cidade', value: person.city),
            _FieldRow(label: 'Endereço', value: person.address),
            _FieldRow(label: 'Número', value: person.number),
            _FieldRow(label: 'Complemento', value: person.complement),
            _FieldRow(label: 'CPF', value: person.cpf),
            _FieldRow(label: 'CEP', value: person.cep),
          ],
        ),
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelLarge;
    final valueStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.w600);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelStyle),
          const SizedBox(height: 4),
          SelectableText(value, style: valueStyle),
        ],
      ),
    );
  }
}

class PersonData {
  const PersonData({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.cpf,
    required this.address,
    required this.cep,
    required this.age,
    required this.state,
    required this.city,
    required this.number,
    required this.complement,
  });

  final String firstName;
  final String lastName;
  final String gender;
  final String cpf;
  final String address;
  final String cep;
  final int age;
  final String state;
  final String city;
  final String number;
  final String complement;

  String get fullName => '$firstName $lastName';
}

class PersonGenerator {
  PersonGenerator()
      : _random = Random(),
        _documentGenerator = DocumentGenerator();

  final Random _random;
  final DocumentGenerator _documentGenerator;

  static const _names = <_NameEntry>[
    _NameEntry('Miguel', 'H'),
    _NameEntry('Arthur', 'H'),
    _NameEntry('Heitor', 'H'),
    _NameEntry('Theo', 'H'),
    _NameEntry('Davi', 'H'),
    _NameEntry('Bernardo', 'H'),
    _NameEntry('Gabriel', 'H'),
    _NameEntry('Pedro', 'H'),
    _NameEntry('Lucas', 'H'),
    _NameEntry('Mateus', 'H'),
    _NameEntry('Rafael', 'H'),
    _NameEntry('Guilherme', 'H'),
    _NameEntry('Gustavo', 'H'),
    _NameEntry('Henrique', 'H'),
    _NameEntry('Bruno', 'H'),
    _NameEntry('João', 'H'),
    _NameEntry('Caio', 'H'),
    _NameEntry('Felipe', 'H'),
    _NameEntry('Thiago', 'H'),
    _NameEntry('Leonardo', 'H'),
    _NameEntry('Alice', 'M'),
    _NameEntry('Helena', 'M'),
    _NameEntry('Laura', 'M'),
    _NameEntry('Maria', 'M'),
    _NameEntry('Cecília', 'M'),
    _NameEntry('Sophia', 'M'),
    _NameEntry('Júlia', 'M'),
    _NameEntry('Manuela', 'M'),
    _NameEntry('Isabella', 'M'),
    _NameEntry('Luiza', 'M'),
    _NameEntry('Valentina', 'M'),
    _NameEntry('Heloísa', 'M'),
    _NameEntry('Lívia', 'M'),
    _NameEntry('Beatriz', 'M'),
    _NameEntry('Carolina', 'M'),
    _NameEntry('Mariana', 'M'),
    _NameEntry('Ana', 'M'),
    _NameEntry('Camila', 'M'),
    _NameEntry('Larissa', 'M'),
    _NameEntry('Juliana', 'M'),
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

  static const _cities = <_CityEntry>[
    _CityEntry('São Paulo', 'SP'),
    _CityEntry('Rio de Janeiro', 'RJ'),
    _CityEntry('Belo Horizonte', 'MG'),
    _CityEntry('Curitiba', 'PR'),
    _CityEntry('Florianópolis', 'SC'),
    _CityEntry('Porto Alegre', 'RS'),
    _CityEntry('Salvador', 'BA'),
    _CityEntry('Fortaleza', 'CE'),
    _CityEntry('Recife', 'PE'),
    _CityEntry('Brasília', 'DF'),
    _CityEntry('Goiânia', 'GO'),
    _CityEntry('Manaus', 'AM'),
    _CityEntry('Belém', 'PA'),
    _CityEntry('Vitória', 'ES'),
    _CityEntry('Natal', 'RN'),
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

class _NameEntry {
  const _NameEntry(this.name, this.gender);

  final String name;
  final String gender;
}

class _CityEntry {
  const _CityEntry(this.name, this.uf);

  final String name;
  final String uf;
}
