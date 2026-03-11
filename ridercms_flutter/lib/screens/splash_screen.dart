import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';

class _Slide {
  final String icon;
  final String title;
  final String description;
  const _Slide({required this.icon, required this.title, required this.description});
}

const _slides = [
  _Slide(
    icon: '⚡',
    title: 'Power Up Anywhere',
    description: 'Find Ridercms stations near you and charge your batteries on the go.',
  ),
  _Slide(
    icon: '🗺️',
    title: 'Locate Nearby Booths',
    description: 'Our map shows real-time availability of charging slots at every station.',
  ),
  _Slide(
    icon: '💳',
    title: 'Pay & Collect Easily',
    description: 'Pay via M-Pesa, card, or wallet. Collect your charged batteries instantly.',
  ),
];

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _current = 0;

  void _next() {
    if (_current < _slides.length - 1) {
      setState(() => _current++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_current];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kBgDark, kBgDark2],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: kTextSecondary, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    // Logo icon
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [kPrimary, kPrimaryDark],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimary.withOpacity(0.4),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(slide.icon, style: const TextStyle(fontSize: 48)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Ridercms',
                      style: TextStyle(
                        color: kPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Slide content
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Column(
                        key: ValueKey(_current),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              slide.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: kTextPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              slide.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: kTextSecondary,
                                fontSize: 15,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_slides.length, (i) {
                        return GestureDetector(
                          onTap: () => setState(() => _current = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: i == _current ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: i == _current ? kPrimary : Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              // Bottom actions
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  children: [
                    if (_current < _slides.length - 1)
                      PrimaryButton(label: 'Next', onPressed: _next)
                    else
                      PrimaryButton(
                        label: 'Get Started',
                        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      ),
                    if (_current == 0) ...[
                      const SizedBox(height: 12),
                      GhostButton(
                        label: 'I already have an account',
                        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
