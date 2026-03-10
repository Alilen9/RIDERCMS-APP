"use client";

import Link from "next/link";
import { useState, useEffect } from "react";

const initialBatteries = [
  { id: "BATT102", slot: "A03", charge: 45, estimatedHours: 2, estimatedMins: 0 },
  { id: "BATT103", slot: "A04", charge: 22, estimatedHours: 2, estimatedMins: 45 },
];

export default function ChargingPage() {
  const [batteries, setBatteries] = useState(initialBatteries);
  const [elapsed, setElapsed] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setElapsed((e) => e + 1);
      setBatteries((prev) =>
        prev.map((b) => ({
          ...b,
          charge: Math.min(100, b.charge + 0.1),
        }))
      );
    }, 1000);
    return () => clearInterval(interval);
  }, []);

  const formatTime = (secs: number) => {
    const m = Math.floor(secs / 60);
    const s = secs % 60;
    return `${m}m ${s}s`;
  };

  return (
    <div className="min-h-screen flex flex-col pb-24" style={{ background: "var(--bg-dark)" }}>
      {/* Header */}
      <div className="flex items-center gap-4 px-6 pt-12 pb-6">
        <Link href="/dashboard">
          <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: "var(--bg-card)" }}>
            ←
          </div>
        </Link>
        <div className="flex-1">
          <h1 className="text-xl font-bold text-white">Charging Session</h1>
          <p className="text-xs" style={{ color: "var(--text-secondary)" }}>Westlands Station · Active</p>
        </div>
        <div
          className="flex items-center gap-2 px-3 py-1.5 rounded-xl"
          style={{ background: "rgba(0,200,150,0.15)" }}
        >
          <div className="w-2 h-2 rounded-full animate-pulse" style={{ background: "var(--primary)" }} />
          <span className="text-xs font-semibold" style={{ color: "var(--primary)" }}>LIVE</span>
        </div>
      </div>

      {/* Session timer */}
      <div className="px-6 mb-6">
        <div
          className="rounded-2xl p-4 flex items-center justify-between"
          style={{ background: "var(--bg-card)" }}
        >
          <div>
            <p className="text-xs mb-1" style={{ color: "var(--text-secondary)" }}>Session Duration</p>
            <p className="text-2xl font-bold font-mono text-white">{formatTime(elapsed)}</p>
          </div>
          <div className="text-right">
            <p className="text-xs mb-1" style={{ color: "var(--text-secondary)" }}>Batteries Charging</p>
            <p className="text-2xl font-bold text-white">{batteries.length}</p>
          </div>
        </div>
      </div>

      {/* Battery cards */}
      <div className="px-6 space-y-4 mb-6">
        {batteries.map((battery) => (
          <div key={battery.id} className="card">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-3">
                <div
                  className="w-12 h-12 rounded-xl flex items-center justify-center text-2xl"
                  style={{ background: "rgba(245,158,11,0.15)" }}
                >
                  🔋
                </div>
                <div>
                  <div className="font-bold text-white font-mono">{battery.id}</div>
                  <div className="text-xs mt-0.5" style={{ color: "var(--text-secondary)" }}>
                    Slot: <span className="font-semibold" style={{ color: "var(--primary)" }}>{battery.slot}</span>
                  </div>
                </div>
              </div>
              <div
                className="px-3 py-1.5 rounded-xl text-xs font-semibold"
                style={{ background: "rgba(245,158,11,0.15)", color: "var(--warning)" }}
              >
                ⚡ Charging
              </div>
            </div>

            {/* Charge progress */}
            <div className="mb-3">
              <div className="flex justify-between text-xs mb-2">
                <span style={{ color: "var(--text-secondary)" }}>Charge Level</span>
                <span className="font-bold" style={{ color: "var(--primary)" }}>
                  {battery.charge.toFixed(1)}%
                </span>
              </div>
              <div className="progress-bar">
                <div
                  className="progress-fill"
                  style={{ width: `${battery.charge}%` }}
                />
              </div>
            </div>

            {/* Stats row */}
            <div className="grid grid-cols-2 gap-3">
              <div
                className="rounded-xl p-3 text-center"
                style={{ background: "var(--bg-card2)" }}
              >
                <p className="text-xs mb-1" style={{ color: "var(--text-secondary)" }}>Est. Time</p>
                <p className="font-bold text-white text-sm">
                  {battery.estimatedHours}h {battery.estimatedMins > 0 ? `${battery.estimatedMins}m` : ""}
                </p>
              </div>
              <div
                className="rounded-xl p-3 text-center"
                style={{ background: "var(--bg-card2)" }}
              >
                <p className="text-xs mb-1" style={{ color: "var(--text-secondary)" }}>Rate</p>
                <p className="font-bold text-white text-sm">KSh 60/hr</p>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Add another battery */}
      <div className="px-6 mb-6">
        <Link href="/scan">
          <button className="btn-ghost">
            + Add Another Battery
          </button>
        </Link>
      </div>

      {/* Notification banner */}
      <div className="px-6 mb-6">
        <div
          className="rounded-2xl p-4 flex gap-3"
          style={{ background: "rgba(59,130,246,0.1)", border: "1px solid rgba(59,130,246,0.2)" }}
        >
          <span className="text-xl">🔔</span>
          <div>
            <p className="text-sm font-semibold" style={{ color: "var(--accent)" }}>Notifications Enabled</p>
            <p className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>
              You&apos;ll be notified when your batteries are fully charged and ready for collection.
            </p>
          </div>
        </div>
      </div>

      {/* Bottom actions */}
      <div className="fixed bottom-0 left-1/2 -translate-x-1/2 w-full max-w-[430px] px-6 py-4" style={{ background: "var(--bg-card)", borderTop: "1px solid rgba(255,255,255,0.06)" }}>
        <Link href="/battery-ready">
          <button className="btn-primary">
            Simulate: Battery Ready 🔔
          </button>
        </Link>
      </div>
    </div>
  );
}
