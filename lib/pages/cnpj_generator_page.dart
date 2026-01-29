import 'package:flutter/material.dart';

import '../services/document_generator.dart';

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
