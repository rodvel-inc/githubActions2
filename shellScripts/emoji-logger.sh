#!/bin/bash

# 🎨 Colores ANSI
RESET="\033[0m"
BOLD="\033[1m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[0;36m"

# 🕒 Obtener timestamp actual (formato HH:MM:SS)
timestamp() {
  date +"%H:%M:%S"
}

# 📢 Funciones de log

log_info() {
  echo -e "${BLUE}[$(timestamp)] [INFO] ℹ️  $*${RESET}"
}

log_success() {
  echo -e "${GREEN}[$(timestamp)] [SUCCESS] ✅ $*${RESET}"
}

log_warning() {
  echo -e "${YELLOW}[$(timestamp)] [WARNING] ⚠️  $*${RESET}"
}

log_error() {
  echo -e "${RED}[$(timestamp)] [ERROR] ❌ $*${RESET}"
}

log_task() {
  echo -e "${BOLD}[$(timestamp)] [TASK] 🔧 $*${RESET}"
}

log_step() {
  echo -e "${CYAN}[$(timestamp)] [STEP] 🧩 $*${RESET}"
}

log_done() {
  echo -e "${GREEN}[$(timestamp)] [DONE] 🎉 $*${RESET}"
}
