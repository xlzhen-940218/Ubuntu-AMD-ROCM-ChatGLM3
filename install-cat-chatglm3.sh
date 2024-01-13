#!/bin/bash 
echo "update system..."
sudo apt update -y && sudo apt upgrade -y
echo "install python3-dev build-essential git"
sudo apt install python3-dev build-essential git -y
echo "git clone cat-chatglm3"
git clone https://github.com/pofice/cat_demo-for-ChatGLM3.git
cd cat_demo-for-ChatGLM3
VENV_DIR="venv"
if [ -d "$VENV_DIR" ]; then
  echo "activate python virtual machine"
else
  echo "${VENV_DIR} not found. create python virtual machine"
  python -m venv venv
fi

echo "source venv/bin/activate && pip list"
source venv/bin/activate && pip list
echo "pip install rocm"
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm5.6
echo "pip install -r requirements.txt"
pip install -r requirements.txt
echo "pip install streamlit accelerate"
pip install streamlit accelerate
echo "pip list"
pip list
MODEL_DIR="THUDM"
if [ -d "$MODEL_DIR" ]; then
  echo "${MODEL_DIR} Model dir exist,skip,if failed,please manual download model <git clone https://huggingface.co/THUDM/chatglm3-6b>"
else
  echo "${MODEL_DIR} not found. ready download model"
  echo "download model git clone https://huggingface.co/THUDM/chatglm3-6b"
  mkdir THUDM && cd THUDM && git clone https://huggingface.co/THUDM/chatglm3-6b && cd ..
fi

echo "start..."
HSA_OVERRIDE_GFX_VERSION=10.3.0 streamlit run main.py

