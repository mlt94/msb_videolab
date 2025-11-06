#!/bin/bash
# Environment setup script for MSB VideoLab Transcripts project (Mac/Linux)
# Uses Python 3.11.9 to match the original environment

echo "============================================================"
echo "MSB VideoLab Transcripts - Environment Setup (Python 3.11)"
echo "============================================================"

# Check if Python 3.11 is available
if ! command -v python3.11 &> /dev/null; then
    echo "ERROR: Python 3.11 is not available!"
    echo "Please install Python 3.11.x from https://python.org"
    echo "On macOS with Homebrew: brew install python@3.11"
    echo "On Ubuntu/Debian: sudo apt install python3.11 python3.11-venv"
    exit 1
fi

echo "Found: $(python3.11 --version)"

# Create virtual environment with Python 3.11
echo ""
echo "Creating virtual environment 'msb_transcribe' with Python 3.11..."
python3.11 -m venv msb_transcribe

# Activate the virtual environment
echo "Activating virtual environment 'msb_transcribe'..."
source msb_transcribe/bin/activate

# Upgrade pip
echo ""
echo "Upgrading pip..."
python -m pip install --upgrade pip

# Install PyTorch with CUDA support first
echo ""
echo "Installing PyTorch with CUDA 12.1 support..."
pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu121

# Install remaining packages
echo ""
echo "Installing remaining packages from requirements.txt..."
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "ERROR: requirements.txt not found!"
    exit 1
fi

# Verify installation
echo ""
echo "============================================================"
echo "Verifying installation..."
echo "============================================================"
python -c "import sys; print(f'Python: {sys.version}')"
python -c "import torch; print(f'PyTorch: {torch.__version__}')"
python -c "import torch; print(f'CUDA Available: {torch.cuda.is_available()}')"

echo ""
echo "============================================================"
echo "Environment setup completed successfully!"
echo "============================================================"
echo ""
echo "To activate this environment in the future, run:"
echo "  source msb_transcribe/bin/activate"
echo ""
echo "Your environment now contains:"
echo "- PyTorch 2.5.1 with CUDA 12.1 support"
echo "- All packages from your original requirements.txt"
echo "- Python 3.11.9 (matching original environment)"
echo ""