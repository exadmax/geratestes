import 'package:flutter/material.dart';

/// Widget que exibe o logo esmaecido como fundo das páginas.
/// 
/// Utilizado nas páginas de funcionalidades para manter identidade visual
/// sem atrapalhar a legibilidade do conteúdo principal.
class BackgroundLogo extends StatelessWidget {
  /// Construtor padrão do widget.
  const BackgroundLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: Opacity(
          opacity: 0.3,
          child: Image.asset(
            'img/icon.png',
            width: MediaQuery.of(context).size.width * 0.5,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
