#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script to clean null bytes from knowledge.pl file
"""

import os

def clean_knowledge_file():
    input_file = 'backend/knowledge.pl'
    output_file = 'backend/knowledge_clean.pl'
    backup_file = 'backend/knowledge_backup.pl'
    
    print(f"Reading {input_file}...")
    with open(input_file, 'rb') as f:
        content = f.read()
    
    print(f"Original size: {len(content)} bytes")
    print(f"Null bytes found: {content.count(b'\\x00')}")
    
    # Remove null bytes
    clean_content = content.replace(b'\x00', b'')
    
    print(f"Cleaned size: {len(clean_content)} bytes")
    print(f"Bytes removed: {len(content) - len(clean_content)}")
    
    # Create backup
    print(f"Creating backup at {backup_file}...")
    with open(backup_file, 'wb') as f:
        f.write(content)
    
    # Write cleaned version
    print(f"Writing cleaned version to {output_file}...")
    with open(output_file, 'wb') as f:
        f.write(clean_content)
    
    print("✓ Done! Cleaned file saved.")
    print(f"\nNext steps:")
    print(f"1. Review {output_file}")
    print(f"2. If OK, replace original: mv {output_file} {input_file}")
    
    return True

if __name__ == '__main__':
    clean_knowledge_file()
