import urllib.request
import json

url = "http://localhost:5000/chat"

tests = [
    "Je suis en Bac SVT et je veux faire de l'informatique",
    "Bac PC informatique",
    "Bac SM médecine",
    "Bac Eco ingénierie",
    "Bac Littéraire informatique",
    "Bac SVT médecine"
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
