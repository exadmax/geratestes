import 'package:flutter/material.dart';

import '../services/document_generator.dart';

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
