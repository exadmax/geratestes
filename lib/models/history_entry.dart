import 'dart:convert';

/// [HistoryEntry] representa um registro de histórico de geração de documentos.
/// 
/// Essa entidade encapsula informações sobre gerações anteriores de CPF e CNPJ,
/// permitindo que o usuário mantenha um histórico das operações realizadas
/// no aplicativo para referência futura.
/// 
/// O histórico é armazenado no sessionStorage do navegador (para ambiente web).
class HistoryEntry {
  /// Construtor padrão que requer todos os campos do histórico.
  /// 
  /// Parâmetros:
  ///   - [id]: Identificador único do registro (timestamp em milissegundos)
  ///   - [name]: Nome da pessoa gerada
  ///   - [cpf]: CPF gerado
  ///   - [cnpj]: CNPJ gerado
  ///   - [timestamp]: Data e hora da geração
  HistoryEntry({
    required this.id,
    required this.name,
    required this.cpf,
    required this.cnpj,
    required this.timestamp,
  });

  /// Identificador único do registro no histórico.
  final String id;
  
  /// Nome gerado ou informado no momento da entrada no histórico.
  final String name;
  
  /// CPF gerado ou informado no momento da entrada no histórico.
  final String cpf;
  
  /// CNPJ gerado ou informado no momento da entrada no histórico.
  final String cnpj;
  
  /// Data e hora exata quando este histórico foi registrado.
  final DateTime timestamp;

  /// Converte a instância [HistoryEntry] para um mapa JSON.
  /// 
  /// Utilizado para serializar o objeto ao salvar no sessionStorage.
  /// 
  /// Retorna:
  ///   Um [Map] com as chaves padrão para cada propriedade do objeto.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'cnpj': cnpj,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Factory que cria uma instância [HistoryEntry] a partir de um mapa JSON.
  /// 
  /// Utilizado para desserializar o objeto ao carregar do sessionStorage.
  /// 
  /// Parâmetros:
  ///   - [json]: Mapa contendo os dados do histórico
  /// 
  /// Retorna:
  ///   Uma nova instância [HistoryEntry] com os dados do JSON.
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
