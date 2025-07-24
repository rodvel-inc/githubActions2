#!/bin/bash
source ./emoji-logger.sh

log_info "Iniciando despliegue"
log_task "Creando carpeta del proyecto"
log_step "Clonando repositorio Git"
log_warning "Esto podría tardar algunos minutos"
log_error "No se pudo establecer conexión con el servidor"
log_success "Compilación finalizada exitosamente"
log_done "🚀 Proyecto listo para producción"
