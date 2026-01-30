import 'package:flutter/material.dart';

/// [HamburgerMenu] é um widget de menu hambúrguer animado.
/// 
/// Exibe um ícone de menu hambúrguer no topo esquerdo que quando clicado
/// desce uma lista de navegações do sistema.
/// 
/// Padrão MVC - Componente: Widget
/// Responsabilidades:
/// - Exibir botão hambúrguer
/// - Gerenciar animação do menu
/// - Navegar para diferentes seções
class HamburgerMenu extends StatefulWidget {
  /// Construtor padrão do widget.
  const HamburgerMenu({super.key});

  @override
  State<HamburgerMenu> createState() => _HamburgerMenuState();
}

/// Estado do widget [HamburgerMenu].
class _HamburgerMenuState extends State<HamburgerMenu>
    with SingleTickerProviderStateMixin {
  /// Controlador para animação de rotação do ícone.
  late AnimationController _animationController;

  /// Animação de rotação do ícone do menu.
  late Animation<double> _rotationAnimation;

  /// Indica se o menu está aberto ou fechado.
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Alterna entre aberto e fechado do menu.
  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });

    if (_isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  /// Navega para a página especificada.
  void _navigateTo(BuildContext context, Widget page) {
    _toggleMenu();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Menu dropdown que aparece quando aberto.
        if (_isOpen)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildMenuDropdown(context),
          ),

        /// Botão hambúrguer no topo esquerdo.
        Positioned(
          top: 10,
          left: 10,
          child: GestureDetector(
            onTap: _toggleMenu,
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 3.14159265359,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.menu,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Constrói o dropdown do menu com as opções de navegação.
  Widget _buildMenuDropdown(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Cabeçalho do menu.
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'img/icon.png',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Geratestes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /// Itens do menu de navegação.
            _buildMenuItem(
              context,
              'Gerador de CPF',
              Icons.badge_outlined,
              () => _navigateToPage(context, 'cpf_generator'),
            ),
            _buildMenuItem(
              context,
              'Gerador de CNPJ',
              Icons.apartment_outlined,
              () => _navigateToPage(context, 'cnpj_generator'),
            ),
            _buildMenuItem(
              context,
              'Checagem de CPF',
              Icons.verified_outlined,
              () => _navigateToPage(context, 'cpf_check'),
            ),
            _buildMenuItem(
              context,
              'Checagem de CNPJ',
              Icons.domain_verification_outlined,
              () => _navigateToPage(context, 'cnpj_check'),
            ),
            _buildMenuItem(
              context,
              'Gerador de Pessoa',
              Icons.person_outline,
              () => _navigateToPage(context, 'person_generator'),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói um item individual do menu.
  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Navega para a página especificada baseado no tipo.
  void _navigateToPage(BuildContext context, String pageType) {
    // Implementar navegação para diferentes páginas
    // Isto será integrado na próxima task
  }
}
