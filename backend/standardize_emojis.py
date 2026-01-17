#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script pour standardiser les emojis dans knowledge.pl et server.py
Garde uniquement les emojis universels et stables
"""

import re

# Mapping des emojis à remplacer
EMOJI_REPLACEMENTS = {
    # Emojis complexes à simplifier
    '🌟': '✅',  # Étoile → Check (positif)
    '🔥': '⚠️',  # Feu → Warning
    '💪': '✅',  # Muscle → Check (positif)
    '😊': '',    # Sourire → Supprimer
    '😅': '',    # Sourire gêné → Supprimer
    '😔': '⚠️',  # Triste → Warning
    '🤖': '',    # Robot → Supprimer (redondant)
    '🚀': '✅',  # Fusée → Check (succès)
    '🎯': '💡',  # Cible → Conseil
    '📊': '📍',  # Graphique → Localisation (stats)
    '🏫': '🎓',  # École → Graduation
    '💎': '✅',  # Diamant → Check (premium)
    '🏛️': '🎓',  # Monument → Graduation (public)
    '💰': '⚠️',  # Argent → Warning (coût)
    '📝': '💡',  # Note → Conseil
    '📅': '📍',  # Calendrier → Localisation (date)
    '🗓️': '📍',  # Calendrier → Localisation
    '🩺': '🎓',  # Stéthoscope → Graduation (médecine)
    '🧮': '💡',  # Calculatrice → Conseil
    '🧠': '💡',  # Cerveau → Conseil
    '👨‍💻': '',  # Développeur → Supprimer
    '👋': '',    # Main → Supprimer
    '🎓': '🎓',  # Graduation → Garder
    '✅': '✅',  # Check → Garder
    '❌': '❌',  # Croix → Garder
    '⚠️': '⚠️',  # Warning → Garder
    '💡': '💡',  # Ampoule → Garder
    '📍': '📍',  # Pin → Garder
    '🔗': '🔗',  # Lien → Garder
}

def clean_emojis(text):
    """Remplace les emojis complexes par des emojis standards"""
    for old, new in EMOJI_REPLACEMENTS.items():
        if new:
            text = text.replace(old, new)
        else:
            text = text.replace(old, '')
    
    # Nettoyer les espaces multiples créés par la suppression
    text = re.sub(r'\s+', ' ', text)
    text = re.sub(r'\s+([.,!?])', r'\1', text)
    
    return text

def process_file(filepath):
    """Traite un fichier pour standardiser les emojis"""
    print(f"Traitement de {filepath}...")
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_size = len(content)
        cleaned = clean_emojis(content)
        new_size = len(cleaned)
        
        if original_size != new_size:
            # Créer un backup
            backup_path = filepath + '.emoji_backup'
            with open(backup_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"  Backup créé: {backup_path}")
            
            # Écrire le fichier nettoyé
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(cleaned)
            
            print(f"  ✅ Nettoyé: {original_size} → {new_size} bytes")
            print(f"  Différence: {original_size - new_size} bytes supprimés")
        else:
            print(f"  ℹ️ Aucun changement nécessaire")
            
        return True
    except Exception as e:
        print(f"  ❌ Erreur: {e}")
        return False

if __name__ == '__main__':
    files = [
        'backend/knowledge.pl',
        'backend/server.py'
    ]
    
    print("🔧 Standardisation des emojis...")
    print("=" * 50)
    
    for filepath in files:
        process_file(filepath)
        print()
    
    print("=" * 50)
    print("✅ Terminé !")
    print("\nEmojis conservés:")
    print("  ✅ Check/Positif")
    print("  ❌ Croix/Négatif")
    print("  ⚠️ Warning/Attention")
    print("  💡 Conseil/Astuce")
    print("  🎓 Formation/Études")
    print("  📍 Localisation/Info")
    print("  🔗 Lien")
