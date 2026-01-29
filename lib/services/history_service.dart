import 'dart:convert';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:html' as html;

class HistoryEntry {
  HistoryEntry({
    required this.id,
    required this.name,
    required this.cpf,
    required this.cnpj,
    required this.timestamp,
  });

  final String id;
  final String name;
  final String cpf;
  final String cnpj;
  final DateTime timestamp;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'cnpj': cnpj,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      cpf: json['cpf'] as String,
      cnpj: json['cnpj'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

class HistoryService {
  static const String _storageKey = 'person_history';
  late html.Storage _storage;
  List<HistoryEntry> _history = [];

  HistoryService() {
    _storage = html.window.sessionStorage;
    _loadHistory();
  }

  void _loadHistory() {
    final jsonString = _storage[_storageKey];
    if (jsonString != null) {
      try {
        final jsonList = jsonDecode(jsonString) as List<dynamic>;
        _history = jsonList
            .map((item) => HistoryEntry.fromJson(item as Map<String, dynamic>))
            .toList();
        _history.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      } catch (e) {
        _history = [];
      }
    }
  }

  void _saveHistory() {
    final jsonList = _history.map((entry) => entry.toJson()).toList();
    _storage[_storageKey] = jsonEncode(jsonList);
  }

  void addEntry(String name, String cpf, String cnpj) {
    final entry = HistoryEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      cpf: cpf,
      cnpj: cnpj,
      timestamp: DateTime.now(),
    );
    _history.insert(0, entry);
    _saveHistory();
  }

  List<HistoryEntry> getHistory() {
    return List.unmodifiable(_history);
  }

  void clearHistory() {
    _history.clear();
    _storage.remove(_storageKey);
  }

  void removeEntry(String id) {
    _history.removeWhere((entry) => entry.id == id);
    _saveHistory();
  }

  int getHistoryCount() {
    return _history.length;
  }
}
