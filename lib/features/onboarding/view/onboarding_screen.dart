import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../app/app_routes.dart';
import '../../../common_widgets/primary_button.dart';
import '../../../constants/app_strings.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  double get _videoHeight =>
      MediaQuery.of(context).size.height * 0.44;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingController>().initialize();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    context.read<OnboardingController>().disposeMedia();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<OnboardingController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A2667),
      body: SafeArea(
        child: Column(
          children: [
            _buildVideoSection(c),
            _buildContentSection(c),
          ],
        ),
      ),
    );
  }

  // ================= VIDEO SECTION =================

  Widget _buildVideoSection(OnboardingController c) {
    return SizedBox(
      height: _videoHeight,
      child: Stack(
        children: [
          // 1️⃣ Background Video (NO GESTURE)
          Positioned.fill(child: _buildVideo(c)),

          // 2️⃣ Swipe Detector (Transparent)
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: c.videos.length,
              onPageChanged: c.changePage,
              itemBuilder: (_, __) => const SizedBox(),
            ),
          ),

          // 3️⃣ Skip Button (Top-most)
          if (!c.isLastPage)
            Positioned(
              top: 16,
              right: 20,
              child: TextButton(
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text(
                  AppStrings.skip,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }




  Widget _buildSkipButton() {
    return Positioned(
      top: 16,
      right: 20,
      child: TextButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: const Text(
          AppStrings.skip,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPageView(OnboardingController c) {
    return PageView.builder(
      controller: _pageController,
      itemCount: c.videos.length,
      onPageChanged: c.changePage,
      itemBuilder: (_, __) => const SizedBox(),
    );
  }

  Widget _buildVideo(OnboardingController c) {
    final video = c.videoController;

    if (video == null || !video.value.isInitialized) {
      return const ColoredBox(color: Colors.black);
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: video.value.size.width,
            height: video.value.size.height,
            child: VideoPlayer(video),
          ),
        ),
      ),
    );
  }

  // ================= CONTENT SECTION =================

  Widget _buildContentSection(OnboardingController c) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Text(
              _getTitle(c.currentIndex),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              _getDescription(c.currentIndex),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),



            _buildDots(c),

            const SizedBox(height: 30),

            PrimaryButton(
              title:
              c.isLastPage ? AppStrings.getStarted : AppStrings.next,
              onTap: () {
                if (c.isLastPage) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.locationIntro,
                  );


                } else {
                  _pageController.nextPage(
                    duration:
                    const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDots(OnboardingController c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        c.videos.length,
            (i) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: c.currentIndex == i
                ? const Color(0xFF7B2FF7)
                : Colors.white30,
          ),
        ),
      ),
    );
  }

  // ================= HELPERS =================

  String _getTitle(int i) {
    switch (i) {
      case 0:
        return AppStrings.onboardingTitle1;
      case 1:
        return AppStrings.onboardingTitle2;
      default:
        return AppStrings.onboardingTitle3;
    }
  }

  String _getDescription(int i) {
    switch (i) {
      case 0:
        return AppStrings.onboardingDesc1;
      case 1:
        return AppStrings.onboardingDesc2;
      default:
        return AppStrings.onboardingDesc3;
    }
  }
}
