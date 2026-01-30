import 'package:flutter/material.dart';

/// [FieldRow] é um widget que exibe um par label-valor de forma estruturada.
/// 
/// Componente reutilizável que apresenta um rótulo acima e um valor
/// selecionável abaixo, com espaçamento adequado.
/// 
/// Padrão MVC - Componente: Widget (Presentational)
/// Responsabilidades:
/// - Exibir label do campo
/// - Exibir valor do campo de forma selecionável
/// - Aplicar estilos de tema apropriados
class FieldRow extends StatelessWidget {
  /// Construtor que requer label e valor.
  /// 
  /// Parâmetros:
  ///   - [label]: Rótulo descritivo do campo
  ///   - [value]: Valor a ser exibido (selecionável)
  const FieldRow({
    super.key,
    required this.label,
    required this.value,
  });

  /// Rótulo descritivo do campo.
  /// 
  /// Exibido em tamanho pequeno acima do valor.
  final String label;

  /// Valor a ser exibido.
  /// 
  /// Apresentado de forma selecionável para facilitar cópia.
  final String value;

  @override
  Widget build(BuildContext context) {
    /// Obtém estilos de texto do tema da aplicação.
    final labelStyle = Theme.of(context).textTheme.labelLarge;
    final valueStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontWeight: FontWeight.w600);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Exibe o rótulo do campo.
          Text(label, style: labelStyle),
          const SizedBox(height: 4),
          
          /// Exibe o valor de forma selecionável.
          /// Permite ao usuário facilmente copiar o texto.
          SelectableText(value, style: valueStyle),
        ],
      ),
    );
  }
}
