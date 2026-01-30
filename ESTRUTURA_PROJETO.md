# 🌳 Árvore do Projeto Refatorado

```
geratestes/
│
├── 📄 README.md ................................. Documentação principal
├── 📄 ARQUITETURA_MVC.md ........................ Guia completo da arquitetura
├── 📄 DIAGRAMA_ARQUITETURA.md .................. Diagramas e fluxos
├── 📄 GUIA_NOVO_RECURSO.md ..................... Como adicionar novos recursos
├── 📄 RESUMO_REFATORACAO.md .................... Resumo desta refatoração
│
├── 📦 pubspec.yaml ............................. Dependências do Flutter
├── 📦 analysis_options.yaml .................... Configuração Lint
│
├── 📁 lib/
│   │
│   ├── 📄 main.dart ............................ ⭐ Ponto de entrada da aplicação
│   │
│   ├── 📁 models/ ............................. 📦 Camada de Dados
│   │   ├── 📄 person_data.dart ................ Entidade: Dados de pessoa
│   │   ├── 📄 history_entry.dart ............ Entidade: Histórico
│   │   ├── 📄 city_entry.dart ............... Entidade: Cidade
│   │   └── 📄 name_entry.dart ............... Entidade: Nome
│   │
│   ├── 📁 controllers/ ........................ 🎮 Camada de Controle
│   │   ├── 📄 cpf_generator_controller.dart ... Controla CPF
│   │   ├── 📄 cnpj_generator_controller.dart .. Controla CNPJ
│   │   ├── 📄 person_generator_controller.dart Controla Pessoa
│   │   └── 📄 history_controller.dart ........ Controla Histórico
│   │
│   ├── 📁 services/ .......................... ⚙️ Camada de Lógica
│   │   ├── 📄 document_generator_service.dart  Gera/Valida documentos
│   │   ├── 📄 person_generator_service.dart    Gera pessoa completa
│   │   └── 📄 history_service.dart ........... Lógica de histórico
│   │
│   ├── 📁 repositories/ ..................... 🗄️ Camada de Persistência
│   │   └── 📄 history_repository.dart ....... Persiste histórico
│   │
│   ├── 📁 pages/ ............................ 🎨 Camada de Apresentação
│   │   ├── 📄 home_menu_page.dart ........... Menu principal
│   │   ├── 📄 cpf_generator_page.dart ....... Gerar CPF
│   │   ├── 📄 cpf_check_page.dart .......... Validar CPF
│   │   ├── 📄 cnpj_generator_page.dart ...... Gerar CNPJ
│   │   ├── 📄 cnpj_check_page.dart ........ Validar CNPJ
│   │   ├── 📄 person_generator_page.dart .... Gerar pessoa
│   │   └── 📄 history_page_example.dart ..... Exemplo de histórico
│   │
│   └── 📁 widgets/ .......................... 🧩 Componentes Reutilizáveis
│       ├── 📄 field_row.dart ............... Widget: Linha label-valor
│       ├── 📄 menu_card.dart ............... Widget: Card de menu
│       ├── 📄 person_info_card.dart ........ Widget: Card de pessoa
│       └── 📄 history_widget.dart .......... Widget: Histórico
│
├── 📁 build/ .................................. Saída compilada
├── 📁 test/ ................................... Testes (futuro)
└── 📁 web/ .................................... Assets web
```

---

## 🎯 Legenda

| Símbolo | Significado |
|---------|------------|
| 📄 | Arquivo Dart |
| 📁 | Diretório/Pasta |
| 📦 | Arquivo de configuração |
| ⭐ | Arquivo principal |
| 📦 | Camada de Dados (Models) |
| 🎮 | Camada de Controle (Controllers) |
| ⚙️ | Camada de Lógica (Services) |
| 🗄️ | Camada de Persistência (Repositories) |
| 🎨 | Camada de Apresentação (Views) |
| 🧩 | Componentes Reutilizáveis (Widgets) |

---

## 📊 Estrutura de Dependências

```
lib/main.dart (Raiz)
│
├─── pages/ (Views)
│    ├── HomeMenuPage
│    ├── CpfGeneratorPage ──┐
│    ├── CpfCheckPage       │
│    ├── CnpjGeneratorPage  ├──┬──> controllers/ ──┬──> services/
│    ├── CnpjCheckPage      │  │                    │
│    ├── PersonGeneratorPage│  └──────────────────┬─┴──> models/
│    └── HistoryPageExample │                      │
│                            │                      │
│    widgets/               │                      │
│    ├── FieldRow ──────────┼──────────────────┐  │
│    ├── MenuCard ──────────┼──────────────────┤  │
│    ├── PersonInfoCard ────┼──────────────────┤  │
│    └── HistoryWidget ─────┘                  │  │
│                                              │  │
│    controllers/ (Coordenadores)              │  │
│    ├── CpfGeneratorController ──┐           │  │
│    ├── CnpjGeneratorController   ├──┬──┐    │  │
│    ├── PersonGeneratorController │  │  └────┼──→ PersonData
│    └── HistoryController ────────┘  │      │    HistoryEntry
│                                      │      │    CityEntry
│    services/ (Lógica)                │      │    NameEntry
│    ├── DocumentGeneratorService ────┴──────┼──→ Models
│    ├── PersonGeneratorService ───────────┐ │
│    └── HistoryService ──────────┐        │ │
│                                  │        │ │
│    repositories/ (Persistência)   │        │ │
│    └── HistoryRepository ◄────────┘        │ │
│         (sessionStorage)                   │ │
│                                            │ │
└─────────────────────────────────────────┬──┴─┘
                                          │
                                    Storage/DB
```

---

## 🔀 Relações entre Componentes

### CpfGeneratorPage
```
CpfGeneratorPage (View)
    ├── Usa: CpfGeneratorController
    └── Exibe: TextField, Card, Button
    
CpfGeneratorController (Controller)
    └── Usa: DocumentGeneratorService
    
DocumentGeneratorService (Service)
    └── Gera: String (CPF formatado)
```

### PersonGeneratorPage
```
PersonGeneratorPage (View)
    ├── Usa: PersonGeneratorController
    └── Exibe: PersonInfoCard
    
PersonGeneratorController (Controller)
    └── Usa: PersonGeneratorService
    
PersonGeneratorService (Service)
    ├── Usa: DocumentGeneratorService
    └── Retorna: PersonData
    
PersonData (Model)
    └── firstName, lastName, cpf, ...
```

### HistoryController
```
HistoryController (Controller)
    └── Usa: HistoryService
    
HistoryService (Service)
    └── Usa: HistoryRepository
    
HistoryRepository (Repository)
    ├── Lê/Escreve: sessionStorage
    └── Trabalha com: HistoryEntry (Model)
```

---

## 🧪 Organização para Testes

Para testes futuros, a estrutura permite:

```
test/
├── models/
│   ├── person_data_test.dart
│   └── history_entry_test.dart
│
├── services/
│   ├── document_generator_service_test.dart
│   ├── person_generator_service_test.dart
│   └── history_service_test.dart
│
├── controllers/
│   ├── cpf_generator_controller_test.dart
│   ├── person_generator_controller_test.dart
│   └── history_controller_test.dart
│
├── repositories/
│   └── history_repository_test.dart
│
└── widgets/
    ├── field_row_test.dart
    ├── menu_card_test.dart
    └── person_info_card_test.dart
```

---

## 📈 Evolução Sugerida

```
Fase 1: Refatoração (✅ CONCLUÍDA)
├── Organizar em camadas MVC
├── Comentar código
├── Criar documentação

Fase 2: Testes (➡️ PRÓXIMA)
├── Testes unitários para Services
├── Testes de Controller
├── Testes de Widget

Fase 3: Gerenciamento de Estado (➡️ FUTURA)
├── Implementar GetX ou Provider
├── Melhorar performance
├── Adicionar caching

Fase 4: Persistência Avançada (➡️ FUTURA)
├── Implementar SQLite local
├── Sincronizar com backend
├── Adicionar autenticação

Fase 5: Aplicação Mobile (➡️ FUTURA)
├── Gerar APK/IPA
├── Distribuir em lojas
├── Melhorar UX mobile
```

---

## 🎓 Padrões por Pasta

### lib/models/
- **Padrão**: POJO (Plain Old Dart Objects)
- **Responsabilidade**: Dados puros
- **Dependências**: Nenhuma
- **Exemplo**: `PersonData { firstName, lastName, ... }`

### lib/controllers/
- **Padrão**: Orquestração
- **Responsabilidade**: Coordenar View + Service
- **Dependências**: Services
- **Exemplo**: `CpfGeneratorController { service }`

### lib/services/
- **Padrão**: Encapsulamento de Lógica
- **Responsabilidade**: Implementar lógica de negócio
- **Dependências**: Outras Services, Repositories
- **Exemplo**: `DocumentGeneratorService { generate(), validate() }`

### lib/repositories/
- **Padrão**: Data Access Object (DAO)
- **Responsabilidade**: Abstrair acesso a dados
- **Dependências**: Nenhuma (dependem do storage)
- **Exemplo**: `HistoryRepository { sessionStorage }`

### lib/pages/
- **Padrão**: StatefulWidget / StatelessWidget
- **Responsabilidade**: Apresentação
- **Dependências**: Controllers, Widgets
- **Exemplo**: `CpfGeneratorPage { StatefulWidget }`

### lib/widgets/
- **Padrão**: Widget Reutilizável
- **Responsabilidade**: Componente visual
- **Dependências**: Models, Flutter Widget
- **Exemplo**: `FieldRow { label, value }`

---

## ✨ Resumo Estrutural

```
┌─────────────────────────────────────────────┐
│         📱 INTERFACE DO USUÁRIO             │
│         (pages + widgets)                   │
├─────────────────────────────────────────────┤
│    🎮 ORQUESTRAÇÃO                          │
│    (controllers)                            │
├─────────────────────────────────────────────┤
│    ⚙️ LÓGICA DE NEGÓCIO                     │
│    (services)                               │
├─────────────────────────────────────────────┤
│    🗄️ PERSISTÊNCIA                          │
│    (repositories)                           │
├─────────────────────────────────────────────┤
│    📦 DADOS                                 │
│    (models)                                 │
└─────────────────────────────────────────────┘
```

---

**Estrutura finalizada e documentada com sucesso! 🎉**
