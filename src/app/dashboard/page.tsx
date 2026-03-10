"use client";

import Link from "next/link";

const recentSessions = [
  { id: "S001", date: "Mar 8", batteries: 2, amount: "KSh 120", status: "Completed" },
  { id: "S002", date: "Mar 5", batteries: 1, amount: "KSh 60", status: "Completed" },
  { id: "S003", date: "Feb 28", batteries: 3, amount: "KSh 180", status: "Completed" },
];

const stats = [
  { label: "Sessions", value: "24", icon: "⚡" },
  { label: "Batteries", value: "47", icon: "🔋" },
  { label: "Saved (KSh)", value: "2,840", icon: "💰" },
];

export default function DashboardPage() {
  return (
    <div className="min-h-screen pb-24" style={{ background: "var(--bg-dark)" }}>
      {/* Header */}
      <div
        className="px-6 pt-12 pb-8"
        style={{ background: "linear-gradient(180deg, #0D1B2A 0%, var(--bg-dark) 100%)" }}
      >
        <div className="flex items-center justify-between mb-6">
          <div>
            <p className="text-sm mb-1" style={{ color: "var(--text-secondary)" }}>Good morning,</p>
            <h1 className="text-2xl font-bold text-white">John Doe 👋</h1>
          </div>
          <div className="relative">
            <div
              className="w-12 h-12 rounded-2xl flex items-center justify-center text-xl"
              style={{ background: "var(--bg-card)" }}
            >
              🔔
            </div>
            <div
              className="absolute -top-1 -right-1 w-4 h-4 rounded-full flex items-center justify-center text-xs font-bold text-white"
              style={{ background: "var(--danger)" }}
            >
              2
            </div>
          </div>
        </div>

        {/* Wallet card */}
        <div
          className="rounded-2xl p-5"
          style={{ background: "linear-gradient(135deg, #00C896, #00A87A)", boxShadow: "0 8px 32px rgba(0,200,150,0.3)" }}
        >
          <div className="flex items-center justify-between mb-4">
            <div>
              <p className="text-sm text-white/70 mb-1">Wallet Balance</p>
              <p className="text-3xl font-bold text-white">KSh 1,250</p>
            </div>
            <div className="w-12 h-12 rounded-2xl flex items-center justify-center text-2xl" style={{ background: "rgba(255,255,255,0.2)" }}>
              💳
            </div>
          </div>
          <div className="flex gap-3">
            <button
              className="flex-1 py-2 rounded-xl text-sm font-semibold text-white"
              style={{ background: "rgba(255,255,255,0.2)" }}
            >
              + Top Up
            </button>
            <button
              className="flex-1 py-2 rounded-xl text-sm font-semibold text-white"
              style={{ background: "rgba(255,255,255,0.2)" }}
            >
              History
            </button>
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="px-6 mb-6">
        <div className="grid grid-cols-3 gap-3">
          {stats.map((stat) => (
            <div key={stat.label} className="card text-center">
              <div className="text-2xl mb-1">{stat.icon}</div>
              <div className="text-xl font-bold text-white">{stat.value}</div>
              <div className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>{stat.label}</div>
            </div>
          ))}
        </div>
      </div>

      {/* Quick Actions */}
      <div className="px-6 mb-6">
        <h2 className="text-lg font-bold text-white mb-4">Quick Actions</h2>
        <div className="grid grid-cols-2 gap-3">
          <Link href="/map">
            <div
              className="rounded-2xl p-5 flex flex-col gap-3 cursor-pointer transition-all hover:scale-105"
              style={{ background: "linear-gradient(135deg, #1a2744, #1e3a5f)" }}
            >
              <div className="text-3xl">🗺️</div>
              <div>
                <div className="font-semibold text-white text-sm">Find Booth</div>
                <div className="text-xs mt-0.5" style={{ color: "var(--text-secondary)" }}>Locate nearby stations</div>
              </div>
            </div>
          </Link>
          <Link href="/scan">
            <div
              className="rounded-2xl p-5 flex flex-col gap-3 cursor-pointer transition-all hover:scale-105"
              style={{ background: "linear-gradient(135deg, #1a2a1a, #1e4a2a)" }}
            >
              <div className="text-3xl">📷</div>
              <div>
                <div className="font-semibold text-white text-sm">Scan Battery</div>
                <div className="text-xs mt-0.5" style={{ color: "var(--text-secondary)" }}>Start charging now</div>
              </div>
            </div>
          </Link>
          <Link href="/charging">
            <div
              className="rounded-2xl p-5 flex flex-col gap-3 cursor-pointer transition-all hover:scale-105"
              style={{ background: "linear-gradient(135deg, #2a1a1a, #4a2a1e)" }}
            >
              <div className="text-3xl">⚡</div>
              <div>
                <div className="font-semibold text-white text-sm">Active Session</div>
                <div className="text-xs mt-0.5" style={{ color: "var(--text-secondary)" }}>View charging status</div>
              </div>
            </div>
          </Link>
          <div
            className="rounded-2xl p-5 flex flex-col gap-3 cursor-pointer transition-all hover:scale-105"
            style={{ background: "linear-gradient(135deg, #1a1a2a, #2a1e4a)" }}
          >
            <div className="text-3xl">🎁</div>
            <div>
              <div className="font-semibold text-white text-sm">Rewards</div>
              <div className="text-xs mt-0.5" style={{ color: "var(--text-secondary)" }}>240 points earned</div>
            </div>
          </div>
        </div>
      </div>

      {/* Recent Sessions */}
      <div className="px-6">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-bold text-white">Recent Sessions</h2>
          <button className="text-sm font-medium" style={{ color: "var(--primary)" }}>See all</button>
        </div>
        <div className="space-y-3">
          {recentSessions.map((session) => (
            <div key={session.id} className="card flex items-center justify-between">
              <div className="flex items-center gap-3">
                <div
                  className="w-10 h-10 rounded-xl flex items-center justify-center text-lg"
                  style={{ background: "rgba(0,200,150,0.15)" }}
                >
                  ⚡
                </div>
                <div>
                  <div className="font-semibold text-white text-sm">Session #{session.id}</div>
                  <div className="text-xs mt-0.5" style={{ color: "var(--text-secondary)" }}>
                    {session.date} · {session.batteries} {session.batteries === 1 ? "battery" : "batteries"}
                  </div>
                </div>
              </div>
              <div className="text-right">
                <div className="font-bold text-white text-sm">{session.amount}</div>
                <div className="text-xs mt-0.5" style={{ color: "var(--primary)" }}>{session.status}</div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Bottom Nav */}
      <div
        className="fixed bottom-0 left-1/2 -translate-x-1/2 w-full max-w-[430px] px-6 py-4"
        style={{ background: "var(--bg-card)", borderTop: "1px solid rgba(255,255,255,0.06)" }}
      >
        <div className="flex justify-around">
          {[
            { icon: "🏠", label: "Home", href: "/dashboard", active: true },
            { icon: "🗺️", label: "Map", href: "/map", active: false },
            { icon: "⚡", label: "Charge", href: "/scan", active: false },
            { icon: "👤", label: "Profile", href: "#", active: false },
          ].map((item) => (
            <Link key={item.label} href={item.href}>
              <div className="flex flex-col items-center gap-1">
                <span className="text-xl">{item.icon}</span>
                <span
                  className="text-xs font-medium"
                  style={{ color: item.active ? "var(--primary)" : "var(--text-secondary)" }}
                >
                  {item.label}
                </span>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
}
