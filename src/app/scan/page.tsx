"use client";

import Link from "next/link";
import { useState } from "react";
import { useRouter } from "next/navigation";

export default function ScanPage() {
  const router = useRouter();
  const [mode, setMode] = useState<"scan" | "manual">("scan");
  const [batteryId, setBatteryId] = useState("");
  const [batteries, setBatteries] = useState<string[]>([]);
  const [scanning, setScanning] = useState(false);

  const handleAddBattery = () => {
    if (batteryId.trim()) {
      setBatteries([...batteries, batteryId.trim()]);
      setBatteryId("");
    }
  };

  const handleScan = () => {
    setScanning(true);
    setTimeout(() => {
      setScanning(false);
      setBatteries([...batteries, `BATT${100 + batteries.length + 2}`]);
    }, 2000);
  };

  const handleProceed = () => {
    router.push("/slot-assigned");
  };

  return (
    <div className="min-h-screen flex flex-col" style={{ background: "var(--bg-dark)" }}>
      {/* Header */}
      <div className="flex items-center gap-4 px-6 pt-12 pb-6">
        <Link href="/map">
          <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: "var(--bg-card)" }}>
            ←
          </div>
        </Link>
        <div>
          <h1 className="text-xl font-bold text-white">Scan Battery</h1>
          <p className="text-xs" style={{ color: "var(--text-secondary)" }}>Westlands Station · Slot A</p>
        </div>
      </div>

      {/* Mode toggle */}
      <div className="px-6 mb-6">
        <div className="flex rounded-2xl p-1" style={{ background: "var(--bg-card)" }}>
          <button
            onClick={() => setMode("scan")}
            className="flex-1 py-3 rounded-xl text-sm font-semibold transition-all duration-200"
            style={{
              background: mode === "scan" ? "var(--primary)" : "transparent",
              color: mode === "scan" ? "white" : "var(--text-secondary)",
            }}
          >
            📷 Scan QR
          </button>
          <button
            onClick={() => setMode("manual")}
            className="flex-1 py-3 rounded-xl text-sm font-semibold transition-all duration-200"
            style={{
              background: mode === "manual" ? "var(--primary)" : "transparent",
              color: mode === "manual" ? "white" : "var(--text-secondary)",
            }}
          >
            ✏️ Manual Entry
          </button>
        </div>
      </div>

      {/* Scanner / Manual */}
      <div className="px-6 flex-1">
        {mode === "scan" ? (
          <div>
            {/* Camera viewfinder */}
            <div
              className="rounded-3xl overflow-hidden mb-6 relative flex items-center justify-center"
              style={{ height: "280px", background: "var(--bg-card)" }}
            >
              {scanning ? (
                <div className="text-center">
                  <div className="loader mx-auto mb-4" />
                  <p className="text-sm" style={{ color: "var(--text-secondary)" }}>Scanning...</p>
                </div>
              ) : (
                <div className="text-center">
                  {/* Scan frame */}
                  <div className="relative w-48 h-48 mx-auto mb-4">
                    <div className="absolute inset-0 border-2 rounded-2xl" style={{ borderColor: "var(--primary)" }} />
                    {/* Corner accents */}
                    <div className="absolute top-0 left-0 w-6 h-6 border-t-4 border-l-4 rounded-tl-lg" style={{ borderColor: "var(--primary)" }} />
                    <div className="absolute top-0 right-0 w-6 h-6 border-t-4 border-r-4 rounded-tr-lg" style={{ borderColor: "var(--primary)" }} />
                    <div className="absolute bottom-0 left-0 w-6 h-6 border-b-4 border-l-4 rounded-bl-lg" style={{ borderColor: "var(--primary)" }} />
                    <div className="absolute bottom-0 right-0 w-6 h-6 border-b-4 border-r-4 rounded-br-lg" style={{ borderColor: "var(--primary)" }} />
                    <div className="absolute inset-0 flex items-center justify-center text-5xl">🔋</div>
                  </div>
                  <p className="text-sm" style={{ color: "var(--text-secondary)" }}>Point camera at battery QR code</p>
                </div>
              )}
            </div>

            <button className="btn-primary mb-3" onClick={handleScan} disabled={scanning}>
              {scanning ? "Scanning..." : "📷 Tap to Scan"}
            </button>
          </div>
        ) : (
          <div className="mb-6">
            <label className="block text-sm font-medium mb-2" style={{ color: "var(--text-secondary)" }}>
              Battery ID
            </label>
            <div className="flex gap-3">
              <input
                type="text"
                className="input-field flex-1"
                placeholder="e.g. BATT102"
                value={batteryId}
                onChange={(e) => setBatteryId(e.target.value.toUpperCase())}
                onKeyDown={(e) => e.key === "Enter" && handleAddBattery()}
              />
              <button
                onClick={handleAddBattery}
                className="px-4 rounded-xl font-semibold text-white"
                style={{ background: "var(--primary)", minWidth: "60px" }}
              >
                Add
              </button>
            </div>
            <p className="text-xs mt-2" style={{ color: "var(--text-secondary)" }}>
              Find the ID printed on the battery label
            </p>
          </div>
        )}

        {/* Added batteries */}
        {batteries.length > 0 && (
          <div className="mb-6">
            <h3 className="text-sm font-semibold text-white mb-3">
              Batteries to Charge ({batteries.length})
            </h3>
            <div className="space-y-2">
              {batteries.map((b, i) => (
                <div
                  key={i}
                  className="flex items-center justify-between rounded-xl px-4 py-3"
                  style={{ background: "var(--bg-card)" }}
                >
                  <div className="flex items-center gap-3">
                    <span className="text-xl">🔋</span>
                    <span className="font-mono font-semibold text-white">{b}</span>
                  </div>
                  <button
                    onClick={() => setBatteries(batteries.filter((_, idx) => idx !== i))}
                    className="text-sm"
                    style={{ color: "var(--danger)" }}
                  >
                    Remove
                  </button>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Add another */}
        {batteries.length > 0 && (
          <button
            className="btn-ghost mb-4"
            onClick={() => mode === "scan" ? handleScan() : setBatteryId("")}
          >
            + Add Another Battery
          </button>
        )}
      </div>

      {/* Proceed */}
      <div className="px-6 pb-8">
        {batteries.length > 0 ? (
          <button className="btn-primary" onClick={handleProceed}>
            Proceed with {batteries.length} {batteries.length === 1 ? "Battery" : "Batteries"} →
          </button>
        ) : (
          <p className="text-center text-sm" style={{ color: "var(--text-secondary)" }}>
            Scan or enter at least one battery to continue
          </p>
        )}
      </div>
    </div>
  );
}
