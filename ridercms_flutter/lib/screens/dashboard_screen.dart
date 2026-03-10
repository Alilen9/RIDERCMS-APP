import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _sessions = [
    {'id': 'S001', 'date': 'Mar 8', 'batteries': 2, 'amount': 'KSh 120', 'status': 'Completed'},
    {'id': 'S002', 'date': 'Mar 5', 'batteries': 1, 'amount': 'KSh 60', 'status': 'Completed'},
    {'id': 'S003', 'date': 'Feb 28', 'batteries': 3, 'amount': 'KSh 180', 'status': 'Completed'},
  ];

  static const _stats = [
    {'label': 'Sessions', 'value': '24', 'icon': '⚡'},
    {'label': 'Batteries', 'value': '47', 'icon': '🔋'},
    {'label': 'Saved (KSh)', 'value': '2,840', 'icon': '💰'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgDark,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header gradient
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [kBgDark2, kBgDark],
                    ),
                  ),
                  child: Column(
                    children: [
                      // Top row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Good morning,', style: TextStyle(color: kTextSecondary, fontSize: 13)),
                              const SizedBox(height: 2),
                              const Text('John Doe 👋', style: TextStyle(color: kTextPrimary, fontSize: 22, fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(color: kBgCard, borderRadius: BorderRadius.circular(16)),
                                child: const Center(child: Text('🔔', style: TextStyle(fontSize: 22))),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: kDanger, borderRadius: BorderRadius.circular(9)),
                                  child: const Center(
                                    child: Text('2', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Wallet card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [kPrimary, kPrimaryDark],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: kPrimary.withOpacity(0.3),
                              blurRadius: 32,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Wallet Balance', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13)),
                                    const SizedBox(height: 4),
                                    const Text('KSh 1,250', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Center(child: Text('💳', style: TextStyle(fontSize: 24))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _WalletBtn(label: '+ Top Up', onTap: () {}),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _WalletBtn(label: 'History', onTap: () {}),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Stats
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Row(
                    children: _stats.map((stat) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: stat == _stats.last ? 0 : 12,
                          ),
                          child: AppCard(
                            child: Column(
                              children: [
                                Text(stat['icon']!, style: const TextStyle(fontSize: 24)),
                                const SizedBox(height: 4),
                                Text(stat['value']!, style: const TextStyle(color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 2),
                                Text(stat['label']!, style: const TextStyle(color: kTextSecondary, fontSize: 11)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Quick Actions
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Quick Actions', style: TextStyle(color: kTextPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 16),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.2,
                        children: [
                          _QuickAction(
                            icon: '🗺️',
                            title: 'Find Booth',
                            subtitle: 'Locate nearby stations',
                            gradient: const [Color(0xFF1a2744), Color(0xFF1e3a5f)],
                            onTap: () => Navigator.pushNamed(context, '/map'),
                          ),
                          _QuickAction(
                            icon: '📷',
                            title: 'Scan Battery',
                            subtitle: 'Start charging now',
                            gradient: const [Color(0xFF1a2a1a), Color(0xFF1e4a2a)],
                            onTap: () => Navigator.pushNamed(context, '/scan'),
                          ),
                          _QuickAction(
                            icon: '⚡',
                            title: 'Active Session',
                            subtitle: 'View charging status',
                            gradient: const [Color(0xFF2a1a1a), Color(0xFF4a2a1e)],
                            onTap: () => Navigator.pushNamed(context, '/charging'),
                          ),
                          _QuickAction(
                            icon: '🎁',
                            title: 'Rewards',
                            subtitle: '240 points earned',
                            gradient: const [Color(0xFF1a1a2a), Color(0xFF2a1e4a)],
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Recent Sessions
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Recent Sessions', style: TextStyle(color: kTextPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
                          GestureDetector(
                            onTap: () {},
                            child: const Text('See all', style: TextStyle(color: kPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ..._sessions.map((session) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppCard(
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: kPrimary.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(child: Text('⚡', style: TextStyle(fontSize: 18))),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Session #${session['id']}', style: const TextStyle(color: kTextPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${session['date']} · ${session['batteries']} ${(session['batteries'] as int) == 1 ? 'battery' : 'batteries'}',
                                      style: const TextStyle(color: kTextSecondary, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(session['amount']! as String, style: const TextStyle(color: kTextPrimary, fontSize: 13, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 2),
                                  Text(session['status']! as String, style: const TextStyle(color: kPrimary, fontSize: 11)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom nav
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: kBgCard,
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(icon: '🏠', label: 'Home', active: true, onTap: () {}),
                  _NavItem(icon: '🗺️', label: 'Map', active: false, onTap: () => Navigator.pushNamed(context, '/map')),
                  _NavItem(icon: '⚡', label: 'Charge', active: false, onTap: () => Navigator.pushNamed(context, '/scan')),
                  _NavItem(icon: '👤', label: 'Profile', active: false, onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _WalletBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: kTextPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: kTextSecondary, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: active ? kPrimary : kTextSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
