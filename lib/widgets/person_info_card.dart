import 'package:flutter/material.dart';

import '../models/person_data.dart';
import 'field_row.dart';

/// [PersonInfoCard] é um widget que exibe todos os dados de uma pessoa.
/// 
/// Card especializado que apresenta informações completas de uma [PersonData],
/// organizadas em linhas label-valor usando [FieldRow].
/// 
/// Padrão MVC - Componente: Widget (Presentational)
/// Responsabilidades:
/// - Exibir dados de pessoa de forma estruturada
/// - Organizar campos em ordem lógica
/// - Aplicar estilos de card apropriados
class PersonInfoCard extends StatelessWidget {
  /// Construtor que requer uma instância de [PersonData].
  /// 
  /// Parâmetros:
  ///   - [person]: Dados da pessoa a serem exibidos
  const PersonInfoCard({super.key, required this.person});

  /// Dados da pessoa a serem exibidos no card.
  final PersonData person;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Exibe nome completo da pessoa.
            FieldRow(label: 'Nome', value: person.fullName),
            
            /// Exibe gênero da pessoa (H/M).
            FieldRow(label: 'Sexo', value: person.gender),
            
            /// Exibe sobrenome da pessoa.
            FieldRow(label: 'Sobrenome', value: person.lastName),
            
            /// Exibe idade da pessoa em anos.
            FieldRow(label: 'Idade', value: person.age.toString()),
            
            /// Exibe estado (UF) onde a pessoa reside.
            FieldRow(label: 'Estado', value: person.state),
            
            /// Exibe cidade onde a pessoa reside.
            FieldRow(label: 'Cidade', value: person.city),
            
            /// Exibe nome da via (rua, avenida, etc).
            FieldRow(label: 'Endereço', value: person.address),
            
            /// Exibe número do imóvel.
            FieldRow(label: 'Número', value: person.number),
            
            /// Exibe complemento do endereço (apto, fundos, etc).
            FieldRow(label: 'Complemento', value: person.complement),
            
            /// Exibe CPF formatado da pessoa.
            FieldRow(label: 'CPF', value: person.cpf),
            
            /// Exibe CNH formatada da pessoa.
            FieldRow(label: 'CNH', value: person.cnh),
            
            /// Exibe CEP (Código de Endereçamento Postal).
            FieldRow(label: 'CEP', value: person.cep),
          ],
        ),
      ),
    );
  }
}
