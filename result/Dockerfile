# Imagen base oficial de Node.js
FROM node:20-slim

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /opt/roxs_voting_app/result

# Copiar package.json y package-lock.json primero (para cache eficiente)
COPY result/package*.json ./

# Instalar dependencias de producción solamente
RUN npm install --only=production

# Copiar el resto de los archivos fuente de la app result
#COPY . ./
COPY result/ ./

# Exponer el puerto de la aplicación (3010 por defecto)
EXPOSE 3010

# Comando por defecto para iniciar la app
CMD ["node", "main.js"]