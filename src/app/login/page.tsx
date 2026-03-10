"use client";

import Link from "next/link";
import { useState } from "react";
import { useRouter } from "next/navigation";

export default function LoginPage() {
  const router = useRouter();
  const [mode, setMode] = useState<"login" | "signup">("login");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    router.push("/dashboard");
  };

  return (
    <div className="min-h-screen flex flex-col" style={{ background: "linear-gradient(180deg, #0A0F1E 0%, #0D1B2A 100%)" }}>
      {/* Header */}
      <div className="flex items-center p-6">
        <Link href="/" className="mr-4">
          <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: "var(--bg-card2)" }}>
            <span className="text-lg">←</span>
          </div>
        </Link>
        <div>
          <div className="flex items-center gap-1">
            <span className="text-xl font-bold" style={{ color: "var(--primary)" }}>Charge</span>
            <span className="text-xl font-bold text-white">Pod</span>
          </div>
        </div>
      </div>

      {/* Toggle */}
      <div className="px-6 mb-6">
        <div className="flex rounded-2xl p-1" style={{ background: "var(--bg-card)" }}>
          <button
            onClick={() => setMode("login")}
            className="flex-1 py-3 rounded-xl text-sm font-semibold transition-all duration-200"
            style={{
              background: mode === "login" ? "var(--primary)" : "transparent",
              color: mode === "login" ? "white" : "var(--text-secondary)",
            }}
          >
            Log In
          </button>
          <button
            onClick={() => setMode("signup")}
            className="flex-1 py-3 rounded-xl text-sm font-semibold transition-all duration-200"
            style={{
              background: mode === "signup" ? "var(--primary)" : "transparent",
              color: mode === "signup" ? "white" : "var(--text-secondary)",
            }}
          >
            Sign Up
          </button>
        </div>
      </div>

      {/* Form */}
      <div className="flex-1 px-6">
        <div className="mb-6">
          <h1 className="text-2xl font-bold text-white mb-1">
            {mode === "login" ? "Welcome back! 👋" : "Create account 🚀"}
          </h1>
          <p style={{ color: "var(--text-secondary)", fontSize: "14px" }}>
            {mode === "login"
              ? "Sign in to continue charging"
              : "Join ChargePod and start charging"}
          </p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          {mode === "signup" && (
            <div>
              <label className="block text-sm font-medium mb-2" style={{ color: "var(--text-secondary)" }}>
                Full Name
              </label>
              <input
                type="text"
                className="input-field"
                placeholder="John Doe"
                value={name}
                onChange={(e) => setName(e.target.value)}
                required
              />
            </div>
          )}

          <div>
            <label className="block text-sm font-medium mb-2" style={{ color: "var(--text-secondary)" }}>
              Email Address
            </label>
            <input
              type="email"
              className="input-field"
              placeholder="you@example.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>

          {mode === "signup" && (
            <div>
              <label className="block text-sm font-medium mb-2" style={{ color: "var(--text-secondary)" }}>
                Phone Number
              </label>
              <input
                type="tel"
                className="input-field"
                placeholder="+254 700 000 000"
                value={phone}
                onChange={(e) => setPhone(e.target.value)}
                required
              />
            </div>
          )}

          <div>
            <label className="block text-sm font-medium mb-2" style={{ color: "var(--text-secondary)" }}>
              Password
            </label>
            <input
              type="password"
              className="input-field"
              placeholder="••••••••"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>

          {mode === "login" && (
            <div className="text-right">
              <button type="button" className="text-sm font-medium" style={{ color: "var(--primary)" }}>
                Forgot password?
              </button>
            </div>
          )}

          <div className="pt-2">
            <button type="submit" className="btn-primary">
              {mode === "login" ? "Log In" : "Create Account"}
            </button>
          </div>
        </form>

        {/* Divider */}
        <div className="flex items-center gap-4 my-6">
          <div className="flex-1 h-px" style={{ background: "rgba(255,255,255,0.1)" }} />
          <span className="text-sm" style={{ color: "var(--text-secondary)" }}>or continue with</span>
          <div className="flex-1 h-px" style={{ background: "rgba(255,255,255,0.1)" }} />
        </div>

        {/* Social buttons */}
        <div className="grid grid-cols-2 gap-3">
          <button
            className="flex items-center justify-center gap-2 py-3 rounded-xl font-medium text-sm"
            style={{ background: "var(--bg-card)", border: "1px solid rgba(255,255,255,0.1)", color: "var(--text-primary)" }}
          >
            <span>🇬</span> Google
          </button>
          <button
            className="flex items-center justify-center gap-2 py-3 rounded-xl font-medium text-sm"
            style={{ background: "var(--bg-card)", border: "1px solid rgba(255,255,255,0.1)", color: "var(--text-primary)" }}
          >
            <span>📱</span> M-Pesa
          </button>
        </div>
      </div>

      <div className="p-6 text-center">
        <p className="text-xs" style={{ color: "var(--text-secondary)" }}>
          By continuing, you agree to our{" "}
          <span style={{ color: "var(--primary)" }}>Terms of Service</span> and{" "}
          <span style={{ color: "var(--primary)" }}>Privacy Policy</span>
        </p>
      </div>
    </div>
  );
}
