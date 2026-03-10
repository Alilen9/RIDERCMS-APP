"use client";

import Link from "next/link";
import { useEffect, useState } from "react";

const batteries = [
  { id: "BATT102", slot: "A03" },
  { id: "BATT103", slot: "A04" },
];

export default function PaymentSuccessPage() {
  const [doorsOpening, setDoorsOpening] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => setDoorsOpening(false), 3000);
    return () => clearTimeout(timer);
  }, []);

  return (
    <div className="min-h-screen flex flex-col" style={{ background: "var(--bg-dark)" }}>
      {/* Success header */}
      <div
        className="px-6 pt-12 pb-8 text-center"
        style={{ background: "linear-gradient(180deg, #0d2a1a 0%, var(--bg-dark) 100%)" }}
      >
        {/* Checkmark animation */}
        <div className="relative inline-block mb-6">
          <div
            className="w-24 h-24 rounded-full flex items-center justify-center text-5xl mx-auto"
            style={{
              background: "linear-gradient(135deg, #00C896, #00A87A)",
              boxShadow: "0 8px 32px rgba(0,200,150,0.5)",
            }}
          >
            ✅
          </div>
          <div
            className="absolute inset-0 rounded-full animate-ping"
            style={{ background: "rgba(0,200,150,0.2)" }}
          />
        </div>

        <h1 className="text-3xl font-bold text-white mb-2">Payment Successful!</h1>
        <p className="text-sm" style={{ color: "var(--text-secondary)" }}>
          KSh 284 paid via M-Pesa
        </p>

        {/* Transaction ID */}
        <div
          className="inline-flex items-center gap-2 mt-4 px-4 py-2 rounded-xl"
          style={{ background: "var(--bg-card)" }}
        >
          <span className="text-xs" style={{ color: "var(--text-secondary)" }}>Txn:</span>
          <span className="text-xs font-mono font-semibold text-white">MPE240310001234</span>
        </div>
      </div>

      {/* Door opening status */}
      <div className="px-6 mb-6">
        <div
          className="rounded-2xl p-4 flex gap-3"
          style={{
            background: doorsOpening ? "rgba(245,158,11,0.1)" : "rgba(0,200,150,0.1)",
            border: `1px solid ${doorsOpening ? "rgba(245,158,11,0.2)" : "rgba(0,200,150,0.2)"}`,
          }}
        >
          <span className="text-xl">{doorsOpening ? "⏳" : "🔓"}</span>
          <div>
            <p
              className="text-sm font-semibold"
              style={{ color: doorsOpening ? "var(--warning)" : "var(--primary)" }}
            >
              {doorsOpening ? "Opening doors..." : "All doors are open!"}
            </p>
            <p className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>
              {doorsOpening
                ? "Triggering door release for all charged batteries"
                : "Proceed to collect your batteries from the slots below"}
            </p>
          </div>
        </div>
      </div>

      {/* Battery slots */}
      <div className="px-6 mb-6">
        <h3 className="text-sm font-semibold mb-3" style={{ color: "var(--text-secondary)" }}>
          COLLECT FROM THESE SLOTS
        </h3>
        <div className="grid grid-cols-2 gap-3">
          {batteries.map((battery) => (
            <div
              key={battery.id}
              className="rounded-2xl p-4 text-center"
              style={{
                background: doorsOpening ? "var(--bg-card)" : "rgba(0,200,150,0.1)",
                border: `2px solid ${doorsOpening ? "rgba(255,255,255,0.06)" : "var(--primary)"}`,
                transition: "all 0.5s ease",
              }}
            >
              <div className="text-3xl mb-2">{doorsOpening ? "⏳" : "🔓"}</div>
              <div
                className="text-2xl font-black mb-1"
                style={{ color: "var(--primary)", fontFamily: "var(--font-geist-mono)" }}
              >
                {battery.slot}
              </div>
              <div className="text-xs font-mono" style={{ color: "var(--text-secondary)" }}>
                {battery.id}
              </div>
              <div
                className="mt-2 text-xs font-semibold"
                style={{ color: doorsOpening ? "var(--warning)" : "var(--primary)" }}
              >
                {doorsOpening ? "Opening..." : "🔓 Open"}
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* CTA */}
      <div className="px-6 pb-8 mt-auto">
        <Link href="/collect">
          <button className="btn-primary" disabled={doorsOpening}>
            {doorsOpening ? "Opening Doors..." : "Proceed to Collect →"}
          </button>
        </Link>
      </div>
    </div>
  );
}
