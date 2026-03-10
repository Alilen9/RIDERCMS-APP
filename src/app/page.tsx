"use client";

import Link from "next/link";
import { useState } from "react";

const slides = [
  {
    icon: "⚡",
    title: "Power Up Anywhere",
    description: "Find Ridercms stations near you and charge your batteries on the go.",
    color: "#00C896",
  },
  {
    icon: "🗺️",
    title: "Locate Nearby Booths",
    description: "Our map shows real-time availability of charging slots at every station.",
    color: "#3B82F6",
  },
  {
    icon: "💳",
    title: "Pay & Collect Easily",
    description: "Pay via M-Pesa, card, or wallet. Collect your charged batteries instantly.",
    color: "#F59E0B",
  },
];

export default function SplashPage() {
  const [current, setCurrent] = useState(0);

  const next = () => {
    if (current < slides.length - 1) {
      setCurrent(current + 1);
    }
  };

  const slide = slides[current];

  return (
    <div className="min-h-screen flex flex-col" style={{ background: "linear-gradient(180deg, #0A0F1E 0%, #0D1B2A 100%)" }}>
      {/* Skip button */}
      <div className="flex justify-end p-6">
        <Link href="/login" className="text-sm font-medium" style={{ color: "var(--text-secondary)" }}>
          Skip
        </Link>
      </div>

      {/* Main content */}
      <div className="flex-1 flex flex-col items-center justify-center px-8 text-center">
        {/* Logo */}
        <div className="mb-8">
          <div
            className="w-24 h-24 rounded-3xl flex items-center justify-center text-5xl mx-auto mb-4 animate-pulse-glow"
            style={{ background: "linear-gradient(135deg, #00C896, #00A87A)", boxShadow: "0 8px 32px rgba(0,200,150,0.4)" }}
          >
            {slide.icon}
          </div>
          <div className="flex items-center gap-2 justify-center">
            <span className="text-2xl font-bold" style={{ color: "var(--primary)" }}>Ridercms</span>
          </div>
        </div>

        {/* Slide content */}
        <div className="animate-fade-in-up" key={current}>
          <h1 className="text-3xl font-bold text-white mb-4 leading-tight">
            {slide.title}
          </h1>
          <p className="text-base leading-relaxed" style={{ color: "var(--text-secondary)" }}>
            {slide.description}
          </p>
        </div>

        {/* Dots */}
        <div className="flex gap-2 mt-10">
          {slides.map((_, i) => (
            <button
              key={i}
              onClick={() => setCurrent(i)}
              className="rounded-full transition-all duration-300"
              style={{
                width: i === current ? "24px" : "8px",
                height: "8px",
                background: i === current ? "var(--primary)" : "rgba(255,255,255,0.2)",
              }}
            />
          ))}
        </div>
      </div>

      {/* Bottom actions */}
      <div className="p-6 space-y-3">
        {current < slides.length - 1 ? (
          <button className="btn-primary" onClick={next}>
            Next
          </button>
        ) : (
          <Link href="/login" className="block">
            <button className="btn-primary">Get Started</button>
          </Link>
        )}
        {current === 0 && (
          <Link href="/login" className="block">
            <button className="btn-ghost">I already have an account</button>
          </Link>
        )}
      </div>
    </div>
  );
}
