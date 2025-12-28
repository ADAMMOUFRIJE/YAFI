import urllib.request
import json

url = "http://localhost:5000/chat"

tests = [
    "quel est ton roll",
    "qui est adam moufrije",
    "qui a cree ce ai",
    "tu est un ai",
    "arret de repeter la meme reponse",
    "merci beaucoup",
    "c'est quoi ton role"
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
