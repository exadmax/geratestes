import 'package:flutter/material.dart';

import '../controllers/cpf_generator_controller.dart';
import '../services/document_generator_service.dart';
import '../widgets/background_logo.dart';

/// [CpfGeneratorPage] é a view para geração de CPF.
/// 
/// Exibe um CPF gerado e permite ao usuário gerar novos CPFs válidos
/// através de um botão de ação.
/// 
/// Padrão MVC - Componente: View (Stateful)
/// Responsabilidades:
/// - Exibir CPF gerado
/// - Gerenciar estado da geração
/// - Comunicar com o controller para operações
class CpfGeneratorPage extends StatefulWidget {
  /// Construtor padrão da página.
  const CpfGeneratorPage({super.key});

  @override
  State<CpfGeneratorPage> createState() => _CpfGeneratorPageState();
}

/// Estado da [CpfGeneratorPage].
/// 
/// Responsável pelo gerenciamento do ciclo de vida e do estado
/// da geração de CPF.
class _CpfGeneratorPageState extends State<CpfGeneratorPage> {
  /// Instância privada do controller de geração de CPF.
  /// 
  /// Coordena a lógica de geração através dos serviços.
  late final CpfGeneratorController _controller;

  /// Variável privada que armazena o CPF gerado atualmente.
  late String _cpf;

  /// Controla se o CPF deve ser exibido com formatação (pontos e hífen).
  bool _formatted = false;

  @override
  void initState() {
    super.initState();
    
    /// Inicializa o controller com o serviço de documentos.
    /// Segue o padrão de injeção de dependência.
    _controller = CpfGeneratorController(
      documentGeneratorService: DocumentGeneratorService(),
    );
    
    /// Gera o primeiro CPF ao abrir a página (sem formatação por padrão).
    _cpf = _controller.generateCpf(formatted: _formatted);
  }

  /// Regenera um novo CPF e atualiza a interface.
  void _regenerate() {
    setState(() {
      _cpf = _controller.generateCpf(formatted: _formatted);
    });
  }

  /// Alterna entre CPF formatado e não formatado.
  void _toggleFormatted() {
    setState(() {
      _formatted = !_formatted;
      _cpf = _controller.generateCpf(formatted: _formatted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar com título da página.
      appBar: AppBar(title: const Text('Gerador de CPF')),
      
      /// Corpo principal com o CPF exibido.
      body: Stack(
        children: [
          const BackgroundLogo(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Rótulo explicativo.
            const Text('CPF gerado'),
            const SizedBox(height: 8),
            
            /// Card contendo o CPF formatado.
            /// O CPF é selecionável (SelectableText) para facilitar cópia.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  _cpf,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Switch para alternar entre CPF formatado e sem formatação.
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
            
            /// Botão para gerar novo CPF.
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
