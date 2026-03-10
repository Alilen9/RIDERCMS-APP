"use client";

import Link from "next/link";

const sessionData = {
  id: "S004",
  date: "Mar 10, 2026",
  station: "Westlands Station",
  batteries: [
    { id: "BATT102", slot: "A03", chargeTime: "1h 52m", startCharge: 45, endCharge: 100, fee: 112 },
    { id: "BATT103", slot: "A04", chargeTime: "2h 38m", startCharge: 22, endCharge: 100, fee: 158 },
  ],
  subtotal: 270,
  serviceFee: 14,
  total: 284,
  paymentMethod: "M-Pesa",
  txnId: "MPE240310001234",
};

export default function SessionCompletePage() {
  return (
    <div className="min-h-screen flex flex-col pb-32" style={{ background: "var(--bg-dark)" }}>
      {/* Success header */}
      <div
        className="px-6 pt-12 pb-8 text-center"
        style={{ background: "linear-gradient(180deg, #0d2a1a 0%, var(--bg-dark) 100%)" }}
      >
        <div
          className="w-20 h-20 rounded-full flex items-center justify-center text-4xl mx-auto mb-4"
          style={{
            background: "linear-gradient(135deg, #00C896, #00A87A)",
            boxShadow: "0 8px 32px rgba(0,200,150,0.4)",
          }}
        >
          🎉
        </div>
        <h1 className="text-2xl font-bold text-white mb-1">Session Complete!</h1>
        <p className="text-sm" style={{ color: "var(--text-secondary)" }}>
          Session #{sessionData.id} · {sessionData.date}
        </p>
        <p className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>
          {sessionData.station}
        </p>
      </div>

      {/* Battery summary */}
      <div className="px-6 mb-6">
        <h3 className="text-sm font-semibold mb-3" style={{ color: "var(--text-secondary)" }}>
          BATTERIES CHARGED
        </h3>
        <div className="space-y-3">
          {sessionData.batteries.map((battery) => (
            <div key={battery.id} className="card">
              <div className="flex items-center justify-between mb-3">
                <div className="flex items-center gap-3">
                  <div
                    className="w-10 h-10 rounded-xl flex items-center justify-center text-xl"
                    style={{ background: "rgba(0,200,150,0.15)" }}
                  >
                    🔋
                  </div>
                  <div>
                    <div className="font-bold text-white font-mono text-sm">{battery.id}</div>
                    <div className="text-xs" style={{ color: "var(--text-secondary)" }}>
                      Slot {battery.slot}
                    </div>
                  </div>
                </div>
                <div className="text-right">
                  <div className="font-bold text-white text-sm">KSh {battery.fee}</div>
                  <div className="text-xs" style={{ color: "var(--text-secondary)" }}>{battery.chargeTime}</div>
                </div>
              </div>

              {/* Charge progress */}
              <div className="flex items-center gap-3">
                <span className="text-xs font-semibold" style={{ color: "var(--warning)" }}>
                  {battery.startCharge}%
                </span>
                <div className="flex-1 progress-bar">
                  <div className="progress-fill" style={{ width: "100%" }} />
                </div>
                <span className="text-xs font-semibold" style={{ color: "var(--primary)" }}>
                  {battery.endCharge}%
                </span>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Payment summary */}
      <div className="px-6 mb-6">
        <h3 className="text-sm font-semibold mb-3" style={{ color: "var(--text-secondary)" }}>
          PAYMENT SUMMARY
        </h3>
        <div className="card space-y-3">
          <div className="flex justify-between text-sm">
            <span style={{ color: "var(--text-secondary)" }}>Subtotal</span>
            <span className="text-white">KSh {sessionData.subtotal}</span>
          </div>
          <div className="flex justify-between text-sm">
            <span style={{ color: "var(--text-secondary)" }}>Service Fee</span>
            <span className="text-white">KSh {sessionData.serviceFee}</span>
          </div>
          <div className="h-px" style={{ background: "rgba(255,255,255,0.06)" }} />
          <div className="flex justify-between">
            <span className="font-bold text-white">Total Paid</span>
            <span className="font-bold text-xl" style={{ color: "var(--primary)" }}>KSh {sessionData.total}</span>
          </div>
          <div className="flex justify-between text-xs">
            <span style={{ color: "var(--text-secondary)" }}>Payment Method</span>
            <span style={{ color: "var(--text-secondary)" }}>{sessionData.paymentMethod}</span>
          </div>
          <div className="flex justify-between text-xs">
            <span style={{ color: "var(--text-secondary)" }}>Transaction ID</span>
            <span className="font-mono" style={{ color: "var(--text-secondary)" }}>{sessionData.txnId}</span>
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="px-6 mb-6">
        <div className="grid grid-cols-3 gap-3">
          <div className="card text-center">
            <div className="text-2xl mb-1">🔋</div>
            <div className="text-xl font-bold text-white">{sessionData.batteries.length}</div>
            <div className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>Batteries</div>
          </div>
          <div className="card text-center">
            <div className="text-2xl mb-1">⏱️</div>
            <div className="text-xl font-bold text-white">2h 38m</div>
            <div className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>Total Time</div>
          </div>
          <div className="card text-center">
            <div className="text-2xl mb-1">⚡</div>
            <div className="text-xl font-bold text-white">133%</div>
            <div className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>Charged</div>
          </div>
        </div>
      </div>

      {/* Feedback */}
      <div className="px-6 mb-6">
        <div className="card">
          <p className="text-sm font-semibold text-white mb-3">Rate this session</p>
          <div className="flex gap-2 justify-center">
            {[1, 2, 3, 4, 5].map((star) => (
              <button key={star} className="text-3xl transition-transform hover:scale-110">
                ⭐
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Bottom actions */}
      <div className="fixed bottom-0 left-1/2 -translate-x-1/2 w-full max-w-[430px] px-6 py-4 space-y-3" style={{ background: "var(--bg-card)", borderTop: "1px solid rgba(255,255,255,0.06)" }}>
        <Link href="/scan">
          <button className="btn-primary">⚡ Start New Session</button>
        </Link>
        <Link href="/dashboard">
          <button className="btn-ghost">Return Home</button>
        </Link>
      </div>
    </div>
  );
}
