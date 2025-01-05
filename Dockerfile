# Étape 1 : Utiliser une image Node.js pour construire l'application
FROM node:18 AS builder

# Définir le répertoire de travail
WORKDIR /usr/src/app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances nécessaires
RUN npm install

# Copier tous les fichiers sources dans l'image
COPY . .

# Construire l'application en mode production
RUN npm run build

# Étape 2 : Utiliser une image plus légère pour exécuter l'application
FROM node:18-slim

# Installer uniquement les dépendances nécessaires pour exécuter l'application
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app ./

# Exposer le port 1337
EXPOSE 1337

# Démarrer l'application
CMD ["npm", "start"]
 