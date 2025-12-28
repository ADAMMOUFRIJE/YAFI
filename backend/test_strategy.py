import urllib.request
import json

url = "http://localhost:5000/chat"

tests = [
    "Stratégie avec 16 en Bac SM",
    "Stratégie avec 10.5 en Bac SVT",
    "Avantage Public Ouvert",
    "Inconvénient Privé",
    "C'est quoi Public Régulé",
]

for msg in tests:
    print(f"\n--- Testing: {msg} ---")
    try:
        data = json.dumps({"message": msg}).encode('utf-8')
        req = urllib.request.Request(url, data=data, headers={'Content-Type': 'application/json'})
        with urllib.request.urlopen(req) as f:
            resp = json.load(f)
            print(f"Response: {resp.get('response')}")
    except Exception as e:
        print(f"Error: {e}")
