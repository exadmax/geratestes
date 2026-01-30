import 'package:flutter/material.dart';

import 'cnpj_check_page.dart';
import 'cnpj_generator_page.dart';
import 'cpf_check_page.dart';
import 'cpf_generator_page.dart';
import 'person_generator_page.dart';
import 'rg_check_page.dart';
import 'rg_generator_page.dart';

class HomeMenuPage extends StatelessWidget {
  const HomeMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geratestes'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'img/icon.png',
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Geratestes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.badge_outlined),
              title: const Text('Gerador de CPF'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CpfGeneratorPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.apartment_outlined),
              title: const Text('Gerador de CNPJ'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CnpjGeneratorPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_outlined),
              title: const Text('Checagem de CPF'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CpfCheckPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('Gerador de RG'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RgGeneratorPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified),
              title: const Text('Checagem de RG'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RgCheckPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.domain_verification_outlined),
              title: const Text('Checagem de CNPJ'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CnpjCheckPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Gerador de Pessoa Física'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PersonGeneratorPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Opacity(
          opacity: 0.6,
          child: Image.asset(
            'img/icon.png',
            width: MediaQuery.of(context).size.width * 0.5,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
