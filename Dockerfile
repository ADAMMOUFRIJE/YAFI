# Utiliser une image Python officielle légère (Debian-based pour SWI-Prolog)
FROM python:3.9-slim

# 1. Installer SWI-Prolog
RUN apt-get update && apt-get install -y \
    swi-prolog \
    && rm -rf /var/lib/apt/lists/*

# 2. Configurer le répertoire de travail
WORKDIR /app

# 3. Copier les dépendances et installer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copier tout le code (Backend + Root files)
COPY . .

# 5. Exposer le port (Render/Heroku utilisent la variable PORT, ici 5000 par défaut)
EXPOSE 5000

# 6. Commande de démarrage (Utilise gunicorn pour la prod)
# S'assure que l'on lance depuis la racine pour que 'backend/knowledge.pl' soit trouvé
CMD ["gunicorn", "-w", "1", "-b", "0.0.0.0:5000", "backend.server:app"]
