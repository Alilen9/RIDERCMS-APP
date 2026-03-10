"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";

type DoorStatus = "opening" | "open" | "insert" | "closing" | "closed";

export default function SlotAssignedPage() {
  const router = useRouter();
  const [doorStatus, setDoorStatus] = useState<DoorStatus>("opening");
  const [step, setStep] = useState(0);

  const steps = [
    { status: "opening" as DoorStatus, label: "🔓 Opening door...", color: "var(--warning)" },
    { status: "open" as DoorStatus, label: "🔓 Door Open – Insert Battery", color: "var(--primary)" },
    { status: "insert" as DoorStatus, label: "🔋 Battery Inserted", color: "var(--primary)" },
    { status: "closing" as DoorStatus, label: "🔒 Closing door...", color: "var(--warning)" },
    { status: "closed" as DoorStatus, label: "🔒 Door Closed – Charging Started", color: "var(--accent)" },
  ];

  useEffect(() => {
    const timers = [
      setTimeout(() => { setDoorStatus("open"); setStep(1); }, 2000),
      setTimeout(() => { setDoorStatus("insert"); setStep(2); }, 4000),
      setTimeout(() => { setDoorStatus("closing"); setStep(3); }, 6000),
      setTimeout(() => { setDoorStatus("closed"); setStep(4); }, 8000),
    ];
    return () => timers.forEach(clearTimeout);
  }, []);

  const currentStep = steps[step];

  return (
    <div className="min-h-screen flex flex-col" style={{ background: "var(--bg-dark)" }}>
      {/* Header */}
      <div className="flex items-center gap-4 px-6 pt-12 pb-6">
        <Link href="/scan">
          <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: "var(--bg-card)" }}>
            ←
          </div>
        </Link>
        <div>
          <h1 className="text-xl font-bold text-white">Slot Assigned</h1>
          <p className="text-xs" style={{ color: "var(--text-secondary)" }}>Westlands Station</p>
        </div>
      </div>

      {/* Slot info */}
      <div className="px-6 mb-6">
        <div
          className="rounded-3xl p-6 text-center"
          style={{ background: "linear-gradient(135deg, #0d2a1a, #0a1f14)", border: "1px solid rgba(0,200,150,0.2)" }}
        >
          <p className="text-sm mb-2" style={{ color: "var(--text-secondary)" }}>Your Assigned Slot</p>
          <div
            className="text-7xl font-black mb-2"
            style={{ color: "var(--primary)", fontFamily: "var(--font-geist-mono)" }}
          >
            A03
          </div>
          <p className="text-sm" style={{ color: "var(--text-secondary)" }}>Battery: BATT102</p>
        </div>
      </div>

      {/* Door status */}
      <div className="px-6 mb-6">
        <div className="card">
          <h3 className="text-sm font-semibold mb-4" style={{ color: "var(--text-secondary)" }}>Door Status</h3>

          {/* Animated door */}
          <div className="flex justify-center mb-6">
            <div
              className="w-32 h-40 rounded-2xl flex items-center justify-center text-6xl transition-all duration-500"
              style={{
                background: doorStatus === "closed" ? "rgba(59,130,246,0.15)" :
                  doorStatus === "opening" || doorStatus === "closing" ? "rgba(245,158,11,0.15)" :
                    "rgba(0,200,150,0.15)",
                border: `2px solid ${doorStatus === "closed" ? "var(--accent)" :
                  doorStatus === "opening" || doorStatus === "closing" ? "var(--warning)" :
                    "var(--primary)"}`,
                boxShadow: doorStatus === "open" || doorStatus === "insert" ?
                  "0 0 30px rgba(0,200,150,0.3)" : "none",
              }}
            >
              {doorStatus === "closed" ? "🔒" :
                doorStatus === "opening" || doorStatus === "closing" ? "⏳" : "🔓"}
            </div>
          </div>

          {/* Status label */}
          <div
            className="text-center py-3 rounded-xl font-semibold text-sm"
            style={{
              background: "rgba(0,0,0,0.3)",
              color: currentStep.color,
            }}
          >
            {currentStep.label}
          </div>

          {/* Progress steps */}
          <div className="mt-4 space-y-2">
            {steps.map((s, i) => (
              <div key={i} className="flex items-center gap-3">
                <div
                  className="w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0"
                  style={{
                    background: i <= step ? "var(--primary)" : "var(--bg-card2)",
                    color: i <= step ? "white" : "var(--text-secondary)",
                  }}
                >
                  {i < step ? "✓" : i + 1}
                </div>
                <span
                  className="text-sm"
                  style={{ color: i <= step ? "var(--text-primary)" : "var(--text-secondary)" }}
                >
                  {s.label}
                </span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Instructions */}
      <div className="px-6 mb-6">
        <div
          className="rounded-2xl p-4 flex gap-3"
          style={{ background: "rgba(245,158,11,0.1)", border: "1px solid rgba(245,158,11,0.2)" }}
        >
          <span className="text-xl">💡</span>
          <div>
            <p className="text-sm font-semibold" style={{ color: "var(--warning)" }}>Instructions</p>
            <p className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>
              Wait for the door to open, then insert your battery firmly into slot A03. The door will close automatically once the battery is detected.
            </p>
          </div>
        </div>
      </div>

      {/* CTA */}
      <div className="px-6 pb-8 mt-auto">
        {doorStatus === "closed" ? (
          <Link href="/charging">
            <button className="btn-primary">View Charging Session →</button>
          </Link>
        ) : (
          <button className="btn-ghost" disabled>
            Waiting for door sequence...
          </button>
        )}
      </div>
    </div>
  );
}
