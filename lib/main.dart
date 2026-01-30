import 'package:flutter/material.dart';

import 'pages/home_menu_page.dart';

/// Função principal de entrada da aplicação.
/// 
/// Inicializa o aplicativo Flutter executando a aplicação Geratestes.
void main() {
  runApp(const GeratestesApp());
}

/// [GeratestesApp] é o widget raiz da aplicação.
/// 
/// Configura o tema visual e a navegação inicial da aplicação.
/// Esta é a primeira widget a ser carregada.
/// 
/// Padrão MVC - Componente: App Configuration
/// Responsabilidades:
/// - Definir tema da aplicação
/// - Configurar rota inicial
/// - Definir título e branding
class GeratestesApp extends StatelessWidget {
  /// Construtor padrão do widget raiz.
  const GeratestesApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Define o tema visual da aplicação.
    /// Utiliza uma cor verde como seed para gerar a paleta de cores,
    /// e ativa Material Design 3 para visual moderno.
    final theme = ThemeData(
      /// Define a paleta de cores baseada na cor primária verde.
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
      
      /// Ativa Material Design 3 (design visual mais recente).
      useMaterial3: true,
      
      /// Define o estilo padrão para campos de entrada.
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );

    return MaterialApp(
      /// Título da aplicação exibido em contextos do sistema.
      title: 'Geratestes',
      
      /// Desativa a faixa de aviso "Debug" exibida no canto da tela.
      debugShowCheckedModeBanner: false,
      
      /// Aplica o tema definido acima.
      theme: theme,
      
      /// Define a página inicial da aplicação.
      home: const HomeMenuPage(),
    );
  }
}
