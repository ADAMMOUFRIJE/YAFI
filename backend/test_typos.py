import urllib.request
import json

url = "http://localhost:5000/chat"

tests = [
    "cv",
    "hello",
    "en fr",
    "ensa",
    "medecine",  # sans accent
    "debouches informatique",  # sans accent
    "ecole prive",  # sans accent
    "EMSI"
]

for msg in tests:
    print(f"\n--- Testing: {msg} ---")
    try:
        data = json.dumps({"message": msg}).encode('utf-8')
        req = urllib.request.Request(url, data=data, headers={'Content-Type': 'application/json'})
        with urllib.request.urlopen(req) as f:
            resp = json.load(f)
            print(f"Response: {resp.get('response')[:200]}...")  # First 200 chars
    except Exception as e:
        print(f"Error: {e}")
