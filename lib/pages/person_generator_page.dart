import 'package:flutter/material.dart';

import '../controllers/person_generator_controller.dart';
import '../models/person_data.dart';
import '../services/person_generator_service.dart';
import '../widgets/background_logo.dart';
import '../widgets/person_info_card.dart';

/// [PersonGeneratorPage] é a view para geração de pessoa física completa.
/// 
/// Exibe dados completos de uma pessoa (nome, endereço, documentação, etc)
/// e permite ao usuário gerar novos perfis de pessoa através de um botão.
/// 
/// Padrão MVC - Componente: View (Stateful)
/// Responsabilidades:
/// - Exibir dados da pessoa gerada
/// - Gerenciar estado da geração
/// - Comunicar com o controller para operações
/// - Coordenar exibição com widgets especializados
class PersonGeneratorPage extends StatefulWidget {
  /// Construtor padrão da página.
  const PersonGeneratorPage({super.key});

  @override
  State<PersonGeneratorPage> createState() => _PersonGeneratorPageState();
}

/// Estado da [PersonGeneratorPage].
/// 
/// Responsável pelo gerenciamento do ciclo de vida e do estado
/// da geração de pessoa.
class _PersonGeneratorPageState extends State<PersonGeneratorPage> {
  /// Instância privada do controller de geração de pessoa.
  /// 
  /// Coordena a lógica de geração através dos serviços.
  late final PersonGeneratorController _controller;

  /// Variável privada que armazena os dados da pessoa gerada atualmente.
  late PersonData _person;

  @override
  void initState() {
    super.initState();
    
    /// Inicializa o controller com o serviço de geração de pessoa.
    /// Segue o padrão de injeção de dependência.
    _controller = PersonGeneratorController(
      personGeneratorService: PersonGeneratorService(),
    );
    
    /// Gera os dados iniciais da pessoa ao abrir a página.
    _person = _controller.generatePerson();
  }

  /// Regenera uma nova pessoa e atualiza a interface.
  void _regenerate() {
    setState(() {
      _person = _controller.generatePerson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar com título da página.
      appBar: AppBar(title: const Text('Gerador de Pessoa Física')),
      
      /// Corpo principal exibindo dados da pessoa.
      body: Stack(
        children: [
          const BackgroundLogo(),
          SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Texto explicativo.
              Text(
                'Dados brasileiros para testes',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              
              /// Área expansível contendo os dados da pessoa.
              /// Permite scroll se o conteúdo for muito grande.
              Expanded(
                child: ListView(
                  children: [
                    /// Widget especializado para exibição de dados de pessoa.
                    PersonInfoCard(person: _person),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              
              /// Botão para gerar nova pessoa.
              FilledButton.icon(
                onPressed: _regenerate,
                icon: const Icon(Icons.refresh),
                label: const Text('Gerar novamente'),
              ),
            ],
          ),
        ),
          ),
        ],
      ),
    );
  }
}
