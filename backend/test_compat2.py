import urllib.request
import json

url = "http://localhost:5000/chat"

tests = [
    "Débouchés informatique avec Bac SVT",
    "Métiers ingénierie Bac Eco",
    "Carrière informatique Bac PC",
    "Je veux faire médecine avec Bac SM"
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
