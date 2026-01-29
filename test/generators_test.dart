import 'package:flutter_test/flutter_test.dart';
import 'package:geratestes/services/document_generator.dart';
import 'package:geratestes/services/person_generator.dart';

void main() {
  group('DocumentGenerator', () {
    test('gera CPF valido e formatado', () {
      final generator = DocumentGenerator();
      final cpf = generator.generateCpf();

        expect(RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$').hasMatch(cpf),
          isTrue);
      expect(generator.isValidCpf(cpf), isTrue);
    });

    test('gera CNPJ valido e formatado', () {
      final generator = DocumentGenerator();
      final cnpj = generator.generateCnpj();

      expect(RegExp(r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$')
          .hasMatch(cnpj), isTrue);
      expect(generator.isValidCnpj(cnpj), isTrue);
    });

    test('validador de CPF rejeita entradas invalidas', () {
      final generator = DocumentGenerator();

      expect(generator.isValidCpf(''), isFalse);
      expect(generator.isValidCpf('111.111.111-11'), isFalse);
      expect(generator.isValidCpf('123.456.789-00'), isFalse);
      expect(generator.isValidCpf('123'), isFalse);
    });

    test('validador de CNPJ rejeita entradas invalidas', () {
      final generator = DocumentGenerator();

      expect(generator.isValidCnpj(''), isFalse);
      expect(generator.isValidCnpj('00.000.000/0000-00'), isFalse);
      expect(generator.isValidCnpj('12.345.678/9012-34'), isFalse);
      expect(generator.isValidCnpj('123'), isFalse);
    });
  });

  group('PersonGenerator', () {
    test('gera pessoa fisica com campos validos', () {
      final generator = PersonGenerator();
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

      final generatorDoc = DocumentGenerator();
      expect(generatorDoc.isValidCpf(person.cpf), isTrue);
    });
  });
}
