"use client";

import Link from "next/link";
import { useState } from "react";

const batteries = [
  { id: "BATT102", slot: "A03", collected: false },
  { id: "BATT103", slot: "A04", collected: false },
];

export default function CollectPage() {
  const [collected, setCollected] = useState<string[]>([]);

  const toggleCollect = (id: string) => {
    setCollected((prev) =>
      prev.includes(id) ? prev.filter((b) => b !== id) : [...prev, id]
    );
  };

  const allCollected = collected.length === batteries.length;

  return (
    <div className="min-h-screen flex flex-col" style={{ background: "var(--bg-dark)" }}>
      {/* Header */}
      <div className="flex items-center gap-4 px-6 pt-12 pb-6">
        <Link href="/payment-success">
          <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: "var(--bg-card)" }}>
            ←
          </div>
        </Link>
        <div>
          <h1 className="text-xl font-bold text-white">Collect Batteries</h1>
          <p className="text-xs" style={{ color: "var(--text-secondary)" }}>Westlands Station</p>
        </div>
      </div>

      {/* Instruction banner */}
      <div className="px-6 mb-6">
        <div
          className="rounded-2xl p-4 flex gap-3"
          style={{ background: "rgba(0,200,150,0.1)", border: "1px solid rgba(0,200,150,0.2)" }}
        >
          <span className="text-xl">🔓</span>
          <div>
            <p className="text-sm font-semibold" style={{ color: "var(--primary)" }}>Doors are Open!</p>
            <p className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>
              All slot doors are unlocked. Collect your batteries and tap each slot to confirm collection.
            </p>
          </div>
        </div>
      </div>

      {/* Slot cards */}
      <div className="px-6 mb-6">
        <h3 className="text-sm font-semibold mb-3" style={{ color: "var(--text-secondary)" }}>
          YOUR SLOTS ({collected.length}/{batteries.length} collected)
        </h3>
        <div className="space-y-4">
          {batteries.map((battery) => {
            const isCollected = collected.includes(battery.id);
            return (
              <div
                key={battery.id}
                className="card transition-all duration-300"
                style={{
                  border: isCollected
                    ? "1.5px solid var(--primary)"
                    : "1px solid rgba(255,255,255,0.06)",
                  opacity: isCollected ? 0.8 : 1,
                }}
              >
                <div className="flex items-center gap-4">
                  {/* Slot number */}
                  <div
                    className="w-16 h-16 rounded-2xl flex items-center justify-center flex-shrink-0"
                    style={{
                      background: isCollected ? "rgba(0,200,150,0.15)" : "rgba(255,255,255,0.05)",
                      border: `2px solid ${isCollected ? "var(--primary)" : "rgba(255,255,255,0.1)"}`,
                    }}
                  >
                    <div>
                      <div className="text-xs text-center mb-0.5" style={{ color: "var(--text-secondary)" }}>SLOT</div>
                      <div
                        className="text-xl font-black text-center"
                        style={{ color: isCollected ? "var(--primary)" : "white", fontFamily: "var(--font-geist-mono)" }}
                      >
                        {battery.slot}
                      </div>
                    </div>
                  </div>

                  {/* Info */}
                  <div className="flex-1">
                    <div className="font-bold text-white font-mono">{battery.id}</div>
                    <div
                      className="flex items-center gap-2 mt-1"
                    >
                      <span
                        className="text-xs font-semibold"
                        style={{ color: isCollected ? "var(--primary)" : "var(--warning)" }}
                      >
                        {isCollected ? "✅ Collected" : "🔓 Open – Ready to collect"}
                      </span>
                    </div>
                  </div>

                  {/* Collect button */}
                  <button
                    onClick={() => toggleCollect(battery.id)}
                    className="flex-shrink-0 w-12 h-12 rounded-xl flex items-center justify-center text-xl transition-all"
                    style={{
                      background: isCollected ? "rgba(0,200,150,0.2)" : "var(--bg-card2)",
                      border: `2px solid ${isCollected ? "var(--primary)" : "rgba(255,255,255,0.1)"}`,
                    }}
                  >
                    {isCollected ? "✓" : "○"}
                  </button>
                </div>

                {/* Door visual */}
                <div
                  className="mt-4 rounded-xl p-3 flex items-center justify-between"
                  style={{ background: "rgba(0,0,0,0.3)" }}
                >
                  <div className="flex items-center gap-2">
                    <span className="text-lg">{isCollected ? "🔒" : "🔓"}</span>
                    <span className="text-sm font-medium" style={{ color: isCollected ? "var(--text-secondary)" : "var(--primary)" }}>
                      Door Status: {isCollected ? "Closed" : "Open"}
                    </span>
                  </div>
                  {!isCollected && (
                    <span className="text-xs" style={{ color: "var(--warning)" }}>
                      ⚠️ Remove battery
                    </span>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* CTA */}
      <div className="px-6 pb-8 mt-auto">
        {allCollected ? (
          <Link href="/session-complete">
            <button className="btn-primary">Complete Session →</button>
          </Link>
        ) : (
          <div className="text-center">
            <p className="text-sm mb-4" style={{ color: "var(--text-secondary)" }}>
              Collect all batteries to complete the session
            </p>
            <div className="progress-bar">
              <div
                className="progress-fill"
                style={{ width: `${(collected.length / batteries.length) * 100}%` }}
              />
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
