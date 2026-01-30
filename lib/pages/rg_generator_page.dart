import 'package:flutter/material.dart';

import '../controllers/rg_generator_controller.dart';
import '../services/document_generator_service.dart';
import '../widgets/background_logo.dart';

/// [RgGeneratorPage] é a view para geração de RG.
/// 
/// Exibe um RG gerado e permite ao usuário gerar novos RGs válidos
/// através de um botão de ação. Também oferece opção de formatação.
/// 
/// Padrão MVC - Componente: View (Stateful)
/// Responsabilidades:
/// - Exibir RG gerado
/// - Gerenciar estado da geração
/// - Comunicar com o controller para operações
/// - Permitir alternância entre formatado e sem formatação
class RgGeneratorPage extends StatefulWidget {
  /// Construtor padrão da página.
  const RgGeneratorPage({super.key});

  @override
  State<RgGeneratorPage> createState() => _RgGeneratorPageState();
}

/// Estado da [RgGeneratorPage].
/// 
/// Responsável pelo gerenciamento do ciclo de vida e do estado
/// da geração de RG.
class _RgGeneratorPageState extends State<RgGeneratorPage> {
  /// Instância privada do controller de geração de RG.
  /// 
  /// Coordena a lógica de geração através dos serviços.
  late final RgGeneratorController _controller;

  /// Variável privada que armazena o RG gerado atualmente.
  late String _rg;

  /// Controla se o RG deve ser exibido com formatação (pontos e hífen).
  bool _formatted = false;

  @override
  void initState() {
    super.initState();
    
    /// Inicializa o controller com o serviço de documentos.
    /// Segue o padrão de injeção de dependência.
    _controller = RgGeneratorController(
      documentGeneratorService: DocumentGeneratorService(),
    );
    
    /// Gera o primeiro RG ao abrir a página (sem formatação por padrão).
    _rg = _controller.generateRg(formatted: _formatted);
  }

  /// Regenera um novo RG e atualiza a interface.
  void _regenerate() {
    setState(() {
      _rg = _controller.generateRg(formatted: _formatted);
    });
  }

  /// Alterna entre RG formatado e não formatado.
  void _toggleFormatted() {
    setState(() {
      _formatted = !_formatted;
      _rg = _controller.generateRg(formatted: _formatted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar com título da página.
      appBar: AppBar(title: const Text('Gerador de RG')),
      
      /// Corpo principal com o RG exibido.
      body: Stack(
        children: [
          const BackgroundLogo(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Rótulo explicativo.
                const Text('RG gerado'),
                const SizedBox(height: 8),
                
                /// Card contendo o RG.
                /// O RG é selecionável (SelectableText) para facilitar cópia.
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SelectableText(
                      _rg,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                /// Botão para gerar novo RG.
                FilledButton(
                  onPressed: _regenerate,
                  child: const Text('Gerar novo RG'),
                ),
                const SizedBox(height: 12),
                
                /// Checkbox para alternar formatação.
                Row(
                  children: [
                    Checkbox(
                      value: _formatted,
                      onChanged: (_) => _toggleFormatted(),
                    ),
                    const Text('Com formatação (XX.XXX.XXX-X)'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
