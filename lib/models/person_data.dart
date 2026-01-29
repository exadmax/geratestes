class PersonData {
  const PersonData({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.cpf,
    required this.address,
    required this.cep,
    required this.age,
    required this.state,
    required this.city,
    required this.number,
    required this.complement,
  });

  final String firstName;
  final String lastName;
  final String gender;
  final String cpf;
  final String address;
  final String cep;
  final int age;
  final String state;
  final String city;
  final String number;
  final String complement;

  String get fullName => '$firstName $lastName';
}
