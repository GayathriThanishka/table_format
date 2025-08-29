import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kovaii_fine_coat/constant/app_strings.dart';
import 'package:kovaii_fine_coat/constant/images.dart';
import 'package:kovaii_fine_coat/features/screen/drawingDetails/drawing_details.dart';
import 'package:kovaii_fine_coat/theme/palettes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to DrawingDetails after 500 milliseconds
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DrawingDetails()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Left side image
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.homeLeftImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Right side content
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(AppImages.logo),
                              const SizedBox(height: 30),
                              Text(
                                AppStrings.companyName,
                                style: GoogleFonts.dmSans(
                                  color: Palettes.primaryColor,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Powered by @ Asthra",
                          style: GoogleFonts.dmSans(
                            color: Palettes.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Bottom-right decoration
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      AppImages.cornerBottom,
                      width: 400,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Top-right decoration
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Image.asset(
                      AppImages.cornerTop,
                      width: 320,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
