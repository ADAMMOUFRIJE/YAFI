
import os

def fix_encoding():
    path = 'backend/knowledge.pl'
    print(f"Fixing encoding for {path}...")
    
    try:
        # Read as bytes
        with open(path, 'rb') as f:
            raw = f.read()
            
        # Try to decode as utf-8, ignore errors to strip bad bytes
        content = raw.decode('utf-8', errors='ignore')
        
        # Write back as clean utf-8
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
            
        print("Done.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == '__main__':
    fix_encoding()
