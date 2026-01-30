# geratestes
Aplicacao feita em Flutter que gera dados para teste com padroes brasileiros.

🌐 **[Acesse a aplicação online](https://exadmax.github.io/geratestes/)**

## Funcionalidades
- Gerador de pessoas com dados brasileiros.
- CPF valido (algoritmo oficial).
- Nome, sexo (H/M), sobrenome, idade, endereco e CEP.
- Conteudo gerado selecionavel para copiar.

## Arquitetura do Projeto

O projeto foi refatorado seguindo o padrão **Model-View-Controller (MVC)** para melhor organização e manutenibilidade.

### 📁 Estrutura MVC

```
lib/
├── models/              # Entidades de dados
├── controllers/         # Orquestração de lógica
├── services/            # Lógica de negócio
├── repositories/        # Acesso a dados
├── pages/               # Views (Telas)
└── widgets/             # Componentes reutilizáveis
```

**Saiba mais**: Veja [ARQUITETURA_MVC.md](ARQUITETURA_MVC.md) para documentação detalhada.

### Características da Arquitetura

- **Separação de Responsabilidades**: Cada camada tem um propósito claro
- **Injeção de Dependência**: Facilita testes e manutenção
- **Código Comentado**: Todos os métodos e classes possuem documentação
- **Reutilização**: Widgets, serviços e controllers podem ser reutilizados
- **Escalabilidade**: Estrutura pronta para adicionar novos recursos

## Como executar localmente

### Setup automático do Flutter

O projeto inclui scripts de setup automático que detectam seu ambiente e configuram o Flutter conforme necessário.

#### No Linux / GitHub Codespace

```bash
bash setup-flutter.sh
```

O script irá:
- ✅ Detectar se Flutter já está instalado
- 📍 Identificar se você está em um Codespace (`/workspaces/flutter`) ou Linux local
- 📦 Instalar Flutter automaticamente se não estiver presente
- 🔧 Executar `flutter doctor` para verificar as dependências

#### No Windows

```cmd
setup-flutter.bat
```

O script irá:
- ✅ Verificar se Flutter está no PATH do Windows
- 📋 Fornecer instruções passo-a-passo para instalação se necessário
- 🔗 Ajudar a adicionar Flutter às variáveis de ambiente

### Instalação manual

Se preferir instalar manualmente:

1. **Instale o Flutter** conforme seu sistema operacional:
   - [Linux/Mac](https://docs.flutter.dev/get-started/install/linux)
   - [Windows](https://docs.flutter.dev/get-started/install/windows)

2. **Instale as dependências do projeto**:
   ```bash
   flutter pub get
   ```

3. **Execute a aplicação**:
   ```bash
   flutter run
   ```

## Deploy no GitHub Pages
A aplicação está configurada para deploy automático no GitHub Pages. Para ativar:

1. Vá em **Settings** > **Pages** no seu repositório
2. Em **Source**, selecione **GitHub Actions**
3. Faça push para a branch `main` e o workflow fará o deploy automaticamente

A build pronta está em `build/web/` e pode ser servida por qualquer servidor web estático.

## Configuração do Ambiente de Desenvolvimento

Para informações sobre Flutter SDK, builds e configurações de agentes, consulte [AGENTS.md](AGENTS.md).

## Estrutura principal
- [lib/main.dart](lib/main.dart) - Configuração inicial da aplicação
- [lib/models/](lib/models/) - Entidades de dados
- [lib/controllers/](lib/controllers/) - Controllers MVC
- [lib/services/](lib/services/) - Serviços de lógica de negócio
- [lib/repositories/](lib/repositories/) - Repositórios para persistência
- [lib/pages/](lib/pages/) - Telas/Views
- [lib/widgets/](lib/widgets/) - Widgets reutilizáveis

