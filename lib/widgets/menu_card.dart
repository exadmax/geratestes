import 'package:flutter/material.dart';

/// [MenuCard] é um widget que exibe uma opção de menu navegável.
/// 
/// Card especializado para apresentar opções de menu na tela inicial,
/// com ícone, título, descrição e ação navegável ao tocar.
/// 
/// Padrão MVC - Componente: Widget (Presentational)
/// Responsabilidades:
/// - Exibir opção de menu com ícone e descrição
/// - Aplicar estilos de card apropriados
/// - Executar callback ao tocar
class MenuCard extends StatelessWidget {
  /// Construtor que requer todos os parâmetros de um item de menu.
  /// 
  /// Parâmetros:
  ///   - [title]: Título da opção de menu
  ///   - [subtitle]: Descrição ou subtítulo da opção
  ///   - [icon]: Ícone a ser exibido
  ///   - [onTap]: Callback executado ao tocar no card
  const MenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  /// Título da opção de menu.
  final String title;

  /// Descrição ou subtítulo da opção.
  final String subtitle;

  /// Ícone a ser exibido à esquerda do título.
  final IconData icon;

  /// Callback executado quando o usuário toca no card.
  /// 
  /// Tipicamente usada para navegar para outra página.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      /// ListTile fornece layout organizado com ícone, título e ações.
      child: ListTile(
        /// Ícone à esquerda.
        leading: Icon(icon),
        
        /// Título principal da opção.
        title: Text(title),
        
        /// Descrição/subtítulo em texto menor.
        subtitle: Text(subtitle),
        
        /// Ícone de seta indicando navegação.
        trailing: const Icon(Icons.chevron_right),
        
        /// Callback ao tocar no card.
        onTap: onTap,
      ),
    );
  }
}
