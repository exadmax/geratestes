# GeraTestes

Aplicacao feita em flutter que gera dados para teste.

## Descrição

Este é um projeto Flutter que serve como gerador de dados para testes. O aplicativo foi desenvolvido em Flutter e pode ser executado em múltiplas plataformas (Android, iOS, Web, Windows, Linux, macOS).

## Requisitos

- Flutter SDK (versão 3.5.0 ou superior)
- Dart SDK
- Para Android: Android Studio e Android SDK
- Para iOS: Xcode (apenas em macOS)

## Como executar

1. Certifique-se de ter o Flutter instalado:
```bash
flutter --version
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
# Para rodar em modo debug
flutter run

# Para rodar na web
flutter run -d chrome

# Para rodar em dispositivo Android/iOS conectado
flutter run
```

## Testes

Para executar os testes:
```bash
flutter test
```

## Estrutura do Projeto

- `lib/` - Código fonte principal do aplicativo
  - `main.dart` - Ponto de entrada da aplicação
- `test/` - Testes unitários e de widget
- `android/` - Configurações específicas do Android
- `ios/` - Configurações específicas do iOS
- `web/` - Configurações específicas da Web
- `linux/` - Configurações específicas do Linux
- `macos/` - Configurações específicas do macOS
- `windows/` - Configurações específicas do Windows

## Funcionalidades

- Interface Material Design
- Geração de dados de teste (a ser implementado)
- Suporte multi-plataforma
