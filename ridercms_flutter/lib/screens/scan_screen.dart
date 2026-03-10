import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _isScanMode = true;
  final _batteryIdCtrl = TextEditingController();
  final List<String> _batteries = [];
  bool _scanning = false;

  void _addBattery() {
    final id = _batteryIdCtrl.text.trim().toUpperCase();
    if (id.isNotEmpty) {
      setState(() {
        _batteries.add(id);
        _batteryIdCtrl.clear();
      });
    }
  }

  void _simulateScan() {
    setState(() => _scanning = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _scanning = false;
          _batteries.add('BATT${100 + _batteries.length + 2}');
        });
      }
    });
  }

  void _proceed() {
    Navigator.pushNamed(context, '/slot-assigned');
  }

  @override
  void dispose() {
    _batteryIdCtrl.dispose();
    super.dispose();
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
                      Text('Scan Battery', style: TextStyle(color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                      Text('Westlands Station · Slot A', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),

            // Mode toggle
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: kBgCard, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    _ToggleBtn(label: '📷 Scan QR', active: _isScanMode, onTap: () => setState(() => _isScanMode = true)),
                    _ToggleBtn(label: '✏️ Manual Entry', active: !_isScanMode, onTap: () => setState(() => _isScanMode = false)),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    if (_isScanMode) ...[
                      // Camera viewfinder
                      Container(
                        height: 280,
                        decoration: BoxDecoration(color: kBgCard, borderRadius: BorderRadius.circular(24)),
                        child: Center(
                          child: _scanning
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(color: kPrimary),
                                    const SizedBox(height: 16),
                                    const Text('Scanning...', style: TextStyle(color: kTextSecondary, fontSize: 13)),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Scan frame
                                    SizedBox(
                                      width: 180,
                                      height: 180,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: kPrimary, width: 2),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          // Corner accents
                                          ..._buildCorners(),
                                          const Center(child: Text('🔋', style: TextStyle(fontSize: 56))),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('Point camera at battery QR code', style: TextStyle(color: kTextSecondary, fontSize: 13)),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: _scanning ? 'Scanning...' : '📷 Tap to Scan',
                        onPressed: _scanning ? null : _simulateScan,
                      ),
                    ] else ...[
                      // Manual entry
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Battery ID', style: TextStyle(color: kTextSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _batteryIdCtrl,
                              style: const TextStyle(color: kTextPrimary),
                              textCapitalization: TextCapitalization.characters,
                              decoration: const InputDecoration(hintText: 'e.g. BATT102'),
                              onSubmitted: (_) => _addBattery(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: _addBattery,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(14)),
                              child: const Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Find the ID printed on the battery label', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                      ),
                    ],

                    // Added batteries list
                    if (_batteries.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Batteries to Charge (${_batteries.length})',
                          style: const TextStyle(color: kTextPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._batteries.asMap().entries.map((entry) {
                        final i = entry.key;
                        final b = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(color: kBgCard, borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                const Text('🔋', style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(b, style: const TextStyle(color: kTextPrimary, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() => _batteries.removeAt(i)),
                                  child: const Text('Remove', style: TextStyle(color: kDanger, fontSize: 13)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 12),
                      GhostButton(
                        label: '+ Add Another Battery',
                        onPressed: _isScanMode ? _simulateScan : () => _batteryIdCtrl.clear(),
                      ),
                    ],

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom proceed
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: _batteries.isNotEmpty
                  ? PrimaryButton(
                      label: 'Proceed with ${_batteries.length} ${_batteries.length == 1 ? 'Battery' : 'Batteries'} →',
                      onPressed: _proceed,
                    )
                  : const Text(
                      'Scan or enter at least one battery to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kTextSecondary, fontSize: 13),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCorners() {
    const size = 20.0;
    const thickness = 4.0;
    const color = kPrimary;
    return [
      Positioned(top: 0, left: 0, child: Container(width: size, height: thickness, color: color)),
      Positioned(top: 0, left: 0, child: Container(width: thickness, height: size, color: color)),
      Positioned(top: 0, right: 0, child: Container(width: size, height: thickness, color: color)),
      Positioned(top: 0, right: 0, child: Container(width: thickness, height: size, color: color)),
      Positioned(bottom: 0, left: 0, child: Container(width: size, height: thickness, color: color)),
      Positioned(bottom: 0, left: 0, child: Container(width: thickness, height: size, color: color)),
      Positioned(bottom: 0, right: 0, child: Container(width: size, height: thickness, color: color)),
      Positioned(bottom: 0, right: 0, child: Container(width: thickness, height: size, color: color)),
    ];
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _ToggleBtn({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? kPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active ? Colors.white : kTextSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
