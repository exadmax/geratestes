# Arquitetura do Projeto GeraTestes

## Estrutura do Projeto

```
geratestes/
├── lib/                          # Código fonte principal
│   └── main.dart                 # Ponto de entrada da aplicação
├── test/                         # Testes
│   └── widget_test.dart          # Testes de widget
├── android/                      # Configuração Android
│   ├── app/
│   │   ├── build.gradle          # Configuração de build do app
│   │   └── src/main/
│   │       ├── AndroidManifest.xml
│   │       ├── kotlin/com/example/geratestes/
│   │       │   └── MainActivity.kt
│   │       └── res/values/
│   │           └── styles.xml
│   ├── build.gradle              # Configuração de build raiz
│   ├── gradle.properties         # Propriedades do Gradle
│   └── settings.gradle           # Configurações do Gradle
├── ios/                          # Configuração iOS
│   └── Runner/
│       ├── AppDelegate.swift     # Delegate principal do app
│       └── Info.plist            # Configurações do app
├── web/                          # Configuração Web
│   ├── index.html                # HTML principal
│   └── manifest.json             # Manifest do PWA
├── linux/                        # Configuração Linux (placeholder)
├── macos/                        # Configuração macOS (placeholder)
├── windows/                      # Configuração Windows (placeholder)
├── pubspec.yaml                  # Dependências e metadados
├── analysis_options.yaml         # Regras de análise do Dart
├── .metadata                     # Metadados do projeto Flutter
├── .gitignore                    # Arquivos ignorados pelo Git
└── README.md                     # Documentação principal
```

## Componentes Principais

### 1. Aplicação Flutter (lib/main.dart)

A aplicação principal consiste em:

- **MyApp**: Widget raiz que configura o MaterialApp
  - Título: "GeraTestes"
  - Tema: Material Design 3 com cor seed DeepPurple
  
- **MyHomePage**: Página principal da aplicação
  - AppBar com título "GeraTestes - Gerador de Dados para Teste"
  - Corpo central com:
    - Texto descritivo: "Aplicação para gerar dados de teste"
    - Contador de cliques (demonstração)
  - FloatingActionButton para incrementar contador

### 2. Configuração Android

- **MainActivity.kt**: Activity principal usando FlutterActivity
- **AndroidManifest.xml**: Configuração do app Android
  - Label: "GeraTestes"
  - Permissões: Internet
  - Suporte a Flutter Embedding v2

### 3. Configuração iOS

- **AppDelegate.swift**: Delegate principal do app iOS
- **Info.plist**: Configurações do bundle iOS
  - Display Name: "GeraTestes"
  - Suporte a orientações portrait e landscape

### 4. Configuração Web

- **index.html**: Página HTML base para Flutter Web
- **manifest.json**: Manifest para Progressive Web App (PWA)
  - Tema: #0175C2 (azul Flutter)

## Dependências

- **flutter**: SDK principal
- **cupertino_icons**: Ícones iOS
- **flutter_test**: Framework de testes
- **flutter_lints**: Regras de lint recomendadas

## Plataformas Suportadas

- ✅ Android
- ✅ iOS
- ✅ Web
- 🔄 Linux (estrutura criada)
- 🔄 macOS (estrutura criada)
- 🔄 Windows (estrutura criada)

## Próximos Passos

1. Implementar funcionalidades de geração de dados de teste
2. Adicionar interface para diferentes tipos de dados
3. Implementar exportação de dados gerados
4. Adicionar testes unitários e de integração
5. Configurar CI/CD
