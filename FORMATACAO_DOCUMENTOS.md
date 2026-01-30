# Documentação: Formatação de Documentos com/sem Ponto

## Resumo das Alterações

O projeto foi atualizado para permitir que o usuário escolha entre gerar documentos com ou sem formatação (pontos, hífen, barra, etc.).

## Regra de Negócio Implementada

### Padrão de Geração
- **Por padrão:** Todos os documentos são gerados **SEM ponto, barra ou hífen**
- **Sob demanda:** O usuário pode ativar a formatação através de um Switch/Toggle na interface

### Documentos com Opção de Formatação

#### 1. **CPF**
- **Sem formatação:** `12345678910`
- **Com formatação:** `123.456.789-10`
- **UI Toggle:** "Com ponto e hífen"

#### 2. **CNPJ**
- **Sem formatação:** `12345678000190`
- **Com formatação:** `12.345.678/0001-90`
- **UI Toggle:** "Com ponto, barra e hífen"

#### 3. **CNH**
- **Sem formatação:** `123456789012`
- **Com formatação:** `1234567890-12`
- **UI Toggle:** "Com hífen"

#### 4. **RENAVAM**
- **Sem formatação:** `12345678901`
- **Com formatação:** `12.345.678.90-1`
- **UI Toggle:** "Com ponto e hífen"

## Estrutura de Implementação

### 1. Service Layer (`DocumentGeneratorService`)
Todos os métodos de geração foram atualizados para aceitar um parâmetro `formatted`:

```dart
String generateCpf({bool formatted = false})
String generateCnpj({bool formatted = false})
String generateCnh({bool formatted = false})
String generateRenavam({bool formatted = false})
```

**Padrão:** `formatted = false` (sem formatação)

### 2. Controller Layer
Cada controller foi atualizado para passar o parâmetro de formatação ao serviço:

```dart
class CpfGeneratorController {
  String generateCpf({bool formatted = false}) {
    return _documentGeneratorService.generateCpf(formatted: formatted);
  }
}
```

Mesmo padrão para:
- `CnpjGeneratorController`
- `CnhGeneratorController`
- `RenavamGeneratorController`

### 3. View Layer (Páginas)
Cada página de geração foi atualizada com:

#### Estado da Página
- Adicionada variável `bool _formatted = false` (padrão sem formatação)
- Método `_toggleFormatted()` para alternar o estado

#### Interface do Usuário
- **Switch/Toggle** para alternar entre formatado/não formatado
- O documento é **regenerado automaticamente** ao mudar o toggle
- Sempre respeitando o padrão de "sem formatação"

#### Páginas Atualizadas:
- `CpfGeneratorPage`
- `CnpjGeneratorPage`
- `CnhGeneratorPage`
- `RenavamGeneratorPage`

## Fluxo de Geração

```
Usuário abre página
    ↓
Documento gerado SEM formatação (padrão)
    ↓
Usuário pode ativar toggle "Com ponto..."
    ↓
Documento é regenerado COM formatação
    ↓
Usuário desativa toggle
    ↓
Documento é regenerado SEM formatação novamente
```

## Exemplo de Uso

### Página CPF
1. Usuário abre "Gerador de CPF"
2. Vê: `12345678910` (sem ponto)
3. Clica no toggle "Com ponto e hífen"
4. Vê: `123.456.789-10` (com ponto)
5. Clica em "Gerar novamente"
6. Novo CPF com formatação: `98765432109-87`

## Vantagens da Implementação

✅ **Flexibilidade:** Usuário escolhe o formato desejado  
✅ **Padrão Consistente:** Sem formatação por padrão  
✅ **Experiência Intuitiva:** Toggle claro e responsivo  
✅ **Sem Breaking Changes:** Métodos mantêm compatibilidade com `formatted = false`  
✅ **Reutilização de Código:** Mesma lógica em todos os documentos  

## Notas Técnicas

- Todos os métodos de geração retornam a string já formatada ou não
- Não há processamento adicional na view, tudo é feito no service
- O estado de formatação é mantido na página, não no controller
- Quando o toggle é acionado, um novo documento é gerado automaticamente

## Próximas Melhorias Sugeridas

- Persistir preferência de formatação em `SharedPreferences` ou similar
- Adicionar opção global de formatação nas configurações do app
- Implementar mesmo padrão para geração de pessoas (nome, sobrenome, etc.)
