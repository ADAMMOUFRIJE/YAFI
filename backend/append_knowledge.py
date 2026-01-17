
import os

def append_kb():
    v2_path = 'backend/knowledge_v2.pl'
    kb_path = 'backend/knowledge.pl'
    
    if not os.path.exists(v2_path):
        print(f"Error: {v2_path} not found.")
        return

    try:
        print("Reading V2 content...")
        with open(v2_path, 'r', encoding='utf-8') as f:
            new_content = f.read()
            
        print(f"Appending to {kb_path}...")
        with open(kb_path, 'a', encoding='utf-8') as f:
            f.write("\n\n% =======================================================\n")
            f.write("% BASE DE CONNAISSANCES V2 (APPENDED)\n")
            f.write("% =======================================================\n\n")
            f.write(new_content)
            
        print("✓ Success! Knowledge base updated.")
    except Exception as e:
        print(f"Error appending knowledge: {e}")

if __name__ == '__main__':
    append_kb()
