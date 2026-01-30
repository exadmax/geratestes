import 'dart:convert';
import 'dart:html' as html;

import '../models/history_entry.dart';

/// [HistoryRepository] gerencia a persistência de histórico no storage local.
/// 
/// Essa classe atua como repositório (padrão Repository) para o histórico,
/// abstraindo a implementação de persistência dos dados. Atualmente utiliza
/// sessionStorage do navegador para armazenar as entradas de histórico.
/// 
/// Responsabilidades:
/// - Carregar histórico do storage
/// - Salvar histórico no storage
/// - Gerenciar CRUD de entradas de histórico
class HistoryRepository {
  /// Chave utilizada no sessionStorage para armazenar o histórico.
  static const String _storageKey = 'person_history';

  /// Referência ao sessionStorage do navegador (ambiente web).
  late html.Storage _storage;

  /// Lista interna que armazena em memória as entradas de histórico.
  /// 
  /// Mantém uma cópia sincronizada com o sessionStorage.
  List<HistoryEntry> _history = [];

  /// Construtor padrão que inicializa o repositório.
  /// 
  /// Realiza:
  /// - Acesso ao sessionStorage do navegador
  /// - Carregamento do histórico persistido
  HistoryRepository() {
    _storage = html.window.sessionStorage;
    _loadHistory();
  }

  /// Carrega o histórico do sessionStorage para memória.
  /// 
  /// Realiza:
  /// - Leitura da string JSON do storage
  /// - Desserialização para lista de [HistoryEntry]
  /// - Ordenação decrescente por timestamp
  /// - Tratamento de erros de desserialização
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

  /// Salva o histórico em memória no sessionStorage.
  /// 
  /// Realiza:
  /// - Serialização de toda a lista para JSON
  /// - Escrita no sessionStorage
  /// - Atualização do storage local
  void _saveHistory() {
    final jsonList = _history.map((entry) => entry.toJson()).toList();
    _storage[_storageKey] = jsonEncode(jsonList);
  }

  /// Adiciona um novo registro ao histórico.
  /// 
  /// Cria uma nova [HistoryEntry] com timestamp atual e ID único,
  /// insere no início da lista (mais recentes primeiro) e persiste.
  /// 
  /// Parâmetros:
  ///   - [name]: Nome gerado ou informado
  ///   - [cpf]: CPF gerado ou informado
  ///   - [cnpj]: CNPJ gerado ou informado
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

  /// Recupera o histórico completo de forma imutável.
  /// 
  /// Retorna uma cópia imutável da lista para impedir modificações
  /// acidentais da estrutura interna do repositório.
  /// 
  /// Retorna:
  ///   Lista imutável de [HistoryEntry] ordenada por data decrescente.
  List<HistoryEntry> getHistory() {
    return List.unmodifiable(_history);
  }

  /// Limpa completamente o histórico.
  /// 
  /// Remove todos os registros da memória e do sessionStorage.
  /// Essa operação é irreversível.
  void clearHistory() {
    _history.clear();
    _storage.remove(_storageKey);
  }

  /// Remove um registro específico pelo seu ID.
  /// 
  /// Localiza e remove o registro com o ID especificado,
  /// depois persiste as mudanças no storage.
  /// 
  /// Parâmetros:
  ///   - [id]: Identificador único do registro a ser removido
  void removeEntry(String id) {
    _history.removeWhere((entry) => entry.id == id);
    _saveHistory();
  }

  /// Obtém a contagem total de registros no histórico.
  /// 
  /// Retorna:
  ///   Número inteiro representando a quantidade de entradas.
  int getHistoryCount() {
    return _history.length;
  }
}
