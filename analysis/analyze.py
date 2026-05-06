import os
import collections
import string
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity

# Define symbols to track (punctuation)
SYMBOLS = string.punctuation

def analyze_files():
    root_dir = '..'
    files = [f for f in os.listdir(root_dir) 
             if os.path.isfile(os.path.join(root_dir, f)) 
             and f not in ['prompt.md', 'tasks and languages.md']
             and not f.startswith('.')]
    
    print(f"Analyzing {len(files)} files...")
    
    all_symbol_counts = collections.Counter()
    co_occurrence = collections.defaultdict(collections.Counter)
    lang_symbol_counts = {}

    for file in files:
        lang = file
        lang_counts = collections.Counter()
        try:
            with open(os.path.join(root_dir, file), 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                symbols_in_file = [c for c in content if c in SYMBOLS]
                all_symbol_counts.update(symbols_in_file)
                lang_counts.update(symbols_in_file)
                
                for i in range(len(symbols_in_file) - 1):
                    co_occurrence[symbols_in_file[i]][symbols_in_file[i+1]] += 1
        except Exception as e:
            print(f"Error reading {file}: {e}")
            continue
        
        lang_symbol_counts[lang] = lang_counts

    return all_symbol_counts, co_occurrence, lang_symbol_counts

def plot_frequency(counts):
    df = pd.DataFrame(counts.most_common(30), columns=['Symbol', 'Frequency'])
    plt.figure(figsize=(14, 7))
    sns.barplot(x='Symbol', y='Frequency', data=df, palette='viridis')
    plt.title('Top 30 Symbol Frequencies Across All Files')
    plt.grid(axis='y', linestyle='--', alpha=0.7)
    plt.tight_layout()
    plt.savefig('symbol_frequency.png')
    plt.close()

def plot_cumulative_frequency(counts):
    sorted_counts = sorted(counts.values(), reverse=True)
    cumulative = np.cumsum(sorted_counts) / sum(sorted_counts)
    
    plt.figure(figsize=(10, 6))
    plt.plot(range(1, len(cumulative) + 1), cumulative, marker='o', color='red')
    plt.title('Cumulative Symbol Distribution')
    plt.xlabel('Number of Symbols (Ranked)')
    plt.ylabel('Cumulative Proportion of Total Symbol Usage')
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig('cumulative_distribution.png')
    plt.close()

def plot_proximity_heatmap(co_occurrence):
    symbol_totals = collections.Counter()
    for s1, neighbors in co_occurrence.items():
        symbol_totals[s1] += sum(neighbors.values())
        
    top_symbols = [s for s, count in symbol_totals.most_common(25)]
    matrix = [[co_occurrence[s1][s2] for s2 in top_symbols] for s1 in top_symbols]
    
    df = pd.DataFrame(matrix, index=top_symbols, columns=top_symbols)
    df_norm = df.div(df.sum(axis=1), axis=0).fillna(0)
    
    plt.figure(figsize=(14, 12))
    sns.heatmap(df_norm, annot=False, cmap='YlGnBu')
    plt.title('Symbol Proximity Heatmap (Probability of S2 following S1)')
    plt.xlabel('Following Symbol (S2)')
    plt.ylabel('Initial Symbol (S1)')
    plt.tight_layout()
    plt.savefig('symbol_proximity_heatmap.png')
    plt.close()

def calculate_similarity(lang_counts):
    all_langs = sorted(lang_counts.keys())
    # Create a vector for each language using all detected symbols
    all_detected_symbols = sorted(list(SYMBOLS))
    
    vectors = []
    for lang in all_langs:
        counts = lang_counts[lang]
        total = sum(counts.values()) or 1
        vec = [counts[sym] / total for sym in all_detected_symbols]
        vectors.append(vec)
    
    sim_matrix = cosine_similarity(vectors)
    sim_df = pd.DataFrame(sim_matrix, index=all_langs, columns=all_langs)
    
    # Plot Similarity Heatmap
    plt.figure(figsize=(16, 14))
    sns.heatmap(sim_df, cmap='magma', xticklabels=True, yticklabels=True)
    plt.title('Language Similarity Matrix (based on symbol distribution)')
    plt.tight_layout()
    plt.savefig('language_similarity_heatmap.png')
    plt.close()
    
    return sim_df

def generate_reports(counts, lang_counts, sim_df):
    with open('analysis_summary.md', 'w') as f:
        f.write("# Advanced Symbol Distribution & Language Similarity\n\n")
        
        f.write("## Top 15 Aggregated Symbols\n\n")
        f.write("| Rank | Symbol | Frequency | % Total |\n")
        f.write("|------|--------|-----------|---------|\n")
        total_syms = sum(counts.values())
        for i, (sym, count) in enumerate(counts.most_common(15), 1):
            pct = (count / total_syms) * 100
            f.write(f"| {i} | `{sym}` | {count} | {pct:.2f}% |\n")
            
        f.write("\n## Language Similarity Report (Top 3 matches per language)\n\n")
        f.write("This table shows which languages are most similar in their use of punctuation and symbols.\n\n")
        f.write("| Language | #1 Closest | #2 Closest | #3 Closest |\n")
        f.write("|----------|------------|------------|------------|\n")
        
        for lang in sim_df.index:
            # Get similarities for this lang, excluding itself
            row = sim_df.loc[lang].drop(lang).sort_values(ascending=False)
            top3 = []
            for other_lang, score in row.head(3).items():
                top3.append(f"{other_lang} ({score*100:.1f}%)")
            
            f.write(f"| {lang} | {' | '.join(top3)} |\n")

if __name__ == "__main__":
    counts, co_occ, lang_counts = analyze_files()
    plot_frequency(counts)
    plot_cumulative_frequency(counts)
    plot_proximity_heatmap(co_occ)
    sim_df = calculate_similarity(lang_counts)
    generate_reports(counts, lang_counts, sim_df)
    print("Analysis complete. Check 'analysis/' folder for results.")
