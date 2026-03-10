import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';

enum _DoorStatus { opening, open, insert, closing, closed }

class SlotAssignedScreen extends StatefulWidget {
  const SlotAssignedScreen({super.key});

  @override
  State<SlotAssignedScreen> createState() => _SlotAssignedScreenState();
}

class _SlotAssignedScreenState extends State<SlotAssignedScreen> {
  _DoorStatus _doorStatus = _DoorStatus.opening;
  int _step = 0;

  final _steps = const [
    {'label': '🔓 Opening door...', 'color': kWarning},
    {'label': '🔓 Door Open – Insert Battery', 'color': kPrimary},
    {'label': '🔋 Battery Inserted', 'color': kPrimary},
    {'label': '🔒 Closing door...', 'color': kWarning},
    {'label': '🔒 Door Closed – Charging Started', 'color': kAccent},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => _advance(_DoorStatus.open, 1));
    Future.delayed(const Duration(seconds: 4), () => _advance(_DoorStatus.insert, 2));
    Future.delayed(const Duration(seconds: 6), () => _advance(_DoorStatus.closing, 3));
    Future.delayed(const Duration(seconds: 8), () => _advance(_DoorStatus.closed, 4));
  }

  void _advance(_DoorStatus status, int step) {
    if (mounted) setState(() { _doorStatus = status; _step = step; });
  }

  Color get _doorBg {
    switch (_doorStatus) {
      case _DoorStatus.closed: return kAccent.withOpacity(0.15);
      case _DoorStatus.opening:
      case _DoorStatus.closing: return kWarning.withOpacity(0.15);
      default: return kPrimary.withOpacity(0.15);
    }
  }

  Color get _doorBorder {
    switch (_doorStatus) {
      case _DoorStatus.closed: return kAccent;
      case _DoorStatus.opening:
      case _DoorStatus.closing: return kWarning;
      default: return kPrimary;
    }
  }

  String get _doorIcon {
    switch (_doorStatus) {
      case _DoorStatus.closed: return '🔒';
      case _DoorStatus.opening:
      case _DoorStatus.closing: return '⏳';
      default: return '🔓';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: Row(
                  children: [
                    const BackBtn(),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Slot Assigned', style: TextStyle(color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                        Text('Westlands Station', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),

              // Slot info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0d2a1a), Color(0xFF0a1f14)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: kPrimary.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    const Text('Your Assigned Slot', style: TextStyle(color: kTextSecondary, fontSize: 13)),
                    const SizedBox(height: 8),
                    const Text(
                      'A03',
                      style: TextStyle(color: kPrimary, fontSize: 72, fontWeight: FontWeight.w900, fontFamily: 'monospace'),
                    ),
                    const Text('Battery: BATT102', style: TextStyle(color: kTextSecondary, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Door status card
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Door Status', style: TextStyle(color: kTextSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),

                    // Animated door
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 120,
                        height: 150,
                        decoration: BoxDecoration(
                          color: _doorBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _doorBorder, width: 2),
                          boxShadow: _doorStatus == _DoorStatus.open || _doorStatus == _DoorStatus.insert
                              ? [BoxShadow(color: kPrimary.withOpacity(0.3), blurRadius: 30)]
                              : [],
                        ),
                        child: Center(child: Text(_doorIcon, style: const TextStyle(fontSize: 56))),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Status label
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _steps[_step]['label'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _steps[_step]['color'] as Color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Progress steps
                    ..._steps.asMap().entries.map((entry) {
                      final i = entry.key;
                      final s = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: i <= _step ? kPrimary : kBgCard2,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  i < _step ? '✓' : '${i + 1}',
                                  style: TextStyle(
                                    color: i <= _step ? Colors.white : kTextSecondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              s['label'] as String,
                              style: TextStyle(
                                color: i <= _step ? kTextPrimary : kTextSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kWarning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kWarning.withOpacity(0.2)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('💡', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Instructions', style: TextStyle(color: kWarning, fontSize: 13, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text(
                            'Wait for the door to open, then insert your battery firmly into slot A03. The door will close automatically once the battery is detected.',
                            style: TextStyle(color: kTextSecondary, fontSize: 12, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // CTA
              _doorStatus == _DoorStatus.closed
                  ? PrimaryButton(
                      label: 'View Charging Session →',
                      onPressed: () => Navigator.pushNamed(context, '/charging'),
                    )
                  : GhostButton(label: 'Waiting for door sequence...', onPressed: null),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
