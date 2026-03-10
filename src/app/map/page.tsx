"use client";

import Link from "next/link";
import { useState } from "react";

const booths = [
  {
    id: "B001",
    name: "Westlands Station",
    distance: "0.3 km",
    slots: { available: 4, total: 8 },
    address: "Westlands Rd, Nairobi",
    status: "available",
    rating: 4.8,
  },
  {
    id: "B002",
    name: "CBD Hub",
    distance: "1.2 km",
    slots: { available: 0, total: 6 },
    address: "Kenyatta Ave, Nairobi",
    status: "full",
    rating: 4.5,
  },
  {
    id: "B003",
    name: "Kilimani Point",
    distance: "2.1 km",
    slots: { available: 2, total: 10 },
    address: "Argwings Kodhek Rd",
    status: "available",
    rating: 4.7,
  },
  {
    id: "B004",
    name: "Karen Mall",
    distance: "5.4 km",
    slots: { available: 6, total: 8 },
    address: "Karen Shopping Centre",
    status: "available",
    rating: 4.9,
  },
];

export default function MapPage() {
  const [selectedBooth, setSelectedBooth] = useState<string | null>(null);
  const [showFullModal, setShowFullModal] = useState(false);

  const selected = booths.find((b) => b.id === selectedBooth);

  const handleSelectBooth = (booth: typeof booths[0]) => {
    if (booth.status === "full") {
      setSelectedBooth(booth.id);
      setShowFullModal(true);
    } else {
      setSelectedBooth(booth.id);
    }
  };

  return (
    <div className="min-h-screen flex flex-col" style={{ background: "var(--bg-dark)" }}>
      {/* Header */}
      <div className="flex items-center gap-4 px-6 pt-12 pb-4">
        <Link href="/dashboard">
          <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: "var(--bg-card)" }}>
            ←
          </div>
        </Link>
        <div className="flex-1">
          <h1 className="text-xl font-bold text-white">Find a Booth</h1>
          <p className="text-xs" style={{ color: "var(--text-secondary)" }}>4 stations nearby</p>
        </div>
        <div
          className="w-10 h-10 rounded-xl flex items-center justify-center"
          style={{ background: "var(--bg-card)" }}
        >
          🔍
        </div>
      </div>

      {/* Search bar */}
      <div className="px-6 mb-4">
        <input
          type="text"
          className="input-field"
          placeholder="Search by location or booth name..."
        />
      </div>

      {/* Map placeholder */}
      <div
        className="mx-6 rounded-2xl overflow-hidden mb-4 relative"
        style={{ height: "220px", background: "linear-gradient(135deg, #0d1b2a, #1a2744)" }}
      >
        {/* Fake map grid */}
        <div className="absolute inset-0 opacity-20">
          {Array.from({ length: 8 }).map((_, i) => (
            <div
              key={i}
              className="absolute w-full"
              style={{ top: `${i * 30}px`, height: "1px", background: "rgba(255,255,255,0.3)" }}
            />
          ))}
          {Array.from({ length: 8 }).map((_, i) => (
            <div
              key={i}
              className="absolute h-full"
              style={{ left: `${i * 55}px`, width: "1px", background: "rgba(255,255,255,0.3)" }}
            />
          ))}
        </div>

        {/* Map pins */}
        <div className="absolute" style={{ top: "60px", left: "80px" }}>
          <div
            className="w-10 h-10 rounded-full flex items-center justify-center text-lg cursor-pointer"
            style={{ background: "var(--primary)", boxShadow: "0 4px 16px rgba(0,200,150,0.5)" }}
            onClick={() => handleSelectBooth(booths[0])}
          >
            ⚡
          </div>
        </div>
        <div className="absolute" style={{ top: "100px", left: "180px" }}>
          <div
            className="w-10 h-10 rounded-full flex items-center justify-center text-lg cursor-pointer"
            style={{ background: "var(--danger)", boxShadow: "0 4px 16px rgba(239,68,68,0.5)" }}
            onClick={() => handleSelectBooth(booths[1])}
          >
            ⚡
          </div>
        </div>
        <div className="absolute" style={{ top: "140px", left: "260px" }}>
          <div
            className="w-10 h-10 rounded-full flex items-center justify-center text-lg cursor-pointer"
            style={{ background: "var(--primary)", boxShadow: "0 4px 16px rgba(0,200,150,0.5)" }}
            onClick={() => handleSelectBooth(booths[2])}
          >
            ⚡
          </div>
        </div>

        {/* You are here */}
        <div className="absolute" style={{ top: "90px", left: "130px" }}>
          <div
            className="w-6 h-6 rounded-full border-4 border-white animate-pulse-glow"
            style={{ background: "var(--accent)" }}
          />
        </div>

        {/* Legend */}
        <div
          className="absolute bottom-3 right-3 rounded-xl px-3 py-2 flex gap-3 text-xs"
          style={{ background: "rgba(0,0,0,0.6)" }}
        >
          <span className="flex items-center gap-1">
            <span className="w-2 h-2 rounded-full inline-block" style={{ background: "var(--primary)" }} />
            Available
          </span>
          <span className="flex items-center gap-1">
            <span className="w-2 h-2 rounded-full inline-block" style={{ background: "var(--danger)" }} />
            Full
          </span>
        </div>
      </div>

      {/* Booth list */}
      <div className="flex-1 px-6 space-y-3 pb-6">
        <h2 className="text-base font-semibold text-white">Nearby Stations</h2>
        {booths.map((booth) => (
          <div
            key={booth.id}
            className="card cursor-pointer transition-all"
            style={{
              border: selectedBooth === booth.id ? "1.5px solid var(--primary)" : "1px solid rgba(255,255,255,0.06)",
            }}
            onClick={() => handleSelectBooth(booth)}
          >
            <div className="flex items-start justify-between">
              <div className="flex items-start gap-3">
                <div
                  className="w-12 h-12 rounded-xl flex items-center justify-center text-xl flex-shrink-0"
                  style={{
                    background: booth.status === "full" ? "rgba(239,68,68,0.15)" : "rgba(0,200,150,0.15)",
                  }}
                >
                  ⚡
                </div>
                <div>
                  <div className="font-semibold text-white text-sm">{booth.name}</div>
                  <div className="text-xs mt-0.5" style={{ color: "var(--text-secondary)" }}>{booth.address}</div>
                  <div className="flex items-center gap-2 mt-2">
                    <span
                      className="status-badge"
                      style={{
                        background: booth.status === "full" ? "rgba(239,68,68,0.15)" : "rgba(0,200,150,0.15)",
                        color: booth.status === "full" ? "var(--danger)" : "var(--primary)",
                        fontSize: "11px",
                        padding: "3px 8px",
                      }}
                    >
                      {booth.status === "full" ? "🔴 Full" : `🟢 ${booth.slots.available} slots free`}
                    </span>
                    <span className="text-xs" style={{ color: "var(--text-secondary)" }}>⭐ {booth.rating}</span>
                  </div>
                </div>
              </div>
              <div className="text-right flex-shrink-0">
                <div className="text-sm font-semibold" style={{ color: "var(--primary)" }}>{booth.distance}</div>
                <div className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>
                  {booth.slots.available}/{booth.slots.total} slots
                </div>
              </div>
            </div>

            {selectedBooth === booth.id && booth.status !== "full" && (
              <div className="mt-4">
                <Link href="/scan">
                  <button className="btn-primary" style={{ padding: "12px" }}>
                    Select This Booth →
                  </button>
                </Link>
              </div>
            )}
          </div>
        ))}
      </div>

      {/* Full booth modal */}
      {showFullModal && selected?.status === "full" && (
        <div
          className="fixed inset-0 flex items-end justify-center z-50"
          style={{ background: "rgba(0,0,0,0.7)" }}
          onClick={() => setShowFullModal(false)}
        >
          <div
            className="w-full max-w-[430px] rounded-t-3xl p-6"
            style={{ background: "var(--bg-card)" }}
            onClick={(e) => e.stopPropagation()}
          >
            <div className="w-12 h-1 rounded-full mx-auto mb-6" style={{ background: "rgba(255,255,255,0.2)" }} />
            <div className="text-center mb-6">
              <div className="text-4xl mb-3">😔</div>
              <h3 className="text-xl font-bold text-white mb-2">Booth is Full</h3>
              <p className="text-sm" style={{ color: "var(--text-secondary)" }}>
                <strong style={{ color: "white" }}>{selected.name}</strong> has no available slots right now.
              </p>
            </div>
            <div className="space-y-3">
              <button
                className="btn-primary"
                onClick={() => {
                  setShowFullModal(false);
                  setSelectedBooth(null);
                }}
              >
                Try Another Booth
              </button>
              <button
                className="btn-secondary"
                onClick={() => setShowFullModal(false)}
              >
                Join Queue (Est. 15 min)
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
