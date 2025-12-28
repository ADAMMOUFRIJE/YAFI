
import requests
import json
import sys

# Configuration
BASE_URL = "http://localhost:5000/chat"

def test_query(message, expected_keywords, test_name):
    print(f"[{test_name}] '{message}'")
    try:
        response = requests.post(BASE_URL, json={"message": message})
        if response.status_code == 200:
            data = response.json()
            reply = data.get("response", "")
            
            # Check keywords
            missing = [k for k in expected_keywords if k.lower() not in reply.lower()]
            
            if not missing:
                print(f"Status: ✅ OK")
            else:
                print(f"Status: ❌ FAILED (Missing keywords: {missing})")
                print(f"Response: {reply[:100]}...")
        else:
            print(f"Status: ❌ HTTP ERROR {response.status_code}")
    except Exception as e:
        print(f"Status: ❌ EXCEPTION {e}")
    print("-" * 40)

def run_tests():
    print("====================================")
    print("TEST LOGIQUE - FINANCEMENT & TYPES")
    print("====================================")

    # 1. Financement (Nouveau)
    test_query("comment avoir une bourse", ["financement", "minhaty"], "Financement - Bourse")
    test_query("financement études étranger", ["international", "erasmus", "étranger"], "Financement - Etranger")
    
    # 2. Stratégie Types (Correction info_type)
    test_query("avantage école publique", ["gratuit", "large choix", "accessible"], "Stratégie - Public Ouvert")
    test_query("inconvénient privé", ["coût élevé", "reconnaissance"], "Stratégie - Privé")

    # 3. Fallback Vague (Déplacé)
    test_query("aide", ["orientation", "écoles", "conseils"], "Fallback - Aide")
    
    # 4. Priorité Financement sur Aide
    test_query("aide pour bourse", ["financement", "minhaty"], "Priorité - Aide Bourse")
    
    # 5. Gibberish (Fallback)
    test_query("xxx", ["pas compris", "trop court"], "Fallback - Gibberish")

if __name__ == "__main__":
    run_tests()
