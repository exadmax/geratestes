import 'package:flutter/material.dart';
import '../services/document_generator.dart';
import '../services/person_generator.dart';
import '../services/history_service.dart';
import '../widgets/history_widget.dart';

class HistoryPageExample extends StatefulWidget {
  const HistoryPageExample({super.key});

  @override
  State<HistoryPageExample> createState() => _HistoryPageExampleState();
}

class _HistoryPageExampleState extends State<HistoryPageExample> {
  late HistoryService _historyService;
  late DocumentGenerator _documentGenerator;
  late PersonGenerator _personGenerator;

  @override
  void initState() {
    super.initState();
    _historyService = HistoryService();
    _documentGenerator = DocumentGenerator();
    _personGenerator = PersonGenerator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador com Histórico'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _generatePerson,
              icon: const Icon(Icons.add),
              label: const Text('Gerar Pessoa'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ),
          Expanded(
            child: HistoryWidget(historyService: _historyService),
          ),
        ],
      ),
    );
  }

  void _generatePerson() {
    final person = _personGenerator.generatePerson();
    _historyService.addEntry(
      person.name,
      _documentGenerator.generateCpf(),
      _documentGenerator.generateCnpj(),
    );
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro adicionado ao histórico'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
