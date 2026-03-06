#!/bin/bash
# =============================================================================
# APEX CITADEL V3.2 - STOP ALL 9 NODES
# =============================================================================

echo "🛑 [APEX MAESTRO] Shutting down 9-node ensemble..."

for pidfile in logs/*.pid; do
    if [ -f "$pidfile" ]; then
        pid=$(cat "$pidfile")
        node_name=$(basename "$pidfile" .pid)
        echo "Killing $node_name (PID: $pid)..."
        kill $pid 2>/dev/null || echo "  (already stopped)"
        rm "$pidfile"
    fi
done

echo "✅ All nodes stopped."
