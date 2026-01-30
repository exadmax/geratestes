import '../models/history_entry.dart';
import '../repositories/history_repository.dart';

/// [HistoryService] encapsula a lógica de negócio relacionada ao histórico.
/// 
/// Esse serviço atua como intermediário entre os controllers e o repositório,
/// fornecendo operações de alto nível relacionadas ao histórico.
/// Abstrai a implementação específica de persistência do repositório.
/// 
/// Responsabilidades:
/// - Coordenar operações de histórico
/// - Fornecer métodos de alto nível para manipulação do histórico
/// - Delegar persistência para o repositório
class HistoryService {
  /// Instância privada do repositório de histórico.
  /// 
  /// Responsável pela persistência e recuperação de dados.
  final HistoryRepository _repository;

  /// Construtor que injeta o repositório de histórico.
  /// 
  /// Parâmetros:
  ///   - [repository]: Repositório para gerenciar persistência do histórico
  HistoryService({required HistoryRepository repository})
      : _repository = repository;

  /// Adiciona um novo registro ao histórico.
  /// 
  /// Delega ao repositório a persistência do registro.
  /// 
  /// Parâmetros:
  ///   - [name]: Nome gerado ou informado
  ///   - [cpf]: CPF gerado ou informado
  ///   - [cnpj]: CNPJ gerado ou informado
  void addEntry(String name, String cpf, String cnpj) {
    _repository.addEntry(name, cpf, cnpj);
  }

  /// Recupera o histórico completo de registros.
  /// 
  /// Retorna uma lista imutável para prevenir modificações externas.
  /// 
  /// Retorna:
  ///   Lista imutável de [HistoryEntry] ordenada por data decrescente.
  List<HistoryEntry> getHistory() {
    return _repository.getHistory();
  }

  /// Limpa completamente o histórico de registros.
  /// 
  /// Remove todos os registros armazenados.
  /// Operação irreversível.
  void clearHistory() {
    _repository.clearHistory();
  }

  /// Remove um registro específico pelo seu ID.
  /// 
  /// Parâmetros:
  ///   - [id]: Identificador único do registro a ser removido
  void removeEntry(String id) {
    _repository.removeEntry(id);
  }

  /// Obtém a contagem total de registros no histórico.
  /// 
  /// Retorna:
  ///   Número inteiro representando a quantidade de entradas.
  int getHistoryCount() {
    return _repository.getHistoryCount();
  }
}
