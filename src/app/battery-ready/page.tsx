"use client";

import Link from "next/link";

const batteries = [
  { id: "BATT102", slot: "A03", chargeTime: "1h 52m", finalCharge: 100 },
  { id: "BATT103", slot: "A04", chargeTime: "2h 38m", finalCharge: 100 },
];

export default function BatteryReadyPage() {
  return (
    <div className="min-h-screen flex flex-col" style={{ background: "var(--bg-dark)" }}>
      {/* Notification banner */}
      <div
        className="px-6 pt-12 pb-6"
        style={{ background: "linear-gradient(180deg, #0d2a1a 0%, var(--bg-dark) 100%)" }}
      >
        <div className="flex items-center gap-4 mb-6">
          <Link href="/charging">
            <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: "var(--bg-card)" }}>
              ←
            </div>
          </Link>
          <h1 className="text-xl font-bold text-white">Battery Ready!</h1>
        </div>

        {/* Big notification */}
        <div
          className="rounded-3xl p-6 text-center"
          style={{
            background: "linear-gradient(135deg, rgba(0,200,150,0.2), rgba(0,168,122,0.1))",
            border: "1px solid rgba(0,200,150,0.3)",
          }}
        >
          <div
            className="w-20 h-20 rounded-full flex items-center justify-center text-4xl mx-auto mb-4 animate-pulse-glow"
            style={{ background: "linear-gradient(135deg, #00C896, #00A87A)" }}
          >
            🔔
          </div>
          <h2 className="text-2xl font-bold text-white mb-2">Batteries Fully Charged!</h2>
          <p className="text-sm" style={{ color: "var(--text-secondary)" }}>
            Your batteries are ready for collection at Westlands Station
          </p>
        </div>
      </div>

      {/* Battery details */}
      <div className="px-6 mb-6">
        <h3 className="text-base font-semibold text-white mb-3">Charged Batteries</h3>
        <div className="space-y-3">
          {batteries.map((battery) => (
            <div key={battery.id} className="card">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div
                    className="w-12 h-12 rounded-xl flex items-center justify-center text-2xl"
                    style={{ background: "rgba(0,200,150,0.15)" }}
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
                <div className="text-right">
                  <div
                    className="px-3 py-1.5 rounded-xl text-xs font-semibold mb-1"
                    style={{ background: "rgba(0,200,150,0.15)", color: "var(--primary)" }}
                  >
                    ✅ 100%
                  </div>
                  <div className="text-xs" style={{ color: "var(--text-secondary)" }}>
                    {battery.chargeTime}
                  </div>
                </div>
              </div>

              {/* Full progress bar */}
              <div className="mt-3">
                <div className="progress-bar">
                  <div className="progress-fill" style={{ width: "100%" }} />
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Station info */}
      <div className="px-6 mb-6">
        <div className="card flex items-center gap-4">
          <div
            className="w-12 h-12 rounded-xl flex items-center justify-center text-2xl flex-shrink-0"
            style={{ background: "rgba(59,130,246,0.15)" }}
          >
            📍
          </div>
          <div>
            <div className="font-semibold text-white">Westlands Station</div>
            <div className="text-xs mt-0.5" style={{ color: "var(--text-secondary)" }}>
              Westlands Rd, Nairobi · Open until 10 PM
            </div>
          </div>
          <button
            className="ml-auto text-sm font-semibold flex-shrink-0"
            style={{ color: "var(--primary)" }}
          >
            Directions
          </button>
        </div>
      </div>

      {/* Reminder */}
      <div className="px-6 mb-6">
        <div
          className="rounded-2xl p-4 flex gap-3"
          style={{ background: "rgba(245,158,11,0.1)", border: "1px solid rgba(245,158,11,0.2)" }}
        >
          <span className="text-xl">⏰</span>
          <div>
            <p className="text-sm font-semibold" style={{ color: "var(--warning)" }}>Collection Reminder</p>
            <p className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>
              Please collect your batteries within 2 hours to avoid additional storage fees.
            </p>
          </div>
        </div>
      </div>

      {/* CTA */}
      <div className="px-6 pb-8 mt-auto">
        <Link href="/payment">
          <button className="btn-primary">Proceed to Payment →</button>
        </Link>
        <Link href="/charging">
          <button className="btn-ghost mt-3">Back to Session</button>
        </Link>
      </div>
    </div>
  );
}
