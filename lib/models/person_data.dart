/// [PersonData] representa um registro completo de dados de uma pessoa.
/// 
/// Essa entidade encapsula todas as informações necessárias para testes
/// de sistemas que lidam com dados de pessoas físicas no Brasil, incluindo
/// informações pessoais, endereço e documentação.
/// 
/// Utilizado principalmente como resposta de operações de geração de
/// dados fake para testes de aplicação.
class PersonData {
  /// Construtor padrão que requer todos os campos de dados pessoais.
  /// 
  /// Todos os parâmetros são obrigatórios para garantir a integridade
  /// dos dados da pessoa gerada.
  const PersonData({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.cpf,
    required this.cnh,
    required this.rg,
    required this.address,
    required this.cep,
    required this.age,
    required this.state,
    required this.city,
    required this.number,
    required this.complement,
  });

  /// Nome próprio da pessoa.
  final String firstName;
  
  /// Sobrenome da pessoa.
  final String lastName;
  
  /// Gênero da pessoa (ex: 'H' para masculino, 'M' para feminino).
  final String gender;
  
  /// Número de CPF válido no padrão brasileiro (XXX.XXX.XXX-XX).
  final String cpf;

  /// Número de CNH válida no padrão brasileiro (XXXXXXXXXX-XX).
  final String cnh;

  /// Número de RG válido no padrão brasileiro (XX.XXX.XXX-X).
  final String rg;
  
  /// Endereço (nome da rua/avenida/etc) da pessoa.
  final String address;
  
  /// Código de Endereçamento Postal (CEP) no formato brasileiro (XXXXX-XXX).
  final String cep;
  
  /// Idade da pessoa em anos.
  final int age;
  
  /// Unidade Federativa (estado) da pessoa (ex: 'SP', 'RJ', 'MG').
  final String state;
  
  /// Cidade onde a pessoa reside.
  final String city;
  
  /// Número do endereço onde a pessoa reside.
  final String number;
  
  /// Complemento do endereço (ex: 'Apto 101', 'Fundos').
  final String complement;

  /// Getter que retorna o nome completo da pessoa.
  /// 
  /// Combina [firstName] e [lastName] com um espaço entre eles.
  String get fullName => '$firstName $lastName';
}
