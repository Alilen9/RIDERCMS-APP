"use client";

import Link from "next/link";
import { useState } from "react";
import { useRouter } from "next/navigation";

const batteries = [
  { id: "BATT102", slot: "A03", chargeTime: "1h 52m", fee: 112 },
  { id: "BATT103", slot: "A04", chargeTime: "2h 38m", fee: 158 },
];

const paymentMethods = [
  { id: "mpesa", label: "M-Pesa", icon: "📱", description: "Pay via M-Pesa mobile money" },
  { id: "card", label: "Card", icon: "💳", description: "Visa / Mastercard" },
  { id: "wallet", label: "Wallet", icon: "👛", description: "Balance: KSh 1,250" },
];

export default function PaymentPage() {
  const router = useRouter();
  const [selectedMethod, setSelectedMethod] = useState("mpesa");
  const [mpesaPhone, setMpesaPhone] = useState("+254 700 000 000");

  const total = batteries.reduce((sum, b) => sum + b.fee, 0);
  const serviceFee = Math.round(total * 0.05);
  const grandTotal = total + serviceFee;

  const handlePay = () => {
    router.push("/payment-processing");
  };

  return (
    <div className="min-h-screen flex flex-col pb-32" style={{ background: "var(--bg-dark)" }}>
      {/* Header */}
      <div className="flex items-center gap-4 px-6 pt-12 pb-6">
        <Link href="/battery-ready">
          <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: "var(--bg-card)" }}>
            ←
          </div>
        </Link>
        <div>
          <h1 className="text-xl font-bold text-white">Payment</h1>
          <p className="text-xs" style={{ color: "var(--text-secondary)" }}>Session #S004</p>
        </div>
      </div>

      {/* Battery breakdown */}
      <div className="px-6 mb-6">
        <h3 className="text-sm font-semibold mb-3" style={{ color: "var(--text-secondary)" }}>
          CHARGING SUMMARY
        </h3>
        <div className="card space-y-3">
          {batteries.map((battery, i) => (
            <div key={battery.id}>
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <span className="text-xl">🔋</span>
                  <div>
                    <div className="font-semibold text-white text-sm font-mono">{battery.id}</div>
                    <div className="text-xs" style={{ color: "var(--text-secondary)" }}>
                      Slot {battery.slot} · {battery.chargeTime}
                    </div>
                  </div>
                </div>
                <div className="font-bold text-white">KSh {battery.fee}</div>
              </div>
              {i < batteries.length - 1 && (
                <div className="mt-3 h-px" style={{ background: "rgba(255,255,255,0.06)" }} />
              )}
            </div>
          ))}

          <div className="h-px" style={{ background: "rgba(255,255,255,0.06)" }} />

          <div className="flex justify-between text-sm">
            <span style={{ color: "var(--text-secondary)" }}>Subtotal</span>
            <span className="text-white">KSh {total}</span>
          </div>
          <div className="flex justify-between text-sm">
            <span style={{ color: "var(--text-secondary)" }}>Service Fee (5%)</span>
            <span className="text-white">KSh {serviceFee}</span>
          </div>
          <div className="h-px" style={{ background: "rgba(255,255,255,0.06)" }} />
          <div className="flex justify-between">
            <span className="font-bold text-white">Total</span>
            <span className="font-bold text-xl" style={{ color: "var(--primary)" }}>KSh {grandTotal}</span>
          </div>
        </div>
      </div>

      {/* Payment methods */}
      <div className="px-6 mb-6">
        <h3 className="text-sm font-semibold mb-3" style={{ color: "var(--text-secondary)" }}>
          PAYMENT METHOD
        </h3>
        <div className="space-y-3">
          {paymentMethods.map((method) => (
            <div
              key={method.id}
              className="card cursor-pointer transition-all"
              style={{
                border: selectedMethod === method.id
                  ? "1.5px solid var(--primary)"
                  : "1px solid rgba(255,255,255,0.06)",
              }}
              onClick={() => setSelectedMethod(method.id)}
            >
              <div className="flex items-center gap-3">
                <div
                  className="w-12 h-12 rounded-xl flex items-center justify-center text-2xl flex-shrink-0"
                  style={{
                    background: selectedMethod === method.id
                      ? "rgba(0,200,150,0.15)"
                      : "var(--bg-card2)",
                  }}
                >
                  {method.icon}
                </div>
                <div className="flex-1">
                  <div className="font-semibold text-white">{method.label}</div>
                  <div className="text-xs mt-0.5" style={{ color: "var(--text-secondary)" }}>
                    {method.description}
                  </div>
                </div>
                <div
                  className="w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0"
                  style={{
                    borderColor: selectedMethod === method.id ? "var(--primary)" : "rgba(255,255,255,0.2)",
                    background: selectedMethod === method.id ? "var(--primary)" : "transparent",
                  }}
                >
                  {selectedMethod === method.id && (
                    <div className="w-2 h-2 rounded-full bg-white" />
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* M-Pesa phone input */}
      {selectedMethod === "mpesa" && (
        <div className="px-6 mb-6">
          <label className="block text-sm font-medium mb-2" style={{ color: "var(--text-secondary)" }}>
            M-Pesa Phone Number
          </label>
          <input
            type="tel"
            className="input-field"
            value={mpesaPhone}
            onChange={(e) => setMpesaPhone(e.target.value)}
          />
          <p className="text-xs mt-2" style={{ color: "var(--text-secondary)" }}>
            You will receive an M-Pesa prompt on this number
          </p>
        </div>
      )}

      {/* Pay button */}
      <div className="fixed bottom-0 left-1/2 -translate-x-1/2 w-full max-w-[430px] px-6 py-4" style={{ background: "var(--bg-card)", borderTop: "1px solid rgba(255,255,255,0.06)" }}>
        <div className="flex items-center justify-between mb-3">
          <span className="text-sm" style={{ color: "var(--text-secondary)" }}>Total to Pay</span>
          <span className="text-xl font-bold" style={{ color: "var(--primary)" }}>KSh {grandTotal}</span>
        </div>
        <button className="btn-primary" onClick={handlePay}>
          Pay KSh {grandTotal} via {paymentMethods.find((m) => m.id === selectedMethod)?.label}
        </button>
      </div>
    </div>
  );
}
