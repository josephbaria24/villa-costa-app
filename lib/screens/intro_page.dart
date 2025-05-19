import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:villa_costa/screens/login_signup_page.dart';

class OnboardingPage {
  final String title;
  final String subtitle;
  final String? backgroundPath;
  final bool isVideo;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    this.backgroundPath,
    this.isVideo = false,
  });
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  late VideoPlayerController _videoController;

@override
void initState() {
  super.initState();

  _videoController = VideoPlayerController.asset('lib/assets/images/bg.mp4')
    ..initialize().then((_) {
      _videoController.setLooping(true);
      // Don't play yet; wait for third page
    });
}

@override
void dispose() {
  _videoController.dispose();
  super.dispose();
}
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
  OnboardingPage(
    title: 'Welcome to Villa Costa',
    subtitle: 'Find comfort and elegance in every stay.',
    backgroundPath: 'lib/assets/images/bgintro.jpg',
  ),
  OnboardingPage(
    title: 'Explore Rooms & Facilities',
    subtitle: 'Browse a variety of accommodations and amenities tailored for you.',
    backgroundPath: 'lib/assets/images/bg2.jpg',
  ),
  OnboardingPage(
    title: 'Book and Manage with Ease',
    subtitle: 'Seamless booking, flexible preferences, and instant access.',
    isVideo: true, // No backgroundPath needed here
  ),
];

  void _goToHome() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentPage + 1) / _pages.length;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _currentPage = index);

              if (index == _pages.length - 1) {
                if (_videoController.value.isInitialized) {
                  _videoController.play();
                } else {
                  _videoController.initialize().then((_) {
                    setState(() {});
                    _videoController.play();
                  });
                }
                Future.delayed(const Duration(seconds: 3));
              } else {
                if (_videoController.value.isInitialized) {
                  _videoController.pause();
                }
              }
            },


            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Stack(
                fit: StackFit.expand,
                children: [

                  if (page.isVideo && _videoController.value.isInitialized)
  AnimatedBuilder(
    animation: _videoController,
    builder: (context, child) {
      return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _videoController.value.size.width,
          height: _videoController.value.size.height,
          child: VideoPlayer(_videoController),
        ),
      );
    },
  )

else if (page.backgroundPath != null)
  Image.asset(
    page.backgroundPath!,
    fit: BoxFit.cover,
  )
else
  Container(color: Colors.black),

                  // Dark overlay for contrast
                  Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  // Foreground content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          page.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          page.subtitle,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Skip Button
          Positioned(
            top: 40,
            right: 24,
            child: TextButton(
              onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AuthPage(),
          ),
        );
      },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          // Progress Bar
          Positioned(
            bottom: 20,
            left: 24,
            right: 24,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: Colors.white30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
