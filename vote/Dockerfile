FROM python:3.11-slim

# Variables de entorno para evitar problemas con buffering
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Crear directorios
RUN mkdir -p /opt/roxs_voting_app/vote /tmp/prometheus-multiproc
WORKDIR /opt/roxs_voting_app/vote

# Copiar archivos de la app
COPY . /opt/roxs_voting_app/vote

# Crear entorno virtual
RUN python3 -m venv .venv

# Actualizar pip en el entorno virtual
RUN .venv/bin/pip install --upgrade pip

# Instalar dependencias
RUN .venv/bin/pip install -r requirements.txt

# Instalar curl para healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Crear archivos de log si se necesitan (vacíos inicialmente)
RUN mkdir -p /opt/roxs_voting_app/logs
RUN touch /opt/roxs_voting_app/logs/vote.log && \
    chmod 644 /opt/roxs_voting_app/logs/vote.log

# Exponer puerto Flask
EXPOSE 8080

# Entrypoint
CMD [".venv/bin/flask", "run", "--host=0.0.0.0", "--port=80", "--no-reload"]

