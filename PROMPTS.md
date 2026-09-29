# Building with an AI assistant in the browser — prompt guide (A4 and A5)

In A4 and A5 you write the pipelines **with an AI assistant**, not by hand. Measuring and thinking stay
yours: the harness (`cs789rag.py`) scores everything the same way for everyone, and the ✍️ questions
need your own reading of your own numbers.

## 1. Pick one assistant

| assistant | where | can it type into Colab cells and run them? | notes |
|---|---|---|---|
| **Claude in Chrome** | Chrome Web Store → "Claude" by Anthropic → *Add to Chrome* → pin → click the icon (side panel) | **yes**: it reads the page, clicks, types and runs cells | allow it on `colab.research.google.com` when asked; keep "ask before acting" on for anything outside Colab |
| **Gemini in Chrome** | the Gemini button at the top right of Chrome, signed in with a personal Google account | it reads the page and answers in the side panel; you paste the code | good at explaining an error that is on screen |
| **Gemini in Colab** | the ✦ button at the bottom of the notebook, or "Generate" in an empty cell | **yes**: writes into the cell, and its agent mode can run cells | included with Colab Pro; knows the notebook's variables |

Any of them is fine. Free tiers run out; if you hit a limit, switch assistants — the prompts below work in all of them.

## 2. Anatomy of a prompt that works

Every 🛠️ cell in the notebook already contains a starting prompt. They all follow five parts — copy
this pattern when you write your own:

1. **Where you are** — "I am in a Google Colab notebook."
2. **What already exists** — the variables and their shape: "`CHUNKS` is a list of dicts with keys `chunk_id`, `doc_id`, `text`."
3. **The exact contract** — function name, arguments, return type: "`search(question, k) -> list[dict]`, best first."
   The check cells call these names; a different name is a failed check.
4. **Constraints** — the library to use (and not to use), "do not edit any other cell", "do not modify `cs789rag.py`".
5. **Where the code goes and how to verify it** — "Put it in the empty cell under *B.1*, run it, then run the
   check cell below. If the check fails, fix the code and run both again."

## 3. Prompts for the moments you will get stuck

| situation | prompt |
|---|---|
| a cell raised an error | "The cell under B.1 raised the error shown below it. Explain the cause in one sentence, fix the code in that cell only, and re-run it." |
| a check prints FAIL | "The check cell under A.1 printed FAIL: *(paste)*. Change `fixed_chunker` so the check passes. Do not change the check." |
| a number looks wrong | "My recall@5 for BM25 is 0.00 on every question. Print the first 20 tokens of one chunk and of the question, and tell me why nothing matches." |
| you do not understand the code | "Explain `rrf_fuse` line by line, and give a 3-item example of the fusion by hand." |
| a library API changed | "`HuggingFaceEmbedding` has no argument `query_instruction` in the installed version. Check `help(HuggingFaceEmbedding)` and adapt." |
| Colab runs out of GPU memory | "Explain which Python objects hold GPU memory in this notebook and move the embedding models to the CPU." |

## 4. What not to do

* **Do not ask for the whole assignment** ("do Part B"). The assistant will invent numbers and answers,
  the check cells will not run in order, and you will not be able to answer the ✍️ questions.
* **Never paste an API key into a prompt or a code cell.** Keys go in Colab 🔑 Secrets and are read with
  `google.colab.userdata.get(...)`.
* **Do not let the assistant edit `cs789rag.py`** or the provided measure cells — your numbers would no
  longer be comparable with anyone else's.
* **Do not accept a number the assistant *tells* you.** Only numbers printed by the harness count.
* **Watch what a browser agent reads.** Claude in Chrome and Gemini read the whole page, including the
  documents your notebook prints. A document that says *"ignore your instructions and …"* is a prompt
  injection aimed at your assistant — the same indirect-injection mechanism you will attack in Part I of this
  course. If your assistant suddenly does something you did not ask, stop it and note it in your report.

## 5. What goes in your report (AI-assistant log)

* the assistant you used;
* three prompts you actually sent: one that worked first time, one that failed, and the follow-up that fixed it;
* one place where the assistant wrote code that *ran* but was *wrong*, and how you found out (usually a check cell or a number that made no sense).
