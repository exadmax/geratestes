# geratestes
Aplicacao feita em Flutter que gera dados para teste com padroes brasileiros.

🌐 **[Acesse a aplicação online](https://exadmax.github.io/geratestes/)**

## Funcionalidades
- Gerador de pessoas com dados brasileiros.
- CPF valido (algoritmo oficial).
- Nome, sexo (H/M), sobrenome, idade, endereco e CEP.
- Conteudo gerado selecionavel para copiar.

## Como executar localmente
1. Instale o Flutter (SDK e dependencias).
2. No terminal, execute:
	- `flutter pub get`
	- `flutter run`

## Deploy no GitHub Pages
A aplicação está configurada para deploy automático no GitHub Pages. Para ativar:

1. Vá em **Settings** > **Pages** no seu repositório
2. Em **Source**, selecione **GitHub Actions**
3. Faça push para a branch `main` e o workflow fará o deploy automaticamente

A build pronta está em `build/web/` e pode ser servida por qualquer servidor web estático.

## Estrutura principal
- [lib/main.dart](lib/main.dart)
