import 'package:flutter/material.dart';

import '../controllers/renavam_generator_controller.dart';
import '../services/document_generator_service.dart';
import '../widgets/background_logo.dart';

/// [RenavamGeneratorPage] é a view para geração de RENAVAM.
/// 
/// Exibe um RENAVAM gerado e permite ao usuário gerar novos RENAVAMs válidos
/// através de um botão de ação.
/// 
/// Padrão MVC - Componente: View (Stateful)
/// Responsabilidades:
/// - Exibir RENAVAM gerado
/// - Gerenciar estado da geração
/// - Comunicar com o controller para operações
class RenavamGeneratorPage extends StatefulWidget {
  /// Construtor padrão da página.
  const RenavamGeneratorPage({super.key});

  @override
  State<RenavamGeneratorPage> createState() => _RenavamGeneratorPageState();
}

/// Estado da [RenavamGeneratorPage].
/// 
/// Responsável pelo gerenciamento do ciclo de vida e do estado
/// da geração de RENAVAM.
class _RenavamGeneratorPageState extends State<RenavamGeneratorPage> {
  /// Instância privada do controller de geração de RENAVAM.
  /// 
  /// Coordena a lógica de geração através dos serviços.
  late final RenavamGeneratorController _controller;

  /// Variável privada que armazena o RENAVAM gerado atualmente.
  late String _renavam;

  /// Controla se o RENAVAM deve ser exibido com formatação (pontos e hífen).
  bool _formatted = false;

  @override
  void initState() {
    super.initState();
    
    /// Inicializa o controller com o serviço de documentos.
    /// Segue o padrão de injeção de dependência.
    _controller = RenavamGeneratorController(
      documentGeneratorService: DocumentGeneratorService(),
    );
    
    /// Gera o primeiro RENAVAM ao abrir a página (sem formatação por padrão).
    _renavam = _controller.generateRenavam(formatted: _formatted);
  }

  /// Regenera um novo RENAVAM e atualiza a interface.
  void _regenerate() {
    setState(() {
      _renavam = _controller.generateRenavam(formatted: _formatted);
    });
  }

  /// Alterna entre RENAVAM formatado e não formatado.
  void _toggleFormatted() {
    setState(() {
      _formatted = !_formatted;
      _renavam = _controller.generateRenavam(formatted: _formatted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar com título da página.
      appBar: AppBar(title: const Text('Gerador de RENAVAM')),
      
      /// Corpo principal com o RENAVAM exibido.
      body: Stack(
        children: [
          const BackgroundLogo(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Rótulo explicativo.
            const Text('RENAVAM gerado'),
            const SizedBox(height: 8),
            
            /// Card contendo o RENAVAM.
            /// O RENAVAM é selecionável (SelectableText) para facilitar cópia.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  _renavam,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Switch para alternar entre RENAVAM formatado e sem formatação.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Com ponto e hífen'),
                Switch(
                  value: _formatted,
                  onChanged: (_) => _toggleFormatted(),
                ),
              ],
            ),
            const Spacer(),
            
            /// Botão para gerar novo RENAVAM.
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
