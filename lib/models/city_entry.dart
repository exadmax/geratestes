/// [CityEntry] representa uma entrada de cidade com seu estado.
/// 
/// Entidade utilizada internamente para armazenar pares cidade-estado
/// na geração aleatória de dados de endereço para testes.
class CityEntry {
  /// Construtor que requer o nome da cidade e sua unidade federativa.
  /// 
  /// Parâmetros:
  ///   - [name]: Nome da cidade
  ///   - [uf]: Sigla da unidade federativa (ex: 'SP', 'RJ', 'MG')
  const CityEntry(this.name, this.uf);

  /// Nome da cidade.
  final String name;
  
  /// Unidade Federativa (estado) abreviada em 2 caracteres.
  final String uf;
}
