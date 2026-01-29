import 'package:flutter/material.dart';

import '../models/person_data.dart';
import 'field_row.dart';

class PersonInfoCard extends StatelessWidget {
  const PersonInfoCard({super.key, required this.person});

  final PersonData person;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FieldRow(label: 'Nome', value: person.fullName),
            FieldRow(label: 'Sexo', value: person.gender),
            FieldRow(label: 'Sobrenome', value: person.lastName),
            FieldRow(label: 'Idade', value: person.age.toString()),
            FieldRow(label: 'Estado', value: person.state),
            FieldRow(label: 'Cidade', value: person.city),
            FieldRow(label: 'Endereço', value: person.address),
            FieldRow(label: 'Número', value: person.number),
            FieldRow(label: 'Complemento', value: person.complement),
            FieldRow(label: 'CPF', value: person.cpf),
            FieldRow(label: 'CEP', value: person.cep),
          ],
        ),
      ),
    );
  }
}
