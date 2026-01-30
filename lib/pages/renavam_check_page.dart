import 'package:flutter/material.dart';

import '../controllers/renavam_generator_controller.dart';
import '../services/document_generator_service.dart';
import '../widgets/background_logo.dart';

/// [RenavamCheckPage] é a view para validação de RENAVAM.
/// 
/// Permite ao usuário informar um RENAVAM e validar se é válido ou não
/// de acordo com as regras oficiais de RENAVAM brasileiro.
/// 
/// Padrão MVC - Componente: View (Stateful)
/// Responsabilidades:
/// - Exibir campo de entrada para RENAVAM
/// - Exibir resultado da validação
/// - Gerenciar estado da validação
/// - Comunicar com o controller para operações
class RenavamCheckPage extends StatefulWidget {
  /// Construtor padrão da página.
  const RenavamCheckPage({super.key});

  @override
  State<RenavamCheckPage> createState() => _RenavamCheckPageState();
}

/// Estado da [RenavamCheckPage].
/// 
/// Responsável pelo gerenciamento do ciclo de vida e do estado
/// da validação de RENAVAM.
class _RenavamCheckPageState extends State<RenavamCheckPage> {
  /// Controlador do campo de entrada de texto.
  /// 
  /// Gerencia o texto informado pelo usuário para validação.
  final _textController = TextEditingController();

  /// Instância privada do controller de geração de RENAVAM.
  /// 
  /// Reutilizado para validação de RENAVAM.
  late final RenavamGeneratorController _controller;

  /// Armazena o resultado da validação (válido/inválido).
  /// 
  /// Inicialmente null, é atualizado após validação.
  String? _result;

  @override
  void initState() {
    super.initState();
    
    /// Inicializa o controller com o serviço de documentos.
    _controller = RenavamGeneratorController(
      documentGeneratorService: DocumentGeneratorService(),
    );
  }

  @override
  void dispose() {
    /// Libera recursos do controlador de texto ao descartar a página.
    _textController.dispose();
    super.dispose();
  }

  /// Valida o RENAVAM informado pelo usuário.
  /// 
  /// Obtém o texto do campo, delegua a validação ao controller
  /// e atualiza o resultado exibido.
  void _check() {
    final value = _textController.text;
    final isValid = _controller.isValidRenavam(value);
    setState(() {
      _result = isValid ? 'RENAVAM válido' : 'RENAVAM inválido';
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultStyle = Theme.of(context).textTheme.titleMedium;
    
    return Scaffold(
      /// AppBar com título da página.
      appBar: AppBar(title: const Text('Checagem de RENAVAM')),
      
      /// Corpo principal com campo de entrada e resultado.
      body: Stack(
        children: [
          const BackgroundLogo(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Campo de entrada para o RENAVAM.
            /// Aceita números (teclado numérico).
            TextField(
              controller: _textController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o RENAVAM',
                hintText: '12345678901',
              ),
            ),
            const SizedBox(height: 12),
            
            /// Botão para validar o RENAVAM informado.
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
