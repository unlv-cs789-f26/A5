"""CS 789 A5 environment check: python check_environment.py"""
import importlib, shutil, sys
from pathlib import Path

ok = True
def line(name, good, detail=""):
    global ok
    ok &= bool(good)
    print(f"  [{'OK' if good else '!!'}] {name:28s} {detail}")

print("CS 789 A5 environment check")
line("python >= 3.10", sys.version_info >= (3, 10), sys.version.split()[0])
for mod in ["graphrag", "lightrag", "neo4j", "langchain_neo4j", "langchain_openai", "networkx", "pyvis",
            "rank_bm25", "yaml", "pandas", "matplotlib"]:
    try:
        m = importlib.import_module(mod)
        line(mod, True, getattr(m, "__version__", ""))
    except Exception as e:
        line(mod, False, f"missing ({e.__class__.__name__}) -> pip install -r requirements.txt")
gpu = shutil.which("nvidia-smi")
line("NVIDIA GPU", gpu, "found" if gpu else "none: A5 needs a GPU for vLLM -> use Colab")
here = Path(__file__).parent
line("corpus/ (35 docs)", len(list((here / "corpus").glob("*.md"))) == 35)
line("questions.yaml", (here / "questions.yaml").exists())
line("graphrag_settings.yaml", (here / "graphrag_settings.yaml").exists())
venv = Path("/content/vllm-env") if Path("/content").is_dir() else here / "vllm-env"
line("vLLM env", (venv / "bin" / "vllm").exists(), str(venv) + ("" if (venv / "bin" / "vllm").exists() else "  -> bash install_vllm.sh"))
print("ALL GOOD" if ok else "Fix the [!!] lines above.")
