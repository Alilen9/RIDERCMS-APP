"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

const steps = [
  { label: "Connecting to M-Pesa...", duration: 1500 },
  { label: "Sending payment prompt...", duration: 2000 },
  { label: "Waiting for confirmation...", duration: 2500 },
  { label: "Verifying transaction...", duration: 1500 },
  { label: "Payment confirmed! ✅", duration: 1000 },
];

export default function PaymentProcessingPage() {
  const router = useRouter();
  const [currentStep, setCurrentStep] = useState(0);
  const [done, setDone] = useState(false);

  useEffect(() => {
    let total = 0;
    const timers: ReturnType<typeof setTimeout>[] = [];

    steps.forEach((step, i) => {
      total += step.duration;
      timers.push(
        setTimeout(() => {
          setCurrentStep(i);
          if (i === steps.length - 1) {
            setTimeout(() => {
              setDone(true);
              setTimeout(() => router.push("/payment-success"), 800);
            }, 800);
          }
        }, total - step.duration)
      );
    });

    return () => timers.forEach(clearTimeout);
  }, [router]);

  return (
    <div
      className="min-h-screen flex flex-col items-center justify-center px-6"
      style={{ background: "var(--bg-dark)" }}
    >
      {/* Animated circle */}
      <div className="mb-10 relative">
        <div
          className="w-32 h-32 rounded-full flex items-center justify-center"
          style={{
            background: done
              ? "linear-gradient(135deg, #00C896, #00A87A)"
              : "var(--bg-card)",
            border: `3px solid ${done ? "var(--primary)" : "rgba(255,255,255,0.1)"}`,
            transition: "all 0.5s ease",
          }}
        >
          {done ? (
            <span className="text-5xl">✅</span>
          ) : (
            <div className="loader" />
          )}
        </div>

        {/* Pulse rings */}
        {!done && (
          <>
            <div
              className="absolute inset-0 rounded-full animate-ping"
              style={{ background: "rgba(0,200,150,0.1)" }}
            />
          </>
        )}
      </div>

      <h1 className="text-2xl font-bold text-white mb-2 text-center">
        {done ? "Payment Successful!" : "Processing Payment"}
      </h1>
      <p className="text-sm text-center mb-10" style={{ color: "var(--text-secondary)" }}>
        {done ? "Your transaction has been confirmed" : "Please do not close this screen"}
      </p>

      {/* Steps */}
      <div className="w-full max-w-sm space-y-3">
        {steps.map((step, i) => (
          <div key={i} className="flex items-center gap-3">
            <div
              className="w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0 transition-all duration-300"
              style={{
                background: i < currentStep || done
                  ? "var(--primary)"
                  : i === currentStep
                    ? "rgba(0,200,150,0.3)"
                    : "var(--bg-card2)",
                color: i <= currentStep || done ? "white" : "var(--text-secondary)",
              }}
            >
              {i < currentStep || done ? "✓" : i === currentStep ? "●" : i + 1}
            </div>
            <span
              className="text-sm transition-all duration-300"
              style={{
                color: i < currentStep || done
                  ? "var(--primary)"
                  : i === currentStep
                    ? "var(--text-primary)"
                    : "var(--text-secondary)",
                fontWeight: i === currentStep ? "600" : "400",
              }}
            >
              {step.label}
            </span>
          </div>
        ))}
      </div>

      {/* Amount */}
      <div
        className="mt-10 rounded-2xl px-8 py-4 text-center"
        style={{ background: "var(--bg-card)" }}
      >
        <p className="text-xs mb-1" style={{ color: "var(--text-secondary)" }}>Amount</p>
        <p className="text-3xl font-bold" style={{ color: "var(--primary)" }}>KSh 284</p>
        <p className="text-xs mt-1" style={{ color: "var(--text-secondary)" }}>via M-Pesa</p>
      </div>
    </div>
  );
}
