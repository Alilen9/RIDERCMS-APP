import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';

class CollectScreen extends StatefulWidget {
  const CollectScreen({super.key});

  @override
  State<CollectScreen> createState() => _CollectScreenState();
}

class _CollectScreenState extends State<CollectScreen> {
  static const _batteries = [
    {'id': 'BATT102', 'slot': 'A03'},
    {'id': 'BATT103', 'slot': 'A04'},
  ];

  final Set<String> _collected = {};

  bool get _allCollected => _collected.length == _batteries.length;

  void _toggle(String id) {
    setState(() {
      if (_collected.contains(id)) {
        _collected.remove(id);
      } else {
        _collected.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: Row(
                children: [
                  const BackBtn(),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Collect Batteries', style: TextStyle(color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                      Text('Westlands Station', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Instruction banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kPrimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: kPrimary.withOpacity(0.2)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('🔓', style: TextStyle(fontSize: 20)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Doors are Open!', style: TextStyle(color: kPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                                SizedBox(height: 4),
                                Text(
                                  'All slot doors are unlocked. Collect your batteries and tap each slot to confirm collection.',
                                  style: TextStyle(color: kTextSecondary, fontSize: 12, height: 1.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Slot cards header
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'YOUR SLOTS (${_collected.length}/${_batteries.length} collected)',
                        style: const TextStyle(color: kTextSecondary, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                      ),
                    ),
                    const SizedBox(height: 12),

                    ..._batteries.map((battery) {
                      final isCollected = _collected.contains(battery['id']);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: kBgCard,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isCollected ? kPrimary : Colors.white.withOpacity(0.06),
                              width: isCollected ? 1.5 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Slot number box
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: isCollected ? kPrimary.withOpacity(0.15) : Colors.white.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isCollected ? kPrimary : Colors.white.withOpacity(0.1),
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('SLOT', style: TextStyle(color: kTextSecondary, fontSize: 9)),
                                        Text(
                                          battery['slot']!,
                                          style: TextStyle(
                                            color: isCollected ? kPrimary : kTextPrimary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'monospace',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(battery['id']!, style: const TextStyle(color: kTextPrimary, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
                                        const SizedBox(height: 4),
                                        Text(
                                          isCollected ? '✅ Collected' : '🔓 Open – Ready to collect',
                                          style: TextStyle(
                                            color: isCollected ? kPrimary : kWarning,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Collect button
                                  GestureDetector(
                                    onTap: () => _toggle(battery['id']!),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: isCollected ? kPrimary.withOpacity(0.2) : kBgCard2,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isCollected ? kPrimary : Colors.white.withOpacity(0.1),
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          isCollected ? '✓' : '○',
                                          style: TextStyle(
                                            color: isCollected ? kPrimary : kTextSecondary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Door visual
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Text(isCollected ? '🔒' : '🔓', style: const TextStyle(fontSize: 16)),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Door Status: ${isCollected ? 'Closed' : 'Open'}',
                                      style: TextStyle(
                                        color: isCollected ? kTextSecondary : kPrimary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (!isCollected) ...[
                                      const Spacer(),
                                      const Text('⚠️ Remove battery', style: TextStyle(color: kWarning, fontSize: 11)),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: _allCollected
                  ? PrimaryButton(
                      label: 'Complete Session →',
                      onPressed: () => Navigator.pushNamed(context, '/session-complete'),
                    )
                  : Column(
                      children: [
                        const Text(
                          'Collect all batteries to complete the session',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kTextSecondary, fontSize: 13),
                        ),
                        const SizedBox(height: 12),
                        AppProgressBar(value: _collected.length / _batteries.length),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
