#!/bin/bash

# Script de setup automático do Flutter para o projeto geratestes
# Detecta o ambiente (Codespace/Linux/Windows) e configura Flutter conforme necessário

set -e

echo "🚀 Iniciando setup do Flutter para geratestes..."

# Detectar o ambiente
if [ -d "/workspaces" ]; then
    # Estamos em um Codespace
    echo "📍 Ambiente detectado: Codespace"
    FLUTTER_PATH="/workspaces/flutter"
    IS_CODESPACE=true
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    # Estamos no Windows
    echo "📍 Ambiente detectado: Windows"
    FLUTTER_PATH=""  # Windows usa variáveis de ambiente do sistema
    IS_WINDOWS=true
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux local
    echo "📍 Ambiente detectado: Linux local"
    FLUTTER_PATH="$HOME/flutter"
else
    echo "📍 Ambiente detectado: Sistema desconhecido ($OSTYPE)"
    FLUTTER_PATH="$HOME/flutter"
fi

# Função para verificar se Flutter está instalado
check_flutter() {
    if command -v flutter &> /dev/null; then
        FLUTTER_VERSION=$(flutter --version | head -n 1)
        echo "✅ Flutter já está instalado: $FLUTTER_VERSION"
        return 0
    fi
    
    if [ -n "$FLUTTER_PATH" ] && [ -d "$FLUTTER_PATH/bin" ]; then
        export PATH="$FLUTTER_PATH/bin:$PATH"
        if flutter --version &> /dev/null; then
            FLUTTER_VERSION=$(flutter --version | head -n 1)
            echo "✅ Flutter encontrado em $FLUTTER_PATH: $FLUTTER_VERSION"
            return 0
        fi
    fi
    
    return 1
}

# Função para instalar Flutter em Codespace
install_flutter_codespace() {
    echo "📦 Instalando Flutter em Codespace..."
    
    if [ -d "$FLUTTER_PATH" ]; then
        echo "⚠️  Flutter já existe em $FLUTTER_PATH"
        return 0
    fi
    
    mkdir -p /workspaces
    cd /workspaces
    
    echo "📥 Baixando Flutter..."
    git clone https://github.com/flutter/flutter.git --depth 1
    
    export PATH="/workspaces/flutter/bin:$PATH"
    
    echo "🔧 Executando flutter doctor..."
    flutter doctor
    
    echo "✅ Flutter instalado com sucesso em $FLUTTER_PATH"
}

# Função para instalar Flutter no Linux local
install_flutter_linux() {
    echo "📦 Instalando Flutter no Linux..."
    
    mkdir -p $FLUTTER_PATH
    cd $FLUTTER_PATH
    
    echo "📥 Baixando Flutter..."
    git clone https://github.com/flutter/flutter.git --depth 1
    
    export PATH="$FLUTTER_PATH/flutter/bin:$PATH"
    
    echo "🔧 Executando flutter doctor..."
    flutter doctor
    
    echo "✅ Flutter instalado com sucesso em $FLUTTER_PATH"
    echo "⚠️  Adicione a seguinte linha ao seu ~/.bashrc ou ~/.zshrc:"
    echo "   export PATH=\"$FLUTTER_PATH/flutter/bin:\$PATH\""
}

# Função para instalar Flutter no Windows
install_flutter_windows() {
    echo "📦 Instalando Flutter no Windows..."
    echo "⚠️  Por favor, siga os passos abaixo:"
    echo ""
    echo "1. Acesse: https://docs.flutter.dev/get-started/install/windows"
    echo "2. Baixe o Flutter SDK"
    echo "3. Extraia em um local sem espaços (ex: C:\\flutter)"
    echo "4. Adicione C:\\flutter\\bin às variáveis de ambiente PATH"
    echo "5. Abra um novo terminal e execute: flutter doctor"
    echo ""
    return 1
}

# Executar o setup
if check_flutter; then
    echo ""
    echo "🎉 Setup concluído! Flutter está pronto para usar."
    echo ""
    echo "Para continuar, execute:"
    echo "  flutter pub get"
    echo "  flutter run"
    exit 0
fi

echo ""
echo "⚠️  Flutter não encontrado. Iniciando instalação..."
echo ""

if [ "$IS_CODESPACE" = true ]; then
    install_flutter_codespace
elif [ "$IS_WINDOWS" = true ]; then
    install_flutter_windows
else
    install_flutter_linux
fi

# Verificar novamente após instalação
echo ""
if check_flutter; then
    echo ""
    echo "🎉 Setup concluído! Flutter está pronto para usar."
    echo ""
    echo "Para continuar, execute:"
    echo "  flutter pub get"
    echo "  flutter run"
else
    echo ""
    echo "❌ Erro: Não foi possível instalar Flutter."
    echo "   Por favor, verifique a conexão com a internet ou instale manualmente."
    exit 1
fi
