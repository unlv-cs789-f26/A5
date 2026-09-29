@echo off
REM CS 789 A5 - Windows start script.
REM A5 needs vLLM (Linux only) for every part: use Google Colab (recommended) or WSL2 and run ./start.sh --vllm there.
REM This script only prepares a Windows venv so you can read and edit the notebook locally.
cd /d "%~dp0"
if not exist .venv python -m venv .venv
call .venv\Scripts\activate.bat
python -m pip -q install --upgrade pip
python -m pip -q install -r requirements.txt jupyterlab ipykernel matplotlib pandas
python check_environment.py
jupyter lab A5_GraphRAG.ipynb
