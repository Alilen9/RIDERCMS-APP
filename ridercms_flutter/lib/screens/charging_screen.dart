import 'dart:async';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';

class _Battery {
  final String id;
  final String slot;
  double charge;
  final int estimatedHours;
  final int estimatedMins;

  _Battery({
    required this.id,
    required this.slot,
    required this.charge,
    required this.estimatedHours,
    required this.estimatedMins,
  });
}

class ChargingScreen extends StatefulWidget {
  const ChargingScreen({super.key});

  @override
  State<ChargingScreen> createState() => _ChargingScreenState();
}

class _ChargingScreenState extends State<ChargingScreen> {
  int _elapsed = 0;
  Timer? _timer;

  final List<_Battery> _batteries = [
    _Battery(id: 'BATT102', slot: 'A03', charge: 45, estimatedHours: 2, estimatedMins: 0),
    _Battery(id: 'BATT103', slot: 'A04', charge: 22, estimatedHours: 2, estimatedMins: 45),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _elapsed++;
          for (final b in _batteries) {
            b.charge = (b.charge + 0.1).clamp(0, 100);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int secs) {
    final m = secs ~/ 60;
    final s = secs % 60;
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgDark,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                    child: Row(
                      children: [
                        const BackBtn(),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Charging Session', style: TextStyle(color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                              Text('Westlands Station · Active', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: kPrimary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(color: kPrimary, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 6),
                              const Text('LIVE', style: TextStyle(color: kPrimary, fontSize: 11, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Session timer
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: AppCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Session Duration', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                              const SizedBox(height: 4),
                              Text(
                                _formatTime(_elapsed),
                                style: const TextStyle(color: kTextPrimary, fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Batteries Charging', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                              const SizedBox(height: 4),
                              Text(
                                '${_batteries.length}',
                                style: const TextStyle(color: kTextPrimary, fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Battery cards
                  ..._batteries.map((battery) => Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: AppCard(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: kWarning.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(child: Text('🔋', style: TextStyle(fontSize: 24))),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(battery.id, style: const TextStyle(color: kTextPrimary, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
                                    const SizedBox(height: 2),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(color: kTextSecondary, fontSize: 12),
                                        children: [
                                          const TextSpan(text: 'Slot: '),
                                          TextSpan(text: battery.slot, style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: kWarning.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text('⚡ Charging', style: TextStyle(color: kWarning, fontSize: 11, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Charge progress
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Charge Level', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                              Text(
                                '${battery.charge.toStringAsFixed(1)}%',
                                style: const TextStyle(color: kPrimary, fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AppProgressBar(value: battery.charge / 100),
                          const SizedBox(height: 12),

                          // Stats row
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(color: kBgCard2, borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    children: [
                                      const Text('Est. Time', style: TextStyle(color: kTextSecondary, fontSize: 11)),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${battery.estimatedHours}h${battery.estimatedMins > 0 ? ' ${battery.estimatedMins}m' : ''}',
                                        style: const TextStyle(color: kTextPrimary, fontSize: 13, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(color: kBgCard2, borderRadius: BorderRadius.circular(12)),
                                  child: const Column(
                                    children: [
                                      Text('Rate', style: TextStyle(color: kTextSecondary, fontSize: 11)),
                                      SizedBox(height: 4),
                                      Text('KSh 60/hr', style: TextStyle(color: kTextPrimary, fontSize: 13, fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),

                  // Add another battery
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: GhostButton(
                      label: '+ Add Another Battery',
                      onPressed: () => Navigator.pushNamed(context, '/scan'),
                    ),
                  ),

                  // Notification banner
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: kAccent.withOpacity(0.2)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('🔔', style: TextStyle(fontSize: 20)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Notifications Enabled', style: TextStyle(color: kAccent, fontSize: 13, fontWeight: FontWeight.w600)),
                                SizedBox(height: 4),
                                Text(
                                  "You'll be notified when your batteries are fully charged and ready for collection.",
                                  style: TextStyle(color: kTextSecondary, fontSize: 12, height: 1.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom action
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
              child: PrimaryButton(
                label: 'Simulate: Battery Ready 🔔',
                onPressed: () => Navigator.pushNamed(context, '/battery-ready'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
