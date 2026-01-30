/// [NameEntry] representa uma entrada de nome com seu gênero associado.
/// 
/// Entidade utilizada internamente para armazenar pares nome-gênero
/// na geração aleatória de nomes de pessoas para testes.
class NameEntry {
  /// Construtor que requer o nome e seu gênero.
  /// 
  /// Parâmetros:
  ///   - [name]: Nome da pessoa
  ///   - [gender]: Gênero associado ao nome ('H' para masculino, 'M' para feminino)
  const NameEntry(this.name, this.gender);

  /// Nome da pessoa.
  final String name;
  
  /// Gênero associado ao nome ('H' para masculino, 'M' para feminino).
  final String gender;
}
