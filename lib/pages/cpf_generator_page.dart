import 'package:flutter/material.dart';

import '../services/document_generator.dart';

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
