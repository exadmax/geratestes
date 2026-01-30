@echo off
REM Script de setup automático do Flutter para o projeto geratestes (Windows)
REM Detecta e configura Flutter conforme necessário

setlocal enabledelayedexpansion

echo 🚀 Iniciando setup do Flutter para geratestes...

REM Detectar se é Windows
echo 📍 Ambiente detectado: Windows

REM Verificar se Flutter está instalado
where flutter >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ Flutter já está instalado
    for /f "tokens=*" %%i in ('flutter --version') do set FLUTTER_VERSION=%%i
    echo !FLUTTER_VERSION!
    goto :pubget
)

REM Se não estiver instalado, mostrar instruções
echo.
echo ⚠️  Flutter não foi encontrado no PATH do Windows.
echo.
echo 📦 Para instalar Flutter no Windows, siga os passos abaixo:
echo.
echo 1. Acesse: https://docs.flutter.dev/get-started/install/windows
echo 2. Baixe o Flutter SDK (Stable Channel)
echo 3. Extraia em um local SEM espaços:
echo    - Exemplo: C:\flutter
echo    - NÃO use: C:\Program Files\flutter
echo.
echo 4. Adicione Flutter ao PATH do Windows:
echo    a) Pressione Win + X e selecione "System" (Configurações do Sistema)
echo    b) Clique em "Advanced system settings" (Configurações avançadas)
echo    c) Clique em "Environment Variables" (Variáveis de Ambiente)
echo    d) Em "User variables" (Variáveis do Usuário), clique em "New" (Novo)
echo    e) Variable name: PATH
echo       Variable value: C:\flutter\bin
echo    f) Clique OK e feche as janelas
echo.
echo 5. Abra um novo terminal (PowerShell ou CMD) e execute:
echo    flutter doctor
echo.
echo 6. Depois, volte para este diretório e execute:
echo    setup-flutter.bat
echo.
pause
exit /b 1

:pubget
echo.
echo 🎉 Setup concluído! Flutter está pronto para usar.
echo.
echo Para continuar, execute:
echo   flutter pub get
echo   flutter run
echo.
pause
exit /b 0
