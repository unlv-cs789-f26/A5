# CS 789 — Assignment 5: GraphRAG vs. LightRAG vs. Vector RAG — and Neo4j

**UNLV · AI-Powered Cyber Attacks and Defenses · Fall 2026 · Prof. Yoohwan Kim**

The same Vandelay Industries corpus and the same 26 questions as A4, so your A4 numbers are the baseline.
This time the retriever is a **knowledge graph** that an LLM extracts from the text:

* **Part A** — index with **Microsoft GraphRAG**; open its entities, relationships, communities and community
  reports; visualize the graph; audit two reports; try local / global / DRIFT / basic search.
* **Part B** — index with **LightRAG**; compare the two graphs; its query modes; add a new incident to both.
* **Part C** — load the graph into **Neo4j**; write Cypher by hand; let **LangChain** write Cypher for you.
* **Part D** — the scoreboard: 26 questions × 9 pipelines, by question type, plus cost.

The handout is `CS 789 A5.docx` / `.pdf` on WebCampus. This README is the "how do I start" sheet.

## Start on Google Colab (recommended)

1. Open **https://colab.research.google.com/github/unlv-cs789-f26/A5/blob/main/A5_GraphRAG.ipynb**
   (or in Colab: *File → Open notebook → GitHub* → `unlv-cs789-f26/A5`).
2. *Runtime → Change runtime type →* **L4 GPU** → *Save*. (A100 is faster for indexing.)
3. *File → Save a copy in Drive*.
4. Run cell 0.1. It clones this repo into `/content/A5`, installs the packages, installs vLLM into its own
   environment and starts two local model servers: the chat model (Qwen3-4B-Instruct-2507) on port 8000
   and the embedding model (bge-base-en-v1.5) on port 8001. About 6 minutes the first time.

No API keys are needed: GraphRAG, LightRAG and LangChain all talk to the local servers.

## Start on your own computer (Linux or WSL2, NVIDIA GPU ≥ 20 GB)

```bash
git clone https://github.com/unlv-cs789-f26/A5.git
cd A5
./start.sh --vllm     # makes .venv, installs packages and vLLM, checks the machine, opens Jupyter Lab
./start.sh --check    # only the environment check
```

Part C needs a Neo4j database. On Colab the notebook installs one inside the VM
(`install_neo4j_colab.sh`). On your own computer the easiest is Docker:
`docker run -d -p 7474:7474 -p 7687:7687 -e NEO4J_AUTH=neo4j/cs789-a5-local neo4j:5`,
or a free **Neo4j AuraDB** instance (console.neo4j.io) with its URI and password in environment variables.

Windows without WSL2: `start.bat` sets up a venv so you can read the notebook, but vLLM (every part) needs Linux.

## Files

| file | what it is |
|---|---|
| `A5_GraphRAG.ipynb` | the assignment notebook — 🛠️ build cells (with AI prompts), measure cells, ✍️ questions |
| `cs789rag.py` | the fixed harness (same as A4) plus GraphRAG helpers. **Do not edit.** |
| `graphrag_settings.yaml` | GraphRAG settings template pointing at the local vLLM servers |
| `corpus/`, `questions.yaml` | the A4 corpus and questions |
| `new_ticket_inc_2026_049.md` | the new incident you add to both graphs in Part B |
| `install_vllm.sh`, `install_neo4j_colab.sh` | installers used by the notebook |
| `PROMPTS.md` | how to use Claude in Chrome / Gemini in Chrome / Gemini in Colab, and prompt patterns |
| `start.sh` / `start.bat` / `check_environment.py` | local start-up and checks |

Results you measure are appended to `results/results.jsonl`.

## Submission

One PDF on WebCampus: the filled-in handout followed by this notebook printed with its outputs
(*File → Print → Save as PDF*).
