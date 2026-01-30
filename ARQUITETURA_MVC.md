# Geratestes - Refatoração para Padrão MVC

## 📋 Estrutura do Projeto

O projeto foi refatorado para seguir o padrão **Model-View-Controller (MVC)**, proporcionando melhor organização, legibilidade e manutenibilidade do código.

### 📁 Estrutura de Diretórios

```
lib/
├── main.dart                          # Configuração inicial da aplicação
├── models/                            # Entidades de dados (Models)
│   ├── city_entry.dart               # Entidade: Pares cidade-estado
│   ├── history_entry.dart            # Entidade: Registros de histórico
│   ├── name_entry.dart               # Entidade: Pares nome-gênero
│   └── person_data.dart              # Entidade: Dados completos de pessoa
├── controllers/                       # Controllers (Lógica de Negócio)
│   ├── cpf_generator_controller.dart    # Controla geração/validação de CPF
│   ├── cnpj_generator_controller.dart   # Controla geração/validação de CNPJ
│   ├── history_controller.dart          # Controla operações de histórico
│   └── person_generator_controller.dart # Controla geração de pessoa
├── services/                          # Serviços (Operações de Lógica)
│   ├── document_generator_service.dart  # Gera e valida documentos
│   ├── history_service.dart            # Lógica de negócio do histórico
│   └── person_generator_service.dart    # Gera dados completos de pessoa
├── repositories/                      # Repositórios (Acesso a Dados)
│   └── history_repository.dart        # Persiste histórico no storage
├── pages/                             # Views - Telas da Aplicação
│   ├── home_menu_page.dart            # Tela inicial com menu
│   ├── cpf_generator_page.dart        # Tela gerador de CPF
│   ├── cpf_check_page.dart            # Tela validador de CPF
│   ├── cnpj_generator_page.dart       # Tela gerador de CNPJ
│   ├── cnpj_check_page.dart           # Tela validador de CNPJ
│   └── person_generator_page.dart     # Tela gerador de pessoa
└── widgets/                           # Widgets Reutilizáveis (Presentational)
    ├── field_row.dart                 # Widget: Linha label-valor
    ├── menu_card.dart                 # Widget: Card de menu
    └── person_info_card.dart          # Widget: Card de informações
```

## 🏗️ Padrão MVC Explicado

### **Models** 📦
Entidades que representam os dados da aplicação.

- **PersonData**: Dados completos de uma pessoa (nome, endereço, documentos)
- **HistoryEntry**: Registro de uma geração anterior
- **CityEntry**: Pares de cidade e estado
- **NameEntry**: Pares de nome e gênero

**Arquivo**: `lib/models/`

---

### **Views** 🎨
Componentes de interface (páginas e widgets) responsáveis pela apresentação.

#### Páginas (em `lib/pages/`)
- **HomeMenuPage**: Menu principal com opções de navegação
- **CpfGeneratorPage**: Exibe CPF gerado e permite regeneração
- **CpfCheckPage**: Campo para validar CPF informado
- **CnpjGeneratorPage**: Exibe CNPJ gerado e permite regeneração
- **CnpjCheckPage**: Campo para validar CNPJ informado
- **PersonGeneratorPage**: Exibe dados completos de pessoa gerada

#### Widgets (em `lib/widgets/`)
- **MenuCard**: Card clicável para opções de menu
- **FieldRow**: Linha com rótulo e valor selecionável
- **PersonInfoCard**: Card exibindo todos os dados de uma pessoa

**Característica Importante**: Views são agnósticas à lógica de negócio, apenas coordenam com Controllers.

---

### **Controllers** 🎮
Intermediários entre Views e Serviços, coordenando a lógica de apresentação.

- **CpfGeneratorController**: Coordena geração e validação de CPF
- **CnpjGeneratorController**: Coordena geração e validação de CNPJ
- **PersonGeneratorController**: Coordena geração de pessoa
- **HistoryController**: Coordena operações de histórico

**Responsabilidades**:
- Preparar dados para a View
- Coordenar chamadas de serviços
- Aplicar lógica de apresentação
- Executar validações simples

**Arquivo**: `lib/controllers/`

---

### **Services** ⚙️
Encapsulam a lógica de negócio da aplicação.

- **DocumentGeneratorService**: Gera e valida CPF e CNPJ
  - Algoritmos de checksum
  - Validações de formato
  - Rejeição de documentos inválidos

- **PersonGeneratorService**: Gera dados completos e realistas de pessoa
  - Seleciona nomes, sobrenomes aleatoriamente
  - Gera endereços convincentes
  - Utiliza DocumentGeneratorService para gerar CPF

- **HistoryService**: Lógica de negócio do histórico
  - Interface entre Controllers e Repositório
  - Operações de alto nível

**Arquivo**: `lib/services/`

---

### **Repositories** 🗄️
Abstraem o acesso aos dados (persistência).

- **HistoryRepository**: Gerencia persistência de histórico
  - Acesso ao sessionStorage do navegador
  - Serialização/desserialização de dados
  - Operações CRUD

**Padrão**: Separa lógica de acesso a dados da lógica de negócio.

**Arquivo**: `lib/repositories/`

---

## 🔄 Fluxo de Dados (Exemplo: Geração de CPF)

```
1. USER INTERACTION
   └─> Toca botão "Gerar"

2. VIEW (CpfGeneratorPage)
   └─> Chama _controller.generateCpf()

3. CONTROLLER (CpfGeneratorController)
   └─> Chama _documentGeneratorService.generateCpf()

4. SERVICE (DocumentGeneratorService)
   └─> Executa lógica: Random → Checksum → Formatação
   └─> Retorna CPF válido

5. CONTROLLER
   └─> Retorna CPF para View

6. VIEW
   └─> setState() atualiza interface
   └─> Exibe novo CPF

7. APRESENTAÇÃO
   └─> Usuário vê CPF formatado (XXX.XXX.XXX-XX)
```

---

## 💡 Vantagens da Estrutura MVC

### 1. **Separação de Responsabilidades**
- Models: Dados
- Views: Apresentação
- Controllers: Orquestração
- Services: Lógica de negócio
- Repositories: Persistência

### 2. **Facilita Testes**
- Controllers e Services podem ser testados independentemente
- Mock de dependências é simples (injeção de dependência)

### 3. **Código Reutilizável**
- Services podem ser usados por múltiplos Controllers
- Widgets podem ser usados em múltiplas Views

### 4. **Manutenção Simplificada**
- Cada classe tem responsabilidade clara
- Mudanças na UI não afetam lógica de negócio
- Bugs são mais fáceis de localizar

### 5. **Escalabilidade**
- Fácil adicionar novos recursos
- Estrutura pronta para crescimento

---

## 📝 Convenções de Nomenclatura

| Tipo | Padrão | Exemplo |
|------|--------|---------|
| Models | Entidade (substantivo) | `PersonData`, `HistoryEntry` |
| Controllers | [Entidade]Controller | `CpfGeneratorController` |
| Services | [Operação]Service | `DocumentGeneratorService` |
| Repositories | [Entidade]Repository | `HistoryRepository` |
| Pages | [Nome]Page | `CpfGeneratorPage` |
| Widgets | [Nome]Widget ou [Descrição] | `FieldRow`, `MenuCard` |

---

## 📚 Comentários no Código

Todo o código foi comentado detalhadamente com:

- **Documentação de Classe**: O que a classe faz e sua responsabilidade
- **Documentação de Método**: O que o método faz, parâmetros e retorno
- **Documentação de Campo**: O propósito de cada atributo
- **Comentários Inline**: Explicações de lógica complexa

Exemplo:
```dart
/// [CpfGeneratorController] gerencia a lógica de geração de CPF.
/// 
/// Esse controller atua como intermediário entre a view (página) e os serviços
/// de geração de dados, seguindo o padrão MVC.
class CpfGeneratorController {
  /// Instância privada do serviço de geração de documentos.
  final DocumentGeneratorService _documentGeneratorService;
  
  /// Gera um novo CPF válido.
  /// 
  /// Retorna:
  ///   Uma string contendo um CPF formatado (XXX.XXX.XXX-XX).
  String generateCpf() { ... }
}
```

---

## 🔧 Injeção de Dependência

O projeto utiliza **injeção de dependência manual** para manter a simplicidade:

```dart
// Exemplo: CpfGeneratorPage inicializa com dependências
_controller = CpfGeneratorController(
  documentGeneratorService: DocumentGeneratorService(),
);
```

Benefícios:
- Fácil fazer mock para testes
- Código mais testável
- Sem dependências externas pesadas
- Simplicidade e clareza

---

## 📖 Como Navegar o Código

1. **Entender um Feature**: Comece pelo Model
2. **Ver a Interface**: Vá para a Page/Widget
3. **Entender a Lógica**: Vá para o Controller
4. **Entender as Operações**: Vá para o Service
5. **Entender Persistência**: Vá para o Repository

---

## 🚀 Próximos Passos Sugeridos

1. **Testes Unitários**: Teste Services e Controllers
2. **Testes de Widget**: Teste Pages e Widgets
3. **Provider ou GetX**: Considere usar gerenciador de estado
4. **Persistência**: Expandir Repositories para outros tipos de dados
5. **Logs**: Adicionar logging nos Services

---

## 📄 Resumo da Refatoração

✅ **Mudanças Realizadas**:
- ✓ Reorganização de Models com comentários detalhados
- ✓ Criação de Controllers para orquestração
- ✓ Refatoração de Serviços com nomenclatura padrão
- ✓ Criação de Repositório para persistência
- ✓ Refatoração de Views (Pages) com MVC
- ✓ Comentários em todos os Widgets
- ✓ Documentação completa do projeto

✨ **Resultado**: Projeto estruturado, bem documentado e pronto para manutenção e evolução!
