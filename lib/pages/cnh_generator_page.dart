import 'package:flutter/material.dart';

import '../controllers/cnh_generator_controller.dart';
import '../services/document_generator_service.dart';
import '../widgets/background_logo.dart';

/// [CnhGeneratorPage] é a view para geração de CNH.
/// 
/// Exibe uma CNH gerada e permite ao usuário gerar novas CNHs válidas
/// através de um botão de ação.
/// 
/// Padrão MVC - Componente: View (Stateful)
/// Responsabilidades:
/// - Exibir CNH gerada
/// - Gerenciar estado da geração
/// - Comunicar com o controller para operações
class CnhGeneratorPage extends StatefulWidget {
  /// Construtor padrão da página.
  const CnhGeneratorPage({super.key});

  @override
  State<CnhGeneratorPage> createState() => _CnhGeneratorPageState();
}

/// Estado da [CnhGeneratorPage].
/// 
/// Responsável pelo gerenciamento do ciclo de vida e do estado
/// da geração de CNH.
class _CnhGeneratorPageState extends State<CnhGeneratorPage> {
  /// Instância privada do controller de geração de CNH.
  /// 
  /// Coordena a lógica de geração através dos serviços.
  late final CnhGeneratorController _controller;

  /// Variável privada que armazena a CNH gerada atualmente.
  late String _cnh;

  /// Controla se a CNH deve ser exibida com formatação (hífen).
  bool _formatted = false;

  @override
  void initState() {
    super.initState();
    
    /// Inicializa o controller com o serviço de documentos.
    /// Segue o padrão de injeção de dependência.
    _controller = CnhGeneratorController(
      documentGeneratorService: DocumentGeneratorService(),
    );
    
    /// Gera a primeira CNH ao abrir a página (sem formatação por padrão).
    _cnh = _controller.generateCnh(formatted: _formatted);
  }

  /// Regenera uma nova CNH e atualiza a interface.
  void _regenerate() {
    setState(() {
      _cnh = _controller.generateCnh(formatted: _formatted);
    });
  }

  /// Alterna entre CNH formatada e não formatada.
  void _toggleFormatted() {
    setState(() {
      _formatted = !_formatted;
      _cnh = _controller.generateCnh(formatted: _formatted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar com título da página.
      appBar: AppBar(title: const Text('Gerador de CNH')),
      
      /// Corpo principal com a CNH exibida.
      body: Stack(
        children: [
          const BackgroundLogo(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Rótulo explicativo.
            const Text('CNH gerada'),
            const SizedBox(height: 8),
            
            /// Card contendo a CNH formatada.
            /// A CNH é selecionável (SelectableText) para facilitar cópia.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  _cnh,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Switch para alternar entre CNH formatada e sem formatação.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Com hífen'),
                Switch(
                  value: _formatted,
                  onChanged: (_) => _toggleFormatted(),
                ),
              ],
            ),
            const Spacer(),
            
            /// Botão para gerar nova CNH.
            FilledButton.icon(
              onPressed: _regenerate,
              icon: const Icon(Icons.refresh),
              label: const Text('Gerar novamente'),
            ),
          ],
        ),
          ),
        ],
      ),
    );
  }
}
