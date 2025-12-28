import requests
import json
import sys

BASE_URL = "http://127.0.0.1:5000/chat"

def test_query(name, message, keywords=[]):
    print(f"\n🔹 Testing: {name} ('{message}')")
    try:
        response = requests.post(BASE_URL, json={'message': message})
        if response.status_code == 200:
            data = response.json()
            reply = data.get('response', '')
            print(f"   ✅ Server replied: {reply[:100]}...")
            
            # Check keywords
            missing = [k for k in keywords if k.lower() not in reply.lower()]
            if not missing:
                print("   🎉 SUCCESS: All keywords found.")
            else:
                print(f"   ⚠️ FAILURE: Missing keywords {missing}")
                print(f"   Full Response: {reply}")
        else:
            print(f"   ❌ Error {response.status_code}: {response.text}")
    except Exception as e:
        print(f"   ❌ Exception: {e}")

def run_tests():
    print("🚀 Démarrage des tests des nouvelles fonctionnalités...")
    
    # 1. Seuils
    test_query("Seuil ENSA", "C'est quoi le seuil de l'ENSA ?", ["seuil 2023", "13.5"])
    
    # 2. Dates
    test_query("Date Médecine", "Quand est le concours médecine ?", ["date", "juillet"])
    
    # 3. Liens
    test_query("Lien Bourse", "Donne moi le lien pour la bourse Minhaty", ["minhaty.ma", "cliquez ici"])
    
    # 4. Procédures
    test_query("Procédure Fac", "Comment s'inscrire à la fac ?", ["dossier", "cin"])
    
    # 5. OFPPT
    test_query("Info OFPPT", "Je veux des infos sur technicien spécialisé ofppt", ["bac requis", "dév digital"])
    
    # 6. Logement
    test_query("Logement", "C'est quoi la cité universitaire ?", ["onouhc", "subventionné"])
    
    # 7. Calculateur
    test_query("Calculateur", "Calcul le score avec 14 au régional et 16 au national", ["15.50", "score"])
    
    # 8. Quiz
    test_query("Quiz Ingénieur", "Quiz j'aime les maths et la physique et l'info", ["ingénieur", "ensa", "cpge"])
    
    print("\n🏁 Fin des tests.")

if __name__ == "__main__":
    run_tests()
