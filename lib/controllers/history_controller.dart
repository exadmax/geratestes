import '../models/history_entry.dart';
import '../repositories/history_repository.dart';

/// [HistoryController] gerencia a lógica de histórico de gerações.
/// 
/// Esse controller atua como intermediário entre a view (página) e o repositório
/// de histórico, seguindo o padrão MVC. Responsável por coordenar as ações
/// do usuário com as operações de persistência do histórico.
/// 
/// Funcionalidades:
/// - Adicionar novos registros ao histórico
/// - Recuperar o histórico de gerações
/// - Limpar o histórico
/// - Remover registros específicos
/// - Obter contagem de registros
class HistoryController {
  /// Instância privada do repositório de histórico.
  /// 
  /// Utilizada internamente para acessar operações de persistência do histórico.
  final HistoryRepository _historyRepository;

  /// Construtor que requer uma instância de [HistoryRepository].
  /// 
  /// A injeção de dependência garante que o controller seja independente
  /// da implementação específica do repositório (local, remoto, etc).
  /// 
  /// Parâmetros:
  ///   - [historyRepository]: Repositório responsável pela persistência do histórico
  HistoryController({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  /// Adiciona um novo registro ao histórico.
  /// 
  /// Delega a operação de persistência para o repositório,
  /// que será responsável por salvar os dados.
  /// 
  /// Parâmetros:
  ///   - [name]: Nome gerado ou informado
  ///   - [cpf]: CPF gerado ou informado
  ///   - [cnpj]: CNPJ gerado ou informado
  void addHistoryEntry(String name, String cpf, String cnpj) {
    _historyRepository.addEntry(name, cpf, cnpj);
  }

  /// Recupera o histórico completo de registros.
  /// 
  /// Retorna uma lista imutável dos registros para evitar
  /// modificações acidentais da estrutura interna.
  /// 
  /// Retorna:
  ///   Lista imutável de [HistoryEntry] ordenada por data decrescente.
  List<HistoryEntry> getHistory() {
    return _historyRepository.getHistory();
  }

  /// Limpa completamente o histórico de registros.
  /// 
  /// Remove todos os registros armazenados no repositório.
  /// Operação irreversível.
  void clearHistory() {
    _historyRepository.clearHistory();
  }

  /// Remove um registro específico do histórico.
  /// 
  /// Parâmetros:
  ///   - [id]: Identificador único do registro a ser removido
  void removeEntry(String id) {
    _historyRepository.removeEntry(id);
  }

  /// Obtém a quantidade total de registros no histórico.
  /// 
  /// Retorna:
  ///   Número inteiro representando a quantidade de entradas no histórico.
  int getHistoryCount() {
    return _historyRepository.getHistoryCount();
  }
}
