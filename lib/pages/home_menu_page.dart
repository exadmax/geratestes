import 'package:flutter/material.dart';

import '../widgets/menu_card.dart';
import 'cnpj_check_page.dart';
import 'cnpj_generator_page.dart';
import 'cpf_check_page.dart';
import 'cpf_generator_page.dart';
import 'person_generator_page.dart';

class HomeMenuPage extends StatelessWidget {
  const HomeMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geratestes'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MenuCard(
            title: 'Gerador de CPF',
            subtitle: 'Gere CPFs válidos com padrão brasileiro',
            icon: Icons.badge_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CpfGeneratorPage()),
            ),
          ),
          MenuCard(
            title: 'Gerador de CNPJ',
            subtitle: 'Gere CNPJs válidos com padrão brasileiro',
            icon: Icons.apartment_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CnpjGeneratorPage()),
            ),
          ),
          MenuCard(
            title: 'Checagem de CPF',
            subtitle: 'Valide CPFs informados',
            icon: Icons.verified_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CpfCheckPage()),
            ),
          ),
          MenuCard(
            title: 'Checagem de CNPJ',
            subtitle: 'Valide CNPJs informados',
            icon: Icons.domain_verification_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CnpjCheckPage()),
            ),
          ),
          MenuCard(
            title: 'Gerador de Pessoa Física',
            subtitle: 'Dados completos para testes',
            icon: Icons.person_outline,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PersonGeneratorPage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
