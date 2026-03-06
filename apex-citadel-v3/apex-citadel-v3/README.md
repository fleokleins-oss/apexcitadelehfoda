# APEX CITADEL V3.2 - 9-NODE TOPOLOGY 🚀

Advanced high-frequency cryptocurrency trading with full 9-node ensemble orchestration.

## ⚡ Full 9-Node Topology

```
                    ┌──────────────────────────────┐
                    │  MASTER ORCHESTRATOR v3      │
                    │  (Port 8007 - Hub)           │
                    │  Signal Aggregation & Control│
                    └──────────┬───────────────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
    ┌───┴────┐           ┌─────┴─────┐          ┌────┴─────┐
    │ P1     │           │ P2        │          │ P3       │
    │ TIER   │           │ TIER      │          │ TIER     │
    └───┬────┘           └─────┬─────┘          └────┬─────┘
        │                      │                      │
    ┌───┴─────────────────┬────┴────┬──────────────┬─┴─────────┐
    │                     │         │              │           │
┌───┴────┐  ┌──────────┐┌┴───┐ ┌──┴─┐ ┌──────┐┌──┴──┐    ┌──┴──────┐
│Newtonian│  │SpoofHunt││Econ│ │Anti││Narrat││Jito ││    │APM Exit │
│Brother  │  │er L2    ││Pred│ │Rug ││ive   ││Spoof││    │Engine   │
│(8011)   │  │(8012)   ││(80 │ │(80 ││Div.  ││Meme ││    │(8008)   │
│Physics  │  │Whales   ││00) │ │03) ││(8004)││(8005││    │Emergency│
│Momentum │  │Detection││Data││Risk││Senti ││Exec ││    │Stop     │
└────────┘  └──────────┘└────┘ └────┘ └──────┘└─────┘    └─────────┘
    │                     │         │              │           │
    └─────────────────────┴─────────┴──────────────┴───────────┘
                          │
                ┌─────────┴────────┐
                │    REDIS        │
                │  State Queue    │
                │ (127.0.0.1:6379)│
                └─────────────────┘
```

## Node Structure

### **P1 Tier - Direction & Strategy (3 nodes)**

#### 🧮 Newtonian Brother (Port 8011)
- **Role**: Physics-based momentum analysis
- **Features**: Velocity, acceleration, inertia calculations
- **Confidence**: ~68%
- **Output**: BUY/SELL signals based on physical laws

#### 🐳 SpoofHunter L2 (Port 8012)
- **Role**: Whale detection & order book analysis
- **Features**: L2 spoofing detection, accumulation patterns
- **Confidence**: ~72%
- **Output**: Whale activity signals

#### 💭 DreamerV3 (Port 8006)
- **Role**: Scenario modeling & imagination
- **Features**: Alternative market futures, probability weighting
- **Confidence**: ~62%
- **Output**: Bull/bear case probability signals

### **P2 Tier - Data, Survival, Execution (5 nodes)**

#### 📊 EconoPredator (Port 8000) - DATA
- **Role**: Market data intelligence
- **Features**: Economic indicators, macro analysis
- **Confidence**: ~65%
- **Output**: Market trend signals

#### 🛡️ AntiRug v3 (Port 8003) - SURVIVAL
- **Role**: XGBoost-based rug-pull detection
- **Features**: Risk scoring, contract analysis
- **Confidence**: ~73%
- **Output**: Risk assessment signals

#### 📝 Narrative Divergence (Port 8004) - SURVIVAL
- **Role**: Sentiment & narrative analysis
- **Features**: Market sentiment, news divergence
- **Confidence**: ~58%
- **Output**: Sentiment-based signals

#### ⚡ Jito Spoof (Port 8005) - EXECUTION
- **Role**: Jito MEV, memecoin trading, spoofing
- **Features**: MEV opportunity detection, memecoin patterns
- **Confidence**: ~70%
- **Output**: Execution signals + trade routing

### **P3 Tier - Emergency Management (1 node)**

#### 🚨 APM Exit Engine (Port 8008)
- **Role**: 4-weapon emergency exit system
- **Features**: 
  1. Emergency stop (circuit breaker)
  2. Rapid liquidation (damage control)
  3. Position hedging (risk reduction)
  4. Alert escalation (notifi system)
- **Trigger**: Auto-activated on risk thresholds
- **Output**: Exit confirmations, liquidation status

---

## Quick Start

### 1. Extract & Setup

```bash
unzip apex-citadel-v3.zip
cd apex-citadel-v3
chmod +x apex_os_bootstrap.sh
./apex_os_bootstrap.sh
```

### 2. Configure

```bash
cd ~/apex-orchestrator
cp .env.template .env
nano .env
# Add BINANCE_API_KEY and BINANCE_API_SECRET
```

### 3. Start All 9 Nodes

```bash
source venv/bin/activate
./start_dev.sh
```

### 4. Monitor

```bash
# All nodes
tail -f logs/*.log

# Specific node
tail -f logs/Master.log

# Check status
curl http://127.0.0.1:8007/status
curl http://127.0.0.1:8007/topology
```

### 5. Test Signal Aggregation

```bash
# Aggregate signals from all 9 nodes
curl -X POST "http://127.0.0.1:8007/signal/aggregate?symbol=BTCUSDT"
```

---

## Architecture Details

### Signal Flow

1. **Data Ingestion** → EconoPredator collects market data
2. **Direction Analysis** → P1 nodes (Newtonian, SpoofHunter, Dreamer) process
3. **Risk Assessment** → AntiRug & Narrative evaluate risk
4. **Consensus** → Master Orchestrator aggregates 9 signals
5. **Execution** → Jito handles order placement
6. **Risk Management** → APM monitors and can trigger emergency exits

### Consensus Algorithm

```
Action Decision:
  - BUY if: buy_votes/total_votes >= 0.55 (configurable)
  - SELL if: sell_votes/total_votes >= 0.55
  - HOLD if: no threshold met

Example (all 9 online):
  - BUY: 6 votes
  - SELL: 2 votes
  - HOLD: 1 vote
  → Confidence: 6/9 = 66.7%
  → Action: BUY ✅
```

---

## Node Details

### Master Orchestrator (Port 8007)

**Endpoints:**
```
GET  /health              → Health check
GET  /status              → Full 9-node topology status
GET  /topology            → Architecture visualization
POST /signal/aggregate    → Aggregate signals from all 9 nodes
POST /execute/trade      → Execute via Jito routing
```

**Example Response:**
```json
{
  "service": "master_orchestrator_v3",
  "topology": "9-node_full_ensemble",
  "nodes": {
    "newtonian": "online",
    "spoofhunter": "online",
    "dreamer": "online",
    "econopredator": "online",
    "antirug": "online",
    "narrative": "online",
    "jito": "online",
    "apm_exit": "online",
    "master": "online"
  },
  "online_count": 9
}
```

### Individual Node Endpoints

**Each of 9 nodes exposes:**
```
GET  /health        → Node health
GET  /signal/{symbol} → Get signal for symbol
```

---

## Configuration

### Master Orchestrator Settings

```env
# Consensus threshold (0-1)
MAESTRO_V3_MIN_CONFIDENCE=0.55

# Confluence mode
MAESTRO_V3_CONFLUENCE_MODE=MAJORITY

# Risk parameters
MAESTRO_V3_BASE_RISK_PCT=0.01
MAESTRO_V3_MAX_CONCURRENT_TRADES=10
```

### Node Port Mapping

```
P1 Direction:     8011, 8012, 8006
P2 Data:          8000
P2 Survival:      8003, 8004
P2 Execution:     8005
P3 Emergency:     8008
Master Hub:       8007
```

---

## Monitoring & Observability

### Prometheus Metrics

Each node exposes Prometheus metrics at `/metrics`:

```bash
curl http://127.0.0.1:8011/metrics  # Newtonian
curl http://127.0.0.1:8007/metrics  # Master
```

### Structured Logging

All nodes log to `logs/{NodeName}.log`:

```bash
tail -f logs/Master.log
tail -f logs/SpoofHunter.log
tail -f logs/APM_Exit.log
```

### Health Dashboard

```bash
# Real-time status
watch -n 1 'curl -s http://127.0.0.1:8007/status | jq'
```

---

## Emergency Procedures

### Trigger Emergency Exit

```bash
# Via APM Exit Engine
curl -X POST "http://127.0.0.1:8008/emergency_exit?symbol=BTCUSDT&reason=loss_limit_hit"
```

### Liquidate Position

```bash
curl -X POST "http://127.0.0.1:8008/liquidate_position?symbol=BTCUSDT"
```

### Full System Shutdown

```bash
./stop_nodes.sh
```

---

## Performance Metrics

### Expected Latency
- Inter-node communication: <50ms
- Signal aggregation (9 nodes): <200ms
- Trade execution: <500ms

### Resource Usage
- Memory: ~200MB (all 9 nodes)
- CPU: 10-15% idle, 40-60% under load
- Disk: <1GB operational

---

## Development & Customization

### Add Custom Node

1. Create `nodes/custom_node.py` with FastAPI app
2. Add port to `.env`
3. Update `start_dev.sh` to launch it
4. Register in `master_orchestrator.py` NODES dict

### Modify Consensus

Edit `master_orchestrator.py` `calculate_consensus()` function for custom logic.

### Add New Signal Type

Each node's `/signal/{symbol}` can include custom fields:

```python
return {
    "node": "custom",
    "symbol": symbol,
    "action": "BUY",
    "confidence": 0.70,
    "custom_metric_1": 0.85,
    "custom_metric_2": "bearish"
}
```

---

## Requirements

- Pop!_OS 22.04 LTS or Ubuntu 22.04 LTS
- Python 3.8+
- 8GB+ RAM
- 50GB+ free disk
- Sudo access
- Redis server

---

## Troubleshooting

### Node Won't Start

```bash
# Check if port is in use
lsof -i :8011

# Kill existing process
pkill -f "nodes/newtonian"

# Restart
./stop_nodes.sh && sleep 2 && ./start_dev.sh
```

### Connection Errors

```bash
# Verify Redis is running
redis-cli ping

# Check Master can reach nodes
curl http://127.0.0.1:8011/health
```

### Consensus Not Working

```bash
# Test signal aggregation directly
curl -X POST "http://127.0.0.1:8007/signal/aggregate?symbol=BTCUSDT"

# Check node responses
for port in 8000 8003 8004 8005 8006 8011 8012 8008; do
  echo "Port $port:"
  curl http://127.0.0.1:$port/signal/BTCUSDT 2>/dev/null | jq .
done
```

---

## Next Steps

1. ✅ Bootstrap the system (`./apex_os_bootstrap.sh`)
2. ✅ Configure API keys (`.env`)
3. ✅ Start all 9 nodes (`./start_dev.sh`)
4. ✅ Monitor logs (`tail -f logs/*.log`)
5. ✅ Test signal aggregation (`curl /signal/aggregate`)
6. ✅ Execute trades via Master Orchestrator

---

**APEX CITADEL V3.2 - Full 9-Node Ensemble Ready** 🎯🚀
