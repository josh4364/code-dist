# Programming Language Character & LLM Token Distribution Analysis

This project provides a comprehensive analysis of 40+ programming languages, focusing on symbol distribution, language similarity, and LLM tokenization efficiency using modern tokenizers (GPT-4o).

## 📊 Key Visualizations

### LLM Token Compressibility (GPT-4o)
This chart ranks languages by **Tokens per Character**. A lower ratio indicates the language is more "efficient" for an LLM to process (i.e., it can fit more logic into its context window).

![Token Compressibility](analysis/token_compressibility.png)

### Language Similarity Matrix
A heatmap based on the distribution of punctuation and symbols. Higher intensity indicates languages that "look" similar in terms of character usage.

![Language Similarity](analysis/language_similarity_heatmap.png)

### Symbol Proximity Heatmap
Visualizes the probability of one symbol following another (e.g., how often `)` follows `(`).

![Symbol Proximity](analysis/symbol_proximity_heatmap.png)

### Global Symbol Frequency
The most common symbols found across the entire dataset of 40+ languages.

![Symbol Frequency](analysis/symbol_frequency.png)

## 📄 Detailed Reports

- [**Symbol Distribution Summary**](analysis/analysis_summary.md): Detailed breakdown of symbol ranks and language-to-language similarity percentages.
- [**LLM Tokenization Summary**](analysis/token_analysis_summary.md): Full rankings of language efficiency and the most frequent LLM tokens.

## 🛠 Tools & Usage

All analysis tools are located in the `analysis/` folder and are designed to run within a **Nix shell** for reproducibility.

### Refresh All Data
To rerun all analyses and refresh all graphs/reports after making changes to the source files:
```bash
./analysis/run.sh
```

### Real-time Syntax Testing
If you are tweaking a language syntax (like the included prototype `lumina.lumina`), you can use the standalone utility to get instant feedback on its LLM compressibility:
```bash
nix-shell -p python311Packages.tiktoken --run "analysis/calc_tokens.py <path_to_file>"
```

## 📂 Project Structure

- `analysis/`: Contains Python scripts, PNG visualizations, and Markdown reports.
- `*.ext`: Sample source files for over 40 different programming languages used as the dataset.
- `lumina.lumina`: An experimental prototype language included in the efficiency analysis.

---
*Created by Gemini CLI*
