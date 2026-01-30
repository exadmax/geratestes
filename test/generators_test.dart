import 'package:flutter_test/flutter_test.dart';
import 'package:geratestes/services/document_generator_service.dart';
import 'package:geratestes/services/person_generator_service.dart';

void main() {
  group('DocumentGeneratorService', () {
    test('gera CPF valido e formatado', () {
      final generator = DocumentGeneratorService();
      final cpf = generator.generateCpf(formatted: true);

        expect(RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$').hasMatch(cpf),
          isTrue);
      expect(generator.isValidCpf(cpf), isTrue);
    });

    test('gera CNPJ valido e formatado', () {
      final generator = DocumentGeneratorService();
      final cnpj = generator.generateCnpj(formatted: true);

      expect(RegExp(r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$')
          .hasMatch(cnpj), isTrue);
      expect(generator.isValidCnpj(cnpj), isTrue);
    });

    test('validador de CPF rejeita entradas invalidas', () {
      final generator = DocumentGeneratorService();

      expect(generator.isValidCpf(''), isFalse);
      expect(generator.isValidCpf('111.111.111-11'), isFalse);
      expect(generator.isValidCpf('123.456.789-00'), isFalse);
      expect(generator.isValidCpf('123'), isFalse);
    });

    test('validador de CNPJ rejeita entradas invalidas', () {
      final generator = DocumentGeneratorService();

      expect(generator.isValidCnpj(''), isFalse);
      expect(generator.isValidCnpj('00.000.000/0000-00'), isFalse);
      expect(generator.isValidCnpj('12.345.678/9012-34'), isFalse);
      expect(generator.isValidCnpj('123'), isFalse);
    });
  });

  group('PersonGeneratorService', () {
    test('gera pessoa fisica com campos validos', () {
      final generator = PersonGeneratorService();
      final person = generator.generate();

      expect(person.firstName.isNotEmpty, isTrue);
      expect(person.lastName.isNotEmpty, isTrue);
      expect(person.fullName.contains(' '), isTrue);
      expect(['H', 'M'].contains(person.gender), isTrue);
      expect(person.age >= 1 && person.age <= 99, isTrue);
      expect(person.state.length == 2, isTrue);
      expect(person.city.isNotEmpty, isTrue);
      expect(person.address.isNotEmpty, isTrue);
      expect(RegExp(r'^\d+$').hasMatch(person.number), isTrue);
      expect(person.complement.isNotEmpty, isTrue);
      expect(RegExp(r'^\d{5}-\d{3}$').hasMatch(person.cep), isTrue);

      final generatorDoc = DocumentGeneratorService();
      expect(generatorDoc.isValidCpf(person.cpf), isTrue);
    });
  });
}
