"""
Script de test exhaustif du chatbot PFE
"""
import requests
import json
import time

BASE_URL = "http://localhost:5000/chat"

def test_question(question, category):
    try:
        response = requests.post(BASE_URL, json={"message": question}, timeout=10)
        result = response.json().get("response", "NO RESPONSE")
        
        # Check for problems
        has_error = "Erreur" in result or "error" in result.lower()
        has_mojibake = "Ã" in result or "â" in result
        is_default = "Je n'ai pas compris" in result
        
        status = "❌ ERROR" if has_error else ("⚠️ MOJIBAKE" if has_mojibake else ("⚠️ DEFAULT" if is_default else "✅ OK"))
        
        print(f"\n[{category}] {question}")
        print(f"Status: {status}")
        print(f"Response: {result[:200]}..." if len(result) > 200 else f"Response: {result}")
        
        return {"question": question, "category": category, "status": status, "has_error": has_error, "has_mojibake": has_mojibake, "is_default": is_default}
    except Exception as e:
        print(f"\n[{category}] {question}")
        print(f"Status: ❌ EXCEPTION: {e}")
        return {"question": question, "category": category, "status": "EXCEPTION", "has_error": True}

# Test cases
tests = [
    # Salutations
    ("bonjour", "Salutations"),
    ("salut", "Salutations"),
    ("salam", "Salutations"),
    ("hello", "Salutations"),
    ("hey", "Salutations"),
    
    # Orientation par Bac
    ("que faire avec un bac pc", "Orientation BAC"),
    ("bac svt options", "Orientation BAC"),
    ("bac sm", "Orientation BAC"),
    ("bac eco", "Orientation BAC"),
    ("bac litteraire", "Orientation BAC"),
    
    # Compatibilité BAC-Filière
    ("bac svt informatique possible", "Compatibilité"),
    ("bac eco ingenierie possible", "Compatibilité"),
    ("bac pc medecine", "Compatibilité"),
    ("bac litt informatique", "Compatibilité"),
    
    # Médecine
    ("medecine avec 14", "Médecine"),
    ("bac svt 12 medecine", "Médecine"),
    ("conseil medecine", "Médecine"),
    
    # Écoles privées
    ("prix emsi", "Écoles Privées"),
    ("frais uir", "Écoles Privées"),
    ("hem frais", "Écoles Privées"),
    
    # Écoles publiques
    ("frais ensa", "Écoles Publiques"),
    ("ensa gratuit", "Écoles Publiques"),
    
    # Localisation
    ("où est ensias", "Localisation"),
    ("ecoles a rabat", "Localisation"),
    ("ensa safi", "Localisation"),
    
    # Définitions
    ("c'est quoi lmd", "Définitions"),
    ("cpge", "Définitions"),
    ("bts dut difference", "Définitions"),
    
    # Conseils
    ("conseils revision", "Conseils"),
    ("methode travail", "Conseils"),
    ("pomodoro", "Conseils"),
    
    # Durée études
    ("etudes courtes ou longues", "Durée Études"),
    ("bts ou master", "Durée Études"),
    
    # Concours
    ("concours medecine", "Concours"),
    ("admission ensa", "Concours"),
    
    # Stages
    ("stages informatique", "Stages"),
    ("pfe ingenierie", "Stages"),
    
    # Meta-questions
    ("qui t'a cree", "Meta"),
    ("c'est quoi ton role", "Meta"),
    ("tu es un robot", "Meta"),
    
    # Remerciements/Feedback
    ("merci beaucoup", "Feedback"),
    ("nul", "Feedback"),
    
    # Messages vagues
    ("aide moi", "Vague"),
    ("je suis perdu", "Vague"),
    ("xxx", "Vague"),
]

print("=" * 60)
print("TEST EXHAUSTIF DU CHATBOT PFE")
print("=" * 60)

results = []
for question, category in tests:
    result = test_question(question, category)
    results.append(result)
    time.sleep(0.3)  # Avoid overwhelming the server

# Summary
print("\n" + "=" * 60)
print("RÉSUMÉ DES TESTS")
print("=" * 60)

errors = [r for r in results if r.get("has_error")]
mojibake = [r for r in results if r.get("has_mojibake") and not r.get("has_error")]
defaults = [r for r in results if r.get("is_default") and not r.get("has_error")]
passed = [r for r in results if not r.get("has_error") and not r.get("has_mojibake") and not r.get("is_default")]

print(f"\n✅ PASSED: {len(passed)}/{len(results)}")
print(f"❌ ERRORS: {len(errors)}")
print(f"⚠️ MOJIBAKE: {len(mojibake)}")
print(f"⚠️ DEFAULT RESPONSE: {len(defaults)}")

if errors:
    print("\n❌ Questions avec ERREURS:")
    for e in errors:
        print(f"  - [{e['category']}] {e['question']}")

if defaults:
    print("\n⚠️ Questions avec RÉPONSE PAR DÉFAUT:")
    for d in defaults:
        print(f"  - [{d['category']}] {d['question']}")
