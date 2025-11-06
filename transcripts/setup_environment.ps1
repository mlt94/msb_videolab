# PowerShell version of environment setup script
# Uses Python 3.11.9 to match the original environment

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "MSB VideoLab Transcripts - Environment Setup (Python 3.11)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

# Check if Python 3.11 is available
try {
    $python311Version = py -3.11 --version 2>$null
    Write-Host "Found: $python311Version" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Python 3.11 is not available!" -ForegroundColor Red
    Write-Host "Please install Python 3.11.x from https://python.org" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Create virtual environment with Python 3.11
Write-Host "`nCreating virtual environment 'msb_transcribe' with Python 3.11..." -ForegroundColor Yellow
py -3.11 -m venv msb_transcribe

# Activate the virtual environment
Write-Host "Activating virtual environment 'msb_transcribe'..." -ForegroundColor Yellow
& ".\msb_transcribe\Scripts\Activate.ps1"

# Upgrade pip
Write-Host "`nUpgrading pip..." -ForegroundColor Yellow
python -m pip install --upgrade pip

# Install PyTorch with CUDA support first
Write-Host "`nInstalling PyTorch with CUDA 12.1 support..." -ForegroundColor Yellow
pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu121

# Install remaining packages
Write-Host "`nInstalling remaining packages from requirements.txt..." -ForegroundColor Yellow
if (Test-Path "requirements.txt") {
    pip install -r requirements.txt
} else {
    Write-Host "ERROR: requirements.txt not found!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Verify installation
Write-Host "`n============================================================" -ForegroundColor Cyan
Write-Host "Verifying installation..." -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

python -c "import sys; print(f'Python: {sys.version}')"
python -c "import torch; print(f'PyTorch: {torch.__version__}')"
python -c "import torch; print(f'CUDA Available: {torch.cuda.is_available()}')"

Write-Host "`n============================================================" -ForegroundColor Green
Write-Host "Environment setup completed successfully!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green

Write-Host "`nTo activate this environment in the future, run:" -ForegroundColor Yellow
Write-Host "  .\msb_transcribe\Scripts\Activate.ps1" -ForegroundColor White

Write-Host "`nYour environment now contains:" -ForegroundColor Yellow
Write-Host "- PyTorch 2.5.1 with CUDA 12.1 support" -ForegroundColor White
Write-Host "- All packages from your original requirements.txt" -ForegroundColor White  
Write-Host "- Python 3.11.9 (matching original environment)" -ForegroundColor White

Read-Host "`nPress Enter to continue"