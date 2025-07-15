#!/bin/bash

# Nombre del repositorio a crear
REPO_NAME="$1"

# Validar argumento
if [ -z "$REPO_NAME" ]; then
  echo "❌ Debes proporcionar un nombre para el repositorio."
  echo "Uso: ./create-empty-repo.sh nombre-del-repo"
  exit 1
fi

# Crear el directorio y moverse a él
mkdir "$REPO_NAME" && cd "$REPO_NAME" || exit 1

# Inicializar el repositorio con rama main
git init -b main

# Crear el repositorio remoto privado en GitHub (sin push)
gh repo create "$REPO_NAME" --private --source=. --remote=origin

# Confirmar
echo "✅ Repositorio '$REPO_NAME' creado localmente y en GitHub."
echo "📂 Directorio: $(pwd)"
echo "🌱 Rama inicial: main"
echo "🔗 Remoto: origin -> https://github.com/$(gh api user | jq -r .login)/$REPO_NAME"
