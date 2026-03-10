import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';

class _Booth {
  final String id;
  final String name;
  final String distance;
  final int availableSlots;
  final int totalSlots;
  final String address;
  final bool isFull;
  final double rating;

  const _Booth({
    required this.id,
    required this.name,
    required this.distance,
    required this.availableSlots,
    required this.totalSlots,
    required this.address,
    required this.isFull,
    required this.rating,
  });
}

const _booths = [
  _Booth(id: 'B001', name: 'Westlands Station', distance: '0.3 km', availableSlots: 4, totalSlots: 8, address: 'Westlands Rd, Nairobi', isFull: false, rating: 4.8),
  _Booth(id: 'B002', name: 'CBD Hub', distance: '1.2 km', availableSlots: 0, totalSlots: 6, address: 'Kenyatta Ave, Nairobi', isFull: true, rating: 4.5),
  _Booth(id: 'B003', name: 'Kilimani Point', distance: '2.1 km', availableSlots: 2, totalSlots: 10, address: 'Argwings Kodhek Rd', isFull: false, rating: 4.7),
  _Booth(id: 'B004', name: 'Karen Mall', distance: '5.4 km', availableSlots: 6, totalSlots: 8, address: 'Karen Shopping Centre', isFull: false, rating: 4.9),
];

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String? _selectedId;
  bool _showFullModal = false;
  _Booth? _fullBooth;

  void _selectBooth(_Booth booth) {
    if (booth.isFull) {
      setState(() {
        _selectedId = booth.id;
        _showFullModal = true;
        _fullBooth = booth;
      });
    } else {
      setState(() => _selectedId = booth.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgDark,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              Text('Find a Booth', style: TextStyle(color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                              Text('4 stations nearby', style: TextStyle(color: kTextSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: kBgCard, borderRadius: BorderRadius.circular(12)),
                          child: const Center(child: Text('🔍', style: TextStyle(fontSize: 18))),
                        ),
                      ],
                    ),
                  ),

                  // Search bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: TextField(
                      style: const TextStyle(color: kTextPrimary),
                      decoration: const InputDecoration(hintText: 'Search by location or booth name...'),
                    ),
                  ),

                  // Map placeholder
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: Container(
                      height: 220,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF0d1b2a), Color(0xFF1a2744)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          // Grid lines
                          CustomPaint(
                            size: const Size(double.infinity, 220),
                            painter: _GridPainter(),
                          ),

                          // Map pins
                          Positioned(
                            top: 60,
                            left: 80,
                            child: _MapPin(color: kPrimary, onTap: () => _selectBooth(_booths[0])),
                          ),
                          Positioned(
                            top: 100,
                            left: 180,
                            child: _MapPin(color: kDanger, onTap: () => _selectBooth(_booths[1])),
                          ),
                          Positioned(
                            top: 140,
                            left: 260,
                            child: _MapPin(color: kPrimary, onTap: () => _selectBooth(_booths[2])),
                          ),

                          // You are here
                          Positioned(
                            top: 90,
                            left: 130,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: kAccent,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                            ),
                          ),

                          // Legend
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _LegendDot(color: kPrimary, label: 'Available'),
                                  const SizedBox(width: 12),
                                  _LegendDot(color: kDanger, label: 'Full'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Booth list
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 12),
                    child: Text('Nearby Stations', style: TextStyle(color: kTextPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                  ),

                  ..._booths.map((booth) => Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                    child: GestureDetector(
                      onTap: () => _selectBooth(booth),
                      child: AppCard(
                        borderColor: _selectedId == booth.id ? kPrimary : null,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: booth.isFull ? kDanger.withOpacity(0.15) : kPrimary.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(child: Text('⚡', style: TextStyle(fontSize: 22))),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(booth.name, style: const TextStyle(color: kTextPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 2),
                                      Text(booth.address, style: const TextStyle(color: kTextSecondary, fontSize: 11)),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          StatusBadge(
                                            label: booth.isFull ? '🔴 Full' : '🟢 ${booth.availableSlots} slots free',
                                            color: booth.isFull ? kDanger : kPrimary,
                                            bgColor: booth.isFull ? kDanger.withOpacity(0.15) : kPrimary.withOpacity(0.15),
                                          ),
                                          const SizedBox(width: 8),
                                          Text('⭐ ${booth.rating}', style: const TextStyle(color: kTextSecondary, fontSize: 11)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(booth.distance, style: const TextStyle(color: kPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text('${booth.availableSlots}/${booth.totalSlots} slots', style: const TextStyle(color: kTextSecondary, fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                            if (_selectedId == booth.id && !booth.isFull) ...[
                              const SizedBox(height: 16),
                              PrimaryButton(
                                label: 'Select This Booth →',
                                onPressed: () => Navigator.pushNamed(context, '/scan'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  )),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Full booth modal
          if (_showFullModal && _fullBooth != null)
            GestureDetector(
              onTap: () => setState(() => _showFullModal = false),
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: kBgCard,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 48,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text('😔', style: TextStyle(fontSize: 40)),
                          const SizedBox(height: 12),
                          const Text('Booth is Full', style: TextStyle(color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          Text(
                            '${_fullBooth!.name} has no available slots right now.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: kTextSecondary, fontSize: 13),
                          ),
                          const SizedBox(height: 24),
                          PrimaryButton(
                            label: 'Try Another Booth',
                            onPressed: () => setState(() {
                              _showFullModal = false;
                              _selectedId = null;
                            }),
                          ),
                          const SizedBox(height: 12),
                          GhostButton(
                            label: 'Join Queue (Est. 15 min)',
                            onPressed: () => setState(() => _showFullModal = false),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  const _MapPin({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 16, offset: const Offset(0, 4))],
        ),
        child: const Center(child: Text('⚡', style: TextStyle(fontSize: 18))),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: kTextSecondary, fontSize: 11)),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1;

    for (int i = 0; i < 8; i++) {
      final y = i * 30.0;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (int i = 0; i < 8; i++) {
      final x = i * 55.0;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
