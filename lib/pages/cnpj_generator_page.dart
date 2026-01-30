import 'package:flutter/material.dart';

import '../controllers/cnpj_generator_controller.dart';
import '../services/document_generator_service.dart';
import '../widgets/background_logo.dart';

/// [CnpjGeneratorPage] é a view para geração de CNPJ.
/// 
/// Exibe um CNPJ gerado e permite ao usuário gerar novos CNPJs válidos
/// através de um botão de ação.
/// 
/// Padrão MVC - Componente: View (Stateful)
/// Responsabilidades:
/// - Exibir CNPJ gerado
/// - Gerenciar estado da geração
/// - Comunicar com o controller para operações
class CnpjGeneratorPage extends StatefulWidget {
  /// Construtor padrão da página.
  const CnpjGeneratorPage({super.key});

  @override
  State<CnpjGeneratorPage> createState() => _CnpjGeneratorPageState();
}

/// Estado da [CnpjGeneratorPage].
/// 
/// Responsável pelo gerenciamento do ciclo de vida e do estado
/// da geração de CNPJ.
class _CnpjGeneratorPageState extends State<CnpjGeneratorPage> {
  /// Instância privada do controller de geração de CNPJ.
  /// 
  /// Coordena a lógica de geração através dos serviços.
  late final CnpjGeneratorController _controller;

  /// Variável privada que armazena o CNPJ gerado atualmente.
  late String _cnpj;

  /// Controla se o CNPJ deve ser exibido com formatação (pontos, barra e hífen).
  bool _formatted = false;

  @override
  void initState() {
    super.initState();
    
    /// Inicializa o controller com o serviço de documentos.
    /// Segue o padrão de injeção de dependência.
    _controller = CnpjGeneratorController(
      documentGeneratorService: DocumentGeneratorService(),
    );
    
    /// Gera o primeiro CNPJ ao abrir a página (sem formatação por padrão).
    _cnpj = _controller.generateCnpj(formatted: _formatted);
  }

  /// Regenera um novo CNPJ e atualiza a interface.
  void _regenerate() {
    setState(() {
      _cnpj = _controller.generateCnpj(formatted: _formatted);
    });
  }

  /// Alterna entre CNPJ formatado e não formatado.
  void _toggleFormatted() {
    setState(() {
      _formatted = !_formatted;
      _cnpj = _controller.generateCnpj(formatted: _formatted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar com título da página.
      appBar: AppBar(title: const Text('Gerador de CNPJ')),
      
      /// Corpo principal com o CNPJ exibido.
      body: Stack(
        children: [
          const BackgroundLogo(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Rótulo explicativo.
            const Text('CNPJ gerado'),
            const SizedBox(height: 8),
            
            /// Card contendo o CNPJ formatado.
            /// O CNPJ é selecionável (SelectableText) para facilitar cópia.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  _cnpj,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Switch para alternar entre CNPJ formatado e sem formatação.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Com ponto, barra e hífen'),
                Switch(
                  value: _formatted,
                  onChanged: (_) => _toggleFormatted(),
                ),
              ],
            ),
            const Spacer(),
            
            /// Botão para gerar novo CNPJ.
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
