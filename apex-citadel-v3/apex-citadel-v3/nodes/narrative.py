"""APEX CITADEL V3.2 - NARRATIVE DIVERGENCE NODE (P2 Survival)
Port: 8004 | Market sentiment and narrative analysis"""
import os, argparse, logging
from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

logging.basicConfig(level=os.getenv("LOG_LEVEL", "INFO"))
logger = logging.getLogger(__name__)

app = FastAPI(title="Narrative Divergence", version="3.2.0")
Instrumentator().instrument(app).expose(app)

@app.on_event("startup")
async def startup():
    logger.info("📝 Narrative Divergence Node starting...")

@app.get("/health")
async def health():
    return {"status": "healthy", "node": "narrative"}

@app.get("/signal/{symbol}")
async def get_signal(symbol: str):
    return {"node": "narrative", "symbol": symbol, "action": "BUY", "confidence": 0.58, "narrative": "bullish_sentiment"}

if __name__ == "__main__":
    import uvicorn
    parser = argparse.ArgumentParser()
    parser.add_argument("--port", type=int, default=8004)
    args = parser.parse_args()
    uvicorn.run(app, host="0.0.0.0", port=args.port)
