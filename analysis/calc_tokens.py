#!/usr/bin/env python3
import sys
import os
import collections
import tiktoken

def calculate_compressibility(file_path):
    if not os.path.exists(file_path):
        print(f"Error: File '{file_path}' not found.")
        return

    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading file: {e}")
        return

    # Use o200k_base (OpenAI GPT-4o tokenizer)
    enc = tiktoken.get_encoding("o200k_base")
    
    tokens = enc.encode(content)
    num_tokens = len(tokens)
    num_chars = len(content)
    tokens_per_char = num_tokens / num_chars if num_chars > 0 else 0
    
    print("-" * 40)
    print(f"Analysis for: {file_path}")
    print("-" * 40)
    print(f"Total Characters: {num_chars}")
    print(f"Total Tokens:     {num_tokens}")
    print(f"Tokens/Char:      {tokens_per_char:.4f}")
    print("-" * 40)
    
    # Show top 10 tokens for context
    token_counter = collections.Counter()
    for t in tokens:
        text = enc.decode([t])
        text = text.replace('\n', '↵').replace('\r', '↵')
        token_counter[text] += 1
    
    print("Top 10 Tokens:")
    for i, (tok, count) in enumerate(token_counter.most_common(10), 1):
        print(f"  {i}. '{tok}' ({count}x)")
    print("-" * 40)
    
    # Interpretation
    if tokens_per_char < 0.28:
        rating = "Excellent (Highly efficient)"
    elif tokens_per_char < 0.32:
        rating = "Good (Typical for structured code)"
    elif tokens_per_char < 0.36:
        rating = "Average"
    else:
        rating = "Poor (Fragmented tokenization)"
    
    print(f"Efficiency Rating: {rating}")
    print("-" * 40)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python calc_tokens.py <file_path>")
    else:
        calculate_compressibility(sys.argv[1])
