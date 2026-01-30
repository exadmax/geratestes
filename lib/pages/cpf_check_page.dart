import 'package:flutter/material.dart';

import '../controllers/cpf_generator_controller.dart';
import '../services/document_generator_service.dart';
import '../widgets/background_logo.dart';

/// [CpfCheckPage] é a view para validação de CPF.
/// 
/// Permite ao usuário informar um CPF e validar se é válido ou não
/// de acordo com as regras oficiais de CPF brasileiro.
/// 
/// Padrão MVC - Componente: View (Stateful)
/// Responsabilidades:
/// - Exibir campo de entrada para CPF
/// - Exibir resultado da validação
/// - Gerenciar estado da validação
/// - Comunicar com o controller para operações
class CpfCheckPage extends StatefulWidget {
  /// Construtor padrão da página.
  const CpfCheckPage({super.key});

  @override
  State<CpfCheckPage> createState() => _CpfCheckPageState();
}

/// Estado da [CpfCheckPage].
/// 
/// Responsável pelo gerenciamento do ciclo de vida e do estado
/// da validação de CPF.
class _CpfCheckPageState extends State<CpfCheckPage> {
  /// Controlador do campo de entrada de texto.
  /// 
  /// Gerencia o texto informado pelo usuário para validação.
  final _textController = TextEditingController();

  /// Instância privada do controller de geração de CPF.
  /// 
  /// Reutilizado para validação de CPF.
  late final CpfGeneratorController _controller;

  /// Armazena o resultado da validação (válido/inválido).
  /// 
  /// Inicialmente null, é atualizado após validação.
  String? _result;

  @override
  void initState() {
    super.initState();
    
    /// Inicializa o controller com o serviço de documentos.
    _controller = CpfGeneratorController(
      documentGeneratorService: DocumentGeneratorService(),
    );
  }

  @override
  void dispose() {
    /// Libera recursos do controlador de texto ao descartar a página.
    _textController.dispose();
    super.dispose();
  }

  /// Valida o CPF informado pelo usuário.
  /// 
  /// Obtém o texto do campo, delegua a validação ao controller
  /// e atualiza o resultado exibido.
  void _check() {
    final value = _textController.text;
    final isValid = _controller.isValidCpf(value);
    setState(() {
      _result = isValid ? 'CPF válido' : 'CPF inválido';
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultStyle = Theme.of(context).textTheme.titleMedium;
    
    return Scaffold(
      /// AppBar com título da página.
      appBar: AppBar(title: const Text('Checagem de CPF')),
      
      /// Corpo principal com campo de entrada e resultado.
      body: Stack(
        children: [
          const BackgroundLogo(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Campo de entrada para o CPF.
            /// Aceita números (teclado numérico).
            TextField(
              controller: _textController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o CPF',
                hintText: '000.000.000-00',
              ),
            ),
            const SizedBox(height: 12),
            
            /// Botão para validar o CPF informado.
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
