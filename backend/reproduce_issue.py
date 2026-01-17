import requests
import json

def test_chat(message):
    url = "http://127.0.0.1:5000/chat"
    try:
        response = requests.post(url, json={"message": message})
        if response.status_code == 200:
            print(f"Input: '{message}'")
            print(f"Response: {response.json()['response']}")
            print("-" * 50)
            return True
        else:
            print(f"Error: Status code {response.status_code}")
            return False
    except Exception as e:
        print(f"Connection error: {e}")
        return False

if __name__ == "__main__":
    print("Testing optimizations...\n")

    test_cases = [
        "15 en bac",
        "Calcul 14 16",
        "J'ai eu 12.5 de moyenne",
        "C'est quoi l'OFPPT?",
        "Comment préparer le concours de médecine ?",
        "Que faire avec un Bac Arts Appliqués?"
    ]

    for msg in test_cases:
        test_chat(msg)
