import 'package:flutter/material.dart';

import '../controllers/cnh_generator_controller.dart';
import '../services/document_generator_service.dart';
import '../widgets/background_logo.dart';

/// [CnhCheckPage] é a view para validação de CNH.
/// 
/// Permite ao usuário informar uma CNH e validar se é válida ou não
/// de acordo com as regras oficiais de CNH brasileira.
/// 
/// Padrão MVC - Componente: View (Stateful)
/// Responsabilidades:
/// - Exibir campo de entrada para CNH
/// - Exibir resultado da validação
/// - Gerenciar estado da validação
/// - Comunicar com o controller para operações
class CnhCheckPage extends StatefulWidget {
  /// Construtor padrão da página.
  const CnhCheckPage({super.key});

  @override
  State<CnhCheckPage> createState() => _CnhCheckPageState();
}

/// Estado da [CnhCheckPage].
/// 
/// Responsável pelo gerenciamento do ciclo de vida e do estado
/// da validação de CNH.
class _CnhCheckPageState extends State<CnhCheckPage> {
  /// Controlador do campo de entrada de texto.
  /// 
  /// Gerencia o texto informado pelo usuário para validação.
  final _textController = TextEditingController();

  /// Instância privada do controller de geração de CNH.
  /// 
  /// Reutilizado para validação de CNH.
  late final CnhGeneratorController _controller;

  /// Armazena o resultado da validação (válida/inválida).
  /// 
  /// Inicialmente null, é atualizado após validação.
  String? _result;

  @override
  void initState() {
    super.initState();
    
    /// Inicializa o controller com o serviço de documentos.
    _controller = CnhGeneratorController(
      documentGeneratorService: DocumentGeneratorService(),
    );
  }

  @override
  void dispose() {
    /// Libera recursos do controlador de texto ao descartar a página.
    _textController.dispose();
    super.dispose();
  }

  /// Valida a CNH informada pelo usuário.
  /// 
  /// Obtém o texto do campo, delegua a validação ao controller
  /// e atualiza o resultado exibido.
  void _check() {
    final value = _textController.text;
    final isValid = _controller.isValidCnh(value);
    setState(() {
      _result = isValid ? 'CNH válida' : 'CNH inválida';
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultStyle = Theme.of(context).textTheme.titleMedium;
    
    return Scaffold(
      /// AppBar com título da página.
      appBar: AppBar(title: const Text('Checagem de CNH')),
      
      /// Corpo principal com campo de entrada e resultado.
      body: Stack(
        children: [
          const BackgroundLogo(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Campo de entrada para a CNH.
            /// Aceita números (teclado numérico).
            TextField(
              controller: _textController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite a CNH',
                hintText: '0000000000-00',
              ),
            ),
            const SizedBox(height: 12),
            
            /// Botão para validar a CNH informada.
            FilledButton(
              onPressed: _check,
              child: const Text('Checar'),
            ),
            const SizedBox(height: 16),
            
            /// Exibe o resultado da validação.
            if (_result != null)
              Text(
                _result!,
                style: resultStyle,
                textAlign: TextAlign.center,
              ),
          ],
        ),
          ),
        ],
      ),
    );
  }
}
