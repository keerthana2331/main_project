// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:math' as math;

import 'package:navigation_screens/main.dart';
import 'package:navigation_screens/screens/loginscreen.dart';
import 'package:navigation_screens/screens/signup.dart';
import 'package:provider/provider.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    
    return Scaffold(
      body: GlassmorphicBackground(
        child: SafeArea(
          child: Stack(
            children: [
              // Animated particles
              AnimatedParticles(),
              
              // Interactive logo with 3D effect
              Positioned(
                top: screenHeight * 0.08,
                left: 0,
                right: 0,
                child: TiltableLogoWidget(),
              ),

              // Main content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.38),
                    
                    // Animated title with typing effect
                    TypingAnimationText(
                      'SmartChatHub',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    
                    SizedBox(height: 12),
                    
                    // Animated subtitle 
                    FadeInUp(
                      duration: Duration(milliseconds: 800),
                      delay: Duration(milliseconds: 500),
                      child: Text(
                        'Connect | Share | Experience',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white70,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Feature cards with micro-animations
                    Expanded(
                      child: FeaturesCarousel(),
                    ),
                    
                    SizedBox(height: 12),
                    
                    // Action buttons
                    ActionButtons(),
                    
                    SizedBox(height: 24),
                  ],
                ),
              ),
              
              // Floating button with 3D effect
              Positioned(
                top: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    // Show theme selection modal
                    showThemeSelectionModal(context);
                  },
                  elevation: 8,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Icon(Icons.color_lens, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void showThemeSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ThemeSelectionWidget(),
    );
  }
}
// Update your GlassmorphicBackground to use the theme from provider
class GlassmorphicBackground extends StatelessWidget {
  final Widget child;
  
  const GlassmorphicBackground({required this.child});
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            themeProvider.currentTheme.primaryColor,
            themeProvider.currentTheme.accentColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background patterns
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          
          // Glassmorphic overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

// Animated Particles Effect
class AnimatedParticles extends StatefulWidget {
  @override
  _AnimatedParticlesState createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles> with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> particles = [];
  
  @override
  void initState() {
    super.initState();
    
    // Create particles
    final random = math.Random();
    for (int i = 0; i < 40; i++) {
      particles.add(Particle(random));
    }
    
    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();
    
    _controller.addListener(() {
      for (var particle in particles) {
        particle.update();
      }
      setState(() {});
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParticlesPainter(particles),
      size: Size.infinite,
    );
  }
}

class Particle {
  late double x;
  late double y;
  late double size;
  late double opacity;
  late double speed;
  late double angle;
  final math.Random random;
  
  Particle(this.random) {
    reset(true);
  }
  
  void reset(bool initial) {
    x = random.nextDouble();
    y = initial ? random.nextDouble() : 1.2;
    size = random.nextDouble() * 0.015 + 0.003;
    opacity = random.nextDouble() * 0.5 + 0.1;
    speed = random.nextDouble() * 0.002 + 0.001;
    angle = random.nextDouble() * math.pi * 0.2 - math.pi * 0.1;
  }
  
  void update() {
    y -= speed;
    x += math.sin(angle) * speed * 0.5;
    
    if (y < -0.1) {
      reset(false);
    }
  }
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  
  ParticlesPainter(this.particles);
  
  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(particle.opacity)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size * size.width,
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Tiltable 3D effect logo widget
class TiltableLogoWidget extends StatefulWidget {
  @override
  _TiltableLogoWidgetState createState() => _TiltableLogoWidgetState();
}

class _TiltableLogoWidgetState extends State<TiltableLogoWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _rotateX = 0;
  double _rotateY = 0;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    
    // Add idle animation
    _startIdleAnimation();
  }
  
  void _startIdleAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _rotateX = math.sin(_controller.value * math.pi * 2) * 0.05;
          _rotateY = math.cos(_controller.value * math.pi * 2) * 0.05;
        });
        _controller.reset();
        _controller.forward().then((_) => _startIdleAnimation());
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (mounted) {
          setState(() {
            _rotateY = (details.delta.dx / 100).clamp(-0.2, 0.2);
            _rotateX = (-details.delta.dy / 100).clamp(-0.2, 0.2);
          });
        }
      },
      onPanEnd: (_) {
        if (mounted) {
          setState(() {
            _rotateX = 0;
            _rotateY = 0;
          });
        }
      },
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotateX)
          ..rotateY(_rotateY),
        alignment: Alignment.center,
        child: ZoomIn(
          duration: Duration(milliseconds: 1200),
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Stack(
              children: [
                // Logo image with glow effect
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.6),
                          Colors.white.withOpacity(0.1),
                        ],
                        radius: 0.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.chat,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
                
                // Orbiting elements
                OrbitingElements(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Orbiting elements around the logo
class OrbitingElements extends StatefulWidget {
  @override
  _OrbitingElementsState createState() => _OrbitingElementsState();
}

class _OrbitingElementsState extends State<OrbitingElements> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    )..repeat();
    _controller.addListener(() => setState(() {}));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(5, (index) {
        final angle = (_controller.value * math.pi * 2) + (index * (math.pi * 2 / 5));
        final size = 18.0;
        final radius = 90.0;
        final x = math.cos(angle) * radius;
        final y = math.sin(angle) * radius;
        
        return Positioned(
          left: 90 + x - size / 2,
          top: 90 + y - size / 2,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

// Animated typing text effect
class TypingAnimationText extends StatefulWidget {
  final String text;
  final TextStyle style;
  
  const TypingAnimationText(this.text, {required this.style});
  
  @override
  _TypingAnimationTextState createState() => _TypingAnimationTextState();
}

class _TypingAnimationTextState extends State<TypingAnimationText> with SingleTickerProviderStateMixin {
  late String _displayText;
  late Timer _timer;
  int _currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _displayText = '';
    _startTypingAnimation();
  }
  
  void _startTypingAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _displayText = widget.text.substring(0, _currentIndex + 1);
          _currentIndex++;
        });
      } else {
        _timer.cancel();
      }
    });
  }
  
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _displayText,
          style: widget.style,
        ),
        AnimatedOpacity(
          opacity: _currentIndex < widget.text.length ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Text(
            '|',
            style: widget.style,
          ),
        ),
      ],
    );
  }
}

// Carousel of feature cards
class FeaturesCarousel extends StatefulWidget {
  @override
  _FeaturesCarouselState createState() => _FeaturesCarouselState();
}

class _FeaturesCarouselState extends State<FeaturesCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  
  final List<FeatureItem> _features = [
    FeatureItem(
      icon: Icons.security,
      title: 'End-to-End Encryption',
      description: 'Your messages are secure and private',
      color: Color(0xFF4CAF50),
    ),
    FeatureItem(
      icon: Icons.photo_library,
      title: 'HD Media Sharing',
      description: 'Share photos and videos in high quality',
      color: Color(0xFFF44336),
    ),
    FeatureItem(
      icon: Icons.group,
      title: 'Group Conversations',
      description: 'Chat with all your friends at once',
      color: Color(0xFF2196F3),
    ),
  ];
  
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _features.length,
            itemBuilder: (context, index) {
              return FadeInUp(
                delay: Duration(milliseconds: 300 * index),
                duration: Duration(milliseconds: 500),
                child: FeatureCard(
                  feature: _features[index],
                  isActive: _currentPage == index,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_features.length, (index) => 
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.white : Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FeatureItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  
  FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
class FeatureCard extends StatelessWidget {
  final FeatureItem feature;
  final bool isActive;
  
  const FeatureCard({
    required this.feature,
    required this.isActive,
  });
  
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: isActive ? 0 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: feature.color.withOpacity(isActive ? 0.3 : 0),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: SingleChildScrollView( // Added to handle potential overflow
        physics: NeverScrollableScrollPhysics(), // Optional: prevents actual scrolling
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Changed from default (max)
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: isActive ? 80 : 70,
                width: isActive ? 80 : 70,
                decoration: BoxDecoration(
                  color: feature.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    feature.icon,
                    size: isActive ? 40 : 35,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                feature.title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                feature.description,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Action buttons
class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Get Started button
        FadeInUp(
          duration: Duration(milliseconds: 800),
          delay: Duration(milliseconds: 800),
          child: NeumorphicButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              // Navigate to next screen
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>SignupPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var tween = Tween(begin: Offset(0, 1), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.easeOutQuint));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 800),
                ),
              );
            },
            text: "Get Started",
            gradient: LinearGradient(
              colors: [Color(0xFF4776E6), Color(0xFF8E54E9)],
            ),
            icon: Icons.arrow_forward,
          ),
        ),
        
        SizedBox(height: 16),
        
        // Login button
        FadeInUp(
          duration: Duration(milliseconds: 800),
          delay: Duration(milliseconds: 1000),
          child: NeumorphicButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              // Navigate to login screen
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var tween = Tween(begin: Offset(1, 0), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.easeOutQuint));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 800),
                ),
              );
            },
            text: "Login",
            outlined: true,
            icon: Icons.login,
          ),
        ),
      ],
    );
  }
}

// Neumorphic button with gradient and animations
class NeumorphicButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  final Gradient? gradient;
  final bool outlined;
  final IconData icon;
  
  const NeumorphicButton({
    required this.onPressed,
    required this.text,
    this.gradient,
    this.outlined = false,
    required this.icon,
  });
  
  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: widget.outlined ? null : widget.gradient,
            border: widget.outlined
                ? Border.all(color: Colors.white.withOpacity(0.5), width: 2)
                : null,
            boxShadow: [
              if (!widget.outlined && !_isPressed)
                BoxShadow(
                  color: (widget.gradient != null
                      ? Color(0xFF8E54E9)
                      : Colors.white).withOpacity(0.4),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                widget.icon,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Theme selection widget
class ThemeSelectionWidget extends StatelessWidget {
  final List<ThemeOption> themes = [
    ThemeOption(
      name: "Ocean Blue",
      primaryColor: Color(0xFF1A2980),
      accentColor: Color(0xFF26D0CE),
    ),
    ThemeOption(
      name: "Purple Haze",
      primaryColor: Color(0xFF8E2DE2),
      accentColor: Color(0xFF4A00E0),
    ),
    ThemeOption(
      name: "Sunset Orange",
      primaryColor: Color(0xFFFF512F),
      accentColor: Color(0xFFDD2476),
    ),
    ThemeOption(
      name: "Emerald Green",
      primaryColor: Color(0xFF134E5E),
      accentColor: Color(0xFF71B280),
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose a Theme",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: themes.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: ThemeCard(theme: themes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



// Update your ThemeCard to apply the theme
class ThemeCard extends StatelessWidget {
  final ThemeOption theme;
  
  const ThemeCard({required this.theme});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        // Apply the theme
        Provider.of<ThemeProvider>(context, listen: false).setTheme(theme);
        
        // Show feedback that theme was applied
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${theme.name} theme applied'),
            duration: Duration(seconds: 1),
            backgroundColor: theme.primaryColor,
          ),
        );
        
        Navigator.pop(context);
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.primaryColor,
              theme.accentColor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                theme.name,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


