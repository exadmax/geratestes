# Configuração de Agentes e Ambiente

## Flutter SDK

### Localização
- **Path**: `/workspaces/flutter`
- **Versão**: 3.24.5 (stable channel)
- **Dart SDK**: 3.5.4
- **DevTools**: 2.37.3

### Configuração de PATH
Para usar o Flutter, adicione ao PATH:
```bash
export PATH="/workspaces/flutter/bin:$PATH"
```

### Comandos Úteis
```bash
# Verificar versão
/workspaces/flutter/bin/flutter --version

# Atualizar dependências
/workspaces/flutter/bin/flutter pub get

# Build para Web
/workspaces/flutter/bin/flutter build web

# Clean antes de build
/workspaces/flutter/bin/flutter clean
```

## Otimizações Realizadas

### Imagem do Projeto (icon.png)
- **Tamanho original**: 6.5 MB
- **Tamanho otimizado**: 2.9 MB (55% redução)
- **Ferramenta**: pngquant com qualidade 85-95%
- **Localização**: `/workspaces/geratestes/img/icon.png`

### Configuração de Assets
- Asset registrado no `pubspec.yaml`: `assets: - img/icon.png`
- Favicon da web: `/workspaces/geratestes/web/favicon.png`

## Build Web

### Informações do Build
- **Localização**: `/workspaces/geratestes/build/web/`
- **Tamanho total**: ~32 MB
- **Tree-shaking de fontes**: 99.5% redução

### Processo de Build Recomendado
```bash
export PATH="/workspaces/flutter/bin:$PATH"
cd /workspaces/geratestes
flutter clean
flutter pub get
flutter build web
```

## Notas para Agentes

⚠️ **NÃO usar Flutter de /opt** - Foi removido pois a versão em `/workspaces/flutter` é superior (3.24.5 vs 3.19.0)

✅ **Use sempre**: `/workspaces/flutter/bin/flutter`

## Menu Hambúrguer

Implementado na página inicial com:
- Botão animado no AppBar superior esquerdo
- Menu dropdown com navegação para 5 seções
- Animações suaves (rotação do ícone)
- Fechar automático ao navegar
