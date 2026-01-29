import 'package:flutter/material.dart';

import '../services/document_generator.dart';

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
