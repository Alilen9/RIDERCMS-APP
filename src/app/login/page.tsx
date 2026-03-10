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
            <span className="text-xl font-bold" style={{ color: "var(--primary)" }}>Ridercms</span>
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
              : "Join Ridercms and start charging"}
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
            onClick={() => router.push("/dashboard")}
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
              <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
              <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05"/>
              <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
            </svg>
            Google
          </button>
          <button
            className="flex items-center justify-center gap-2 py-3 rounded-xl font-medium text-sm"
            style={{ background: "var(--bg-card)", border: "1px solid rgba(255,255,255,0.1)", color: "var(--text-primary)" }}
            onClick={() => router.push("/dashboard")}
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="#1877F2" xmlns="http://www.w3.org/2000/svg">
              <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
            </svg>
            Facebook
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
