import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';

class SessionCompleteScreen extends StatefulWidget {
  const SessionCompleteScreen({super.key});

  @override
  State<SessionCompleteScreen> createState() => _SessionCompleteScreenState();
}

class _SessionCompleteScreenState extends State<SessionCompleteScreen> {
  int _rating = 0;

  static const _batteries = [
    {'id': 'BATT102', 'slot': 'A03', 'chargeTime': '1h 52m', 'startCharge': 45, 'endCharge': 100, 'fee': 112},
    {'id': 'BATT103', 'slot': 'A04', 'chargeTime': '2h 38m', 'startCharge': 22, 'endCharge': 100, 'fee': 158},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgDark,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [
                  // Success header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF0d2a1a), kBgDark],
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [kPrimary, kPrimaryDark],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: kPrimary.withOpacity(0.4), blurRadius: 32, offset: const Offset(0, 8))],
                          ),
                          child: const Center(child: Text('🎉', style: TextStyle(fontSize: 36))),
                        ),
                        const SizedBox(height: 16),
                        const Text('Session Complete!', style: TextStyle(color: kTextPrimary, fontSize: 24, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        const Text('Session #S004 · Mar 10, 2026', style: TextStyle(color: kTextSecondary, fontSize: 13)),
                        const SizedBox(height: 2),
                        const Text('Westlands Station', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Batteries charged
                        const Text('BATTERIES CHARGED', style: TextStyle(color: kTextSecondary, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                        const SizedBox(height: 12),
                        ..._batteries.map((battery) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AppCard(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: kPrimary.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(child: Text('🔋', style: TextStyle(fontSize: 20))),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(battery['id']! as String, style: const TextStyle(color: kTextPrimary, fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
                                          Text('Slot ${battery['slot']}', style: const TextStyle(color: kTextSecondary, fontSize: 11)),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('KSh ${battery['fee']}', style: const TextStyle(color: kTextPrimary, fontSize: 13, fontWeight: FontWeight.w700)),
                                        Text(battery['chargeTime']! as String, style: const TextStyle(color: kTextSecondary, fontSize: 11)),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text('${battery['startCharge']}%', style: const TextStyle(color: kWarning, fontSize: 11, fontWeight: FontWeight.w600)),
                                    const SizedBox(width: 8),
                                    const Expanded(child: AppProgressBar(value: 1.0)),
                                    const SizedBox(width: 8),
                                    Text('${battery['endCharge']}%', style: const TextStyle(color: kPrimary, fontSize: 11, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),

                        const SizedBox(height: 8),

                        // Payment summary
                        const Text('PAYMENT SUMMARY', style: TextStyle(color: kTextSecondary, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                        const SizedBox(height: 12),
                        AppCard(
                          child: Column(
                            children: [
                              _SummaryRow(label: 'Subtotal', value: 'KSh 270'),
                              const SizedBox(height: 8),
                              _SummaryRow(label: 'Service Fee', value: 'KSh 14'),
                              const SizedBox(height: 12),
                              Divider(color: Colors.white.withOpacity(0.06), height: 1),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total Paid', style: TextStyle(color: kTextPrimary, fontWeight: FontWeight.w700)),
                                  const Text('KSh 284', style: TextStyle(color: kPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _SummaryRow(label: 'Payment Method', value: 'M-Pesa'),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Transaction ID', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                                  const Text('MPE240310001234', style: TextStyle(color: kTextSecondary, fontSize: 12, fontFamily: 'monospace')),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Stats
                        Row(
                          children: [
                            Expanded(child: _StatCard(icon: '🔋', value: '2', label: 'Batteries')),
                            const SizedBox(width: 12),
                            Expanded(child: _StatCard(icon: '⏱️', value: '2h 38m', label: 'Total Time')),
                            const SizedBox(width: 12),
                            Expanded(child: _StatCard(icon: '⚡', value: '133%', label: 'Charged')),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Rating
                        AppCard(
                          child: Column(
                            children: [
                              const Text('Rate this session', style: TextStyle(color: kTextPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (i) {
                                  return GestureDetector(
                                    onTap: () => setState(() => _rating = i + 1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        '⭐',
                                        style: TextStyle(
                                          fontSize: 32,
                                          color: i < _rating ? null : Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed bottom actions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              decoration: BoxDecoration(
                color: kBgCard,
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryButton(
                    label: '⚡ Start New Session',
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/scan', (route) => false),
                  ),
                  const SizedBox(height: 12),
                  GhostButton(
                    label: 'Return Home',
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: kTextSecondary, fontSize: 12)),
        Text(value, style: const TextStyle(color: kTextSecondary, fontSize: 12)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  const _StatCard({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: kTextPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: kTextSecondary, fontSize: 11)),
        ],
      ),
    );
  }
}
