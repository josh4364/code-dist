import os
import collections
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import tiktoken

def analyze_tokens():
    root_dir = '..'
    files = [f for f in os.listdir(root_dir) 
             if os.path.isfile(os.path.join(root_dir, f)) 
             and f not in ['prompt.md', 'tasks and languages.md']
             and not f.startswith('.')]
    
    print(f"Tokenizing {len(files)} files...")
    
    # Use o200k_base (OpenAI GPT-4o tokenizer)
    enc = tiktoken.get_encoding("o200k_base")
    
    stats = []
    all_tokens_counter = collections.Counter()
    
    for file in files:
        try:
            with open(os.path.join(root_dir, file), 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                
            tokens = enc.encode(content)
            num_tokens = len(tokens)
            num_chars = len(content)
            tokens_per_char = num_tokens / num_chars if num_chars > 0 else 0
            
            stats.append({
                'Language': file,
                'Tokens': num_tokens,
                'Chars': num_chars,
                'Tokens/Char': tokens_per_char
            })
            
            # Decode tokens to their text representation for frequency analysis
            # We replace newlines with a symbol as requested
            for t in tokens:
                text = enc.decode([t])
                text = text.replace('\n', '↵').replace('\r', '↵')
                all_tokens_counter[text] += 1
                
        except Exception as e:
            print(f"Error processing {file}: {e}")
            
    df = pd.DataFrame(stats)
    return df, all_tokens_counter

def plot_compressibility(df):
    # Sort by Tokens/Char (lower is better compression/efficiency)
    df_sorted = df.sort_values('Tokens/Char')
    
    plt.figure(figsize=(14, 10))
    sns.barplot(x='Tokens/Char', y='Language', data=df_sorted, palette='mako')
    plt.title('LLM Token Efficiency by Language (Tokens per Character)\nLower is more "compressible" or efficient for the LLM')
    plt.xlabel('Tokens per Character')
    plt.grid(axis='x', linestyle='--', alpha=0.7)
    plt.tight_layout()
    plt.savefig('token_compressibility.png')
    plt.close()
    print("Saved token_compressibility.png")

def plot_sizes(df):
    # Plot 1: Total Characters
    df_chars = df.sort_values('Chars', ascending=False)
    plt.figure(figsize=(14, 10))
    sns.barplot(x='Chars', y='Language', data=df_chars, palette='viridis')
    plt.title('Total Character Count per Language Example')
    plt.xlabel('Total Characters')
    plt.grid(axis='x', linestyle='--', alpha=0.7)
    plt.tight_layout()
    plt.savefig('total_characters.png')
    plt.close()
    print("Saved total_characters.png")

    # Plot 2: Total Tokens
    df_tokens = df.sort_values('Tokens', ascending=False)
    plt.figure(figsize=(14, 10))
    sns.barplot(x='Tokens', y='Language', data=df_tokens, palette='magma')
    plt.title('Total LLM Token Count per Language Example')
    plt.xlabel('Total Tokens')
    plt.grid(axis='x', linestyle='--', alpha=0.7)
    plt.tight_layout()
    plt.savefig('total_tokens.png')
    plt.close()
    print("Saved total_tokens.png")

    # Plot 3: Combined Comparison
    # Melt the dataframe for a grouped bar plot
    df_melted = df.melt(id_vars='Language', value_vars=['Chars', 'Tokens'], 
                        var_name='Metric', value_name='Size')
    # Sort by total size (Chars) for a cleaner visual
    lang_order = df.sort_values('Chars', ascending=False)['Language'].tolist()
    
    plt.figure(figsize=(14, 12))
    sns.barplot(x='Size', y='Language', hue='Metric', data=df_melted, 
                order=lang_order, palette=['#3498db', '#e74c3c'])
    plt.title('Side-by-Side Comparison: Characters vs Tokens')
    plt.xlabel('Count')
    plt.grid(axis='x', linestyle='--', alpha=0.7)
    plt.tight_layout()
    plt.savefig('combined_size_comparison.png')
    plt.close()
    print("Saved combined_size_comparison.png")

def plot_top_tokens(counter):
    common = counter.most_common(30)
    df = pd.DataFrame(common, columns=['Token', 'Frequency'])
    
    plt.figure(figsize=(14, 8))
    sns.barplot(x='Frequency', y='Token', data=df, palette='rocket')
    plt.title('Top 30 Most Common LLM Tokens Across All Languages')
    plt.xlabel('Frequency')
    plt.grid(axis='x', linestyle='--', alpha=0.7)
    plt.tight_layout()
    plt.savefig('top_tokens.png')
    plt.close()
    print("Saved top_tokens.png")

def generate_report(df, counter):
    with open('token_analysis_summary.md', 'w') as f:
        f.write("# LLM Tokenization & Compressibility Analysis\n\n")
        f.write("Using OpenAI `o200k_base` tokenizer (GPT-4o).\n\n")
        
        f.write("## Language Efficiency Ranking\n")
        f.write("Ordered from most efficient (fewest tokens per character) to least.\n\n")
        f.write("| Rank | Language | Tokens/Char | Total Tokens | Total Chars |\n")
        f.write("|------|----------|-------------|--------------|-------------|\n")
        df_sorted = df.sort_values('Tokens/Char')
        for i, row in enumerate(df_sorted.itertuples(), 1):
            f.write(f"| {i} | `{row.Language}` | {row._4:.3f} | {row.Tokens} | {row.Chars} |\n")
            
        f.write("\n## Top 20 Most Frequent Tokens\n")
        f.write("Newlines are represented as `↵`.\n\n")
        f.write("| Rank | Token | Frequency |\n")
        f.write("|------|-------|-----------|\n")
        for i, (tok, count) in enumerate(counter.most_common(20), 1):
            # Escape backticks for markdown
            safe_tok = tok.replace('`', '\\`')
            f.write(f"| {i} | `{safe_tok}` | {count} |\n")

if __name__ == "__main__":
    df, counter = analyze_tokens()
    plot_compressibility(df)
    plot_sizes(df)
    plot_top_tokens(counter)
    generate_report(df, counter)
    print("Token analysis complete.")
