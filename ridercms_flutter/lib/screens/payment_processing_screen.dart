import 'dart:async';
import 'package:flutter/material.dart';
import '../theme.dart';

class _Step {
  final String label;
  final int durationMs;
  const _Step({required this.label, required this.durationMs});
}

const _steps = [
  _Step(label: 'Connecting to M-Pesa...', durationMs: 1500),
  _Step(label: 'Sending payment prompt...', durationMs: 2000),
  _Step(label: 'Waiting for confirmation...', durationMs: 2500),
  _Step(label: 'Verifying transaction...', durationMs: 1500),
  _Step(label: 'Payment confirmed! ✅', durationMs: 1000),
];

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  int _currentStep = 0;
  bool _done = false;
  final List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();
    int total = 0;
    for (int i = 0; i < _steps.length; i++) {
      final idx = i;
      _timers.add(Timer(Duration(milliseconds: total), () {
        if (mounted) setState(() => _currentStep = idx);
        if (idx == _steps.length - 1) {
          _timers.add(Timer(const Duration(milliseconds: 800), () {
            if (mounted) setState(() => _done = true);
            _timers.add(Timer(const Duration(milliseconds: 800), () {
              if (mounted) Navigator.pushReplacementNamed(context, '/payment-success');
            }));
          }));
        }
      }));
      total += _steps[i].durationMs;
    }
  }

  @override
  void dispose() {
    for (final t in _timers) {
      t.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgDark,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated circle
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!_done)
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.8, end: 1.2),
                        duration: const Duration(milliseconds: 1000),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 128,
                              height: 128,
                              decoration: BoxDecoration(
                                color: kPrimary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        },
                      ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        color: _done ? kPrimary : kBgCard,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _done ? kPrimary : Colors.white.withOpacity(0.1),
                          width: 3,
                        ),
                        gradient: _done
                            ? const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [kPrimary, kPrimaryDark],
                              )
                            : null,
                      ),
                      child: Center(
                        child: _done
                            ? const Text('✅', style: TextStyle(fontSize: 48))
                            : const CircularProgressIndicator(color: kPrimary, strokeWidth: 3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                Text(
                  _done ? 'Payment Successful!' : 'Processing Payment',
                  style: const TextStyle(color: kTextPrimary, fontSize: 24, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _done ? 'Your transaction has been confirmed' : 'Please do not close this screen',
                  style: const TextStyle(color: kTextSecondary, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Steps
                ..._steps.asMap().entries.map((entry) {
                  final i = entry.key;
                  final step = entry.value;
                  final isCompleted = i < _currentStep || _done;
                  final isCurrent = i == _currentStep && !_done;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? kPrimary
                                : isCurrent
                                    ? kPrimary.withOpacity(0.3)
                                    : kBgCard2,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              isCompleted ? '✓' : isCurrent ? '●' : '${i + 1}',
                              style: TextStyle(
                                color: isCompleted || isCurrent ? Colors.white : kTextSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          step.label,
                          style: TextStyle(
                            color: isCompleted
                                ? kPrimary
                                : isCurrent
                                    ? kTextPrimary
                                    : kTextSecondary,
                            fontSize: 13,
                            fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 40),

                // Amount
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(color: kBgCard, borderRadius: BorderRadius.circular(16)),
                  child: const Column(
                    children: [
                      Text('Amount', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                      SizedBox(height: 4),
                      Text('KSh 284', style: TextStyle(color: kPrimary, fontSize: 32, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4),
                      Text('via M-Pesa', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
