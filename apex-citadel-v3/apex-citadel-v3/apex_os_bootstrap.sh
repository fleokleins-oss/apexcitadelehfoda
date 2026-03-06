#!/bin/bash
# =============================================================================
# APEX CITADEL V3.2 - 9-NODE TOPOLOGY BOOTSTRAP SCRIPT
# Target OS: Pop!_OS 22.04 LTS / Ubuntu 22.04 LTS
# Full topology: Master, Newtonian, SpoofHunter, EconoPredator, AntiRug, 
#                Narrative, Jito, Dreamer, APM
# =============================================================================

set -e

echo "[APEX ARCHITECT] Initiating 9-node bare-metal OS bootstrap sequence..."

# -----------------------------------------------------------------------------
# PHASE 1: SYSTEM UPDATES & CORE DEPENDENCIES
# -----------------------------------------------------------------------------
echo "[APEX ARCHITECT] Phase 1: Synchronizing Advanced Packaging Tool (APT)..."
sudo apt-get update
sudo apt-get upgrade -y

echo "[APEX ARCHITECT] Installing compilation binaries and system utilities..."
sudo apt-get install -y build-essential wget curl git redis-server python3-pip python3-venv python3-dev

# -----------------------------------------------------------------------------
# PHASE 2: REDIS INITIALIZATION
# -----------------------------------------------------------------------------
echo "[APEX ARCHITECT] Phase 2: Enabling Redis State Management..."
sudo systemctl enable redis-server
sudo systemctl start redis-server
echo "[APEX ARCHITECT] Redis operational. DLQ and async buffering supported."

# -----------------------------------------------------------------------------
# PHASE 3: TA-LIB SOURCE COMPILATION
# -----------------------------------------------------------------------------
echo "[APEX ARCHITECT] Phase 3: Verifying Technical Analysis Library (TA-Lib)..."
if [ ! -f /usr/lib/libta_lib.so ] && [ ! -f /usr/local/lib/libta_lib.so ]; then
    echo "[APEX ARCHITECT] TA-Lib missing. Compiling from C source..."
    wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
    tar -xzf ta-lib-0.4.0-src.tar.gz
    cd ta-lib/
    ./configure --prefix=/usr
    make
    sudo make install
    cd ..
    rm -rf ta-lib ta-lib-0.4.0-src.tar.gz
    echo "[APEX ARCHITECT] TA-Lib compilation and dynamic linking complete."
else
    echo "[APEX ARCHITECT] TA-Lib already present in system binaries. Skipping."
fi

# -----------------------------------------------------------------------------
# PHASE 4: DIRECTORY, SOURCE COPY & VIRTUAL ENVIRONMENT
# -----------------------------------------------------------------------------
echo "[APEX ARCHITECT] Phase 4: Constructing Apex Citadel Directory..."
REPO_DIR=$(pwd)
APEX_DIR="$HOME/apex-orchestrator"
mkdir -p "$APEX_DIR"

echo "[APEX ARCHITECT] Copying source code to Citadel directory..."
cp -r "$REPO_DIR"/* "$APEX_DIR"/ || true

cd "$APEX_DIR"

echo "[APEX ARCHITECT] Initializing isolated Python environment..."
python3 -m venv venv
source venv/bin/activate

echo "[APEX ARCHITECT] Upgrading Python Package Installer (PIP)..."
pip install --upgrade pip wheel setuptools

# -----------------------------------------------------------------------------
# PHASE 5: DEPENDENCY INJECTION (requirements.txt + ML Extras)
# -----------------------------------------------------------------------------
echo "[APEX ARCHITECT] Phase 5: Injecting 9-node ensemble dependencies..."

if [ -f "requirements.txt" ]; then
    echo "[APEX ARCHITECT] Found requirements.txt. Installing core packages (including Prometheus)..."
    pip install -r requirements.txt
else
    echo "[APEX ARCHITECT] WARNING: requirements.txt not found!"
fi

echo "[APEX ARCHITECT] Installing extra ML/RL and hardware-optimized dependencies..."
pip install torch --index-url https://download.pytorch.org/whl/cpu
pip install stable-baselines3 gymnasium numba

# -----------------------------------------------------------------------------
# PHASE 6: ENVIRONMENT STUBBING (9-NODE TOPOLOGY)
# -----------------------------------------------------------------------------
echo "[APEX ARCHITECT] Phase 6: Generating 9-node configuration..."
if [ ! -f .env ]; then
    cat <<EOF > .env
# APEX CITADEL V3.2 - 9-NODE TOPOLOGY CONFIGURATION
USE_TESTNET=TRUE
MAESTRO_V3_CONFLUENCE_MODE=MAJORITY
MAESTRO_V3_MIN_CONFIDENCE=0.55
MAESTRO_V3_BASE_RISK_PCT=0.01

# REDIS STATE QUEUE
REDIS_URL=redis://127.0.0.1:6379/0

# MASTER ORCHESTRATOR (Port 8007)
MAESTRO_PORT=8007

# DIRECTION NODES (P1 Tier - Strategic Direction)
MAESTRO_NEWTONIAN_URL=http://127.0.0.1:8011
MAESTRO_SPOOFHUNTER_URL=http://127.0.0.1:8012
MAESTRO_DREAMER_URL=http://127.0.0.1:8006

# DATA FEED (P2 Tier - Data Intelligence)
MAESTRO_ECONOPREDATOR_URL=http://127.0.0.1:8000

# SURVIVAL NODES (P2 Tier - Risk & Protection)
MAESTRO_ANTIRUG_URL=http://127.0.0.1:8003
MAESTRO_NARRATIVE_URL=http://127.0.0.1:8004

# EXECUTION (P2 Tier - Action & Control)
MAESTRO_JITO_URL=http://127.0.0.1:8005

# APM EXIT ENGINE (P3 Tier - Emergency Management)
APM_EXIT_ENGINE_URL=http://127.0.0.1:8008

# ALERTS & API KEYS (POPULATE THESE!)
TELEGRAM_BOT_TOKEN=
TELEGRAM_CHAT_ID=
BINANCE_API_KEY=
BINANCE_API_SECRET=
EOF
    echo "[APEX ARCHITECT] Stub .env generated with 9-node topology URLs."
fi

echo "========================================================================"
echo "🎯 APEX CITADEL 9-NODE TOPOLOGY BOOTSTRAP COMPLETE."
echo ""
echo "Node Topology:"
echo "  Master Orchestrator v3 ......... Port 8007"
echo "  Newtonian Brother (P1) ........ Port 8011"
echo "  SpoofHunter L2 (P1) ........... Port 8012"
echo "  EconoPredator (P2) ............ Port 8000"
echo "  Anti-Rug v3 (P2) ............. Port 8003"
echo "  Narrative Divergence (P2) .... Port 8004"
echo "  Jito Spoof/Memecoin (P2) ..... Port 8005"
echo "  DreamerV3 (P1) ............... Port 8006"
echo "  APM Exit Engine (P3) ......... Port 8008"
echo ""
echo "Machine is primed for 9-node orchestration."
echo "To begin:"
echo "1. cd ~/apex-orchestrator"
echo "2. nano .env (add your keys if needed)"
echo "3. source venv/bin/activate"
echo "4. chmod +x start_dev.sh && ./start_dev.sh"
echo "========================================================================"
