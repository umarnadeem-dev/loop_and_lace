import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/crochet_image.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onAlreadyHaveAccount;

  const WelcomeScreen({
    super.key,
    required this.onGetStarted,
    required this.onAlreadyHaveAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Image Collage
              SizedBox(
                height: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Left image (Bunny)
                    Positioned(
                      left: 10,
                      top: 35,
                      child: Transform.rotate(
                        angle: -0.08,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const CrochetImage(
                            imagePath: 'assets/images/bunny.jpg',
                            width: 125,
                            height: 165,
                          ),
                        ),
                      ),
                    ),
                    // Right image (Blanket/bag)
                    Positioned(
                      right: 10,
                      top: 45,
                      child: Transform.rotate(
                        angle: 0.1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const CrochetImage(
                            imagePath: 'assets/images/blanket.jpg',
                            width: 120,
                            height: 160,
                          ),
                        ),
                      ),
                    ),
                    // Center prominent image (Cardigan)
                    Positioned(
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const CrochetImage(
                          imagePath: 'assets/images/cardigan.jpg',
                          width: 145,
                          height: 190,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Title and Tagline
              Column(
                children: [
                  Text(
                    'Loop & Lace',
                    style: AppTypography.serif(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Crochet patterns, a handmade shop and custom orders — all in one cosy app.',
                      textAlign: TextAlign.center,
                      style: AppTypography.sans(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Action Buttons & Dots
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: onGetStarted,
                      child: const Text('Get started'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: onAlreadyHaveAccount,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                      ),
                      child: const Text('I already have an account'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Page Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
