import 'package:flutter/material.dart';

import '../models/person_data.dart';
import '../services/person_generator.dart';
import '../widgets/person_info_card.dart';

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
                    PersonInfoCard(person: _person),
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
