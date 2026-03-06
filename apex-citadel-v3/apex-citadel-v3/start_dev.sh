#!/bin/bash
# =============================================================================
# APEX CITADEL V3.2 - 9-NODE TOPOLOGY STARTUP SCRIPT
# =============================================================================

set -e

echo "🚀 [APEX MAESTRO] Starting 9-node Citadel ensemble..."

if [ ! -d "venv" ]; then
    echo "❌ Virtual environment not found. Run apex_os_bootstrap.sh first."
    exit 1
fi

source venv/bin/activate

if [ ! -f ".env" ]; then
    echo "❌ .env file not found. Run apex_os_bootstrap.sh first."
    exit 1
fi

export $(cat .env | grep -v '^#' | xargs)

mkdir -p logs

echo "📡 [APEX MAESTRO] Launching 9-node ensemble..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

start_node() {
    local node_name=$1
    local node_file=$2
    local port=$3
    
    echo "▶️  Starting $node_name on port $port..."
    python3 "nodes/$node_file" --port $port > "logs/${node_name}.log" 2>&1 &
    echo $! > "logs/${node_name}.pid"
}

# DATA FEED TIER (P2)
start_node "EconoPredator" "econopredator.py" 8000

# SURVIVAL TIER (P2)
start_node "AntiRug" "antirug.py" 8003
start_node "Narrative" "narrative.py" 8004

# EXECUTION TIER (P2)
start_node "Jito" "jito.py" 8005

# DIRECTION TIER (P1)
start_node "DreamerV3" "dreamer.py" 8006
start_node "Newtonian" "newtonian.py" 8011
start_node "SpoofHunter" "spoofhunter.py" 8012

# MASTER ORCHESTRATOR (Hub)
start_node "Master" "master_orchestrator.py" 8007

# APM EXIT ENGINE (P3)
start_node "APM_Exit" "apm_exit_engine.py" 8008

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ [APEX MAESTRO] 9-node ensemble launched."
echo ""
echo "📊 Node URLs:"
echo "   Master Orchestrator ... http://127.0.0.1:8007"
echo "   Newtonian Brother ..... http://127.0.0.1:8011"
echo "   SpoofHunter L2 ........ http://127.0.0.1:8012"
echo "   EconoPredator ......... http://127.0.0.1:8000"
echo "   Anti-Rug v3 .......... http://127.0.0.1:8003"
echo "   Narrative Divergence .. http://127.0.0.1:8004"
echo "   Jito Spoof ............ http://127.0.0.1:8005"
echo "   DreamerV3 ............ http://127.0.0.1:8006"
echo "   APM Exit Engine ....... http://127.0.0.1:8008"
echo ""
echo "📝 Logs: tail -f logs/*.log"
echo "⏹️  Stop: ./stop_nodes.sh"
echo ""
echo "🎯 9-node topology ready for orchestration."
