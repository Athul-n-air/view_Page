import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600 && screenSize.width < 1200;
    final isDesktop = screenSize.width >= 1200;
    final isMobile = screenSize.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: SizedBox(
            height: kToolbarHeight * 0.8,
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 360° Image Section
            SizedBox(
              height: _getPanoramaHeight(context),
              child: PanoramaViewer(
                animSpeed: 0.05,
                child: Image.asset('assets/images/360view.jpg'),
              ),
            ),

            // First Info Section - Image on Left
            InfoSectionImageLeft(
              imagePath: 'assets/images/coffee.png',
              title: 'Enrich Your Day With Coffee',
              description: "At Cafe 1805, coffee is not just a drink — it is an experience. From rich espresso shots to smooth cold brews, every cup is brewed with passion, precision, and premium beans. Whether you're craving comfort or creativity, our coffee awakens your senses and fuels moments worth savoring.",
            ),

            // Second Info Section - Image on Right
            InfoSectionImageRight(
              imagePath: 'assets/images/arch.png',
              title: 'Love Brews Here — 18o5',
              description: "it is an experience. From rich espresso shots to smooth cold brews, every cup is brewed with passion, precision, and premium beans. Whether you're craving comfort or creativity, our coffee awakens your senses and fuels moments worth savoring.",
            ),
          ],
        ),
      ),
    );
  }

  double _getPanoramaHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth >= 1200) {
      return screenHeight * 0.6;
    } else if (screenWidth > 600) {
      return screenHeight * 0.55;
    } else {
      return screenHeight * 0.45;
    }
  }
}

// Widget with Image on Left Side
class InfoSectionImageLeft extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const InfoSectionImageLeft({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isDesktop = screenWidth >= 1200;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: isDesktop ? 1200 : double.infinity,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(context),
        vertical: _getVerticalPadding(context),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(context),
                const SizedBox(height: 25),
                _buildTextSection(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(context),
                SizedBox(width: isDesktop ? 40 : 30),
                Expanded(child: _buildTextSection(context)),
              ],
            ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    double imageWidth;
    double imageHeight;

    if (isMobile) {
      imageWidth = double.infinity;
      imageHeight = screenWidth * 0.4;
    } else if (isTablet) {
      imageWidth = screenWidth * 0.35;
      imageHeight = screenWidth * 0.25;
    } else {
      imageWidth = screenWidth * 0.25;
      imageHeight = screenWidth * 0.18;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        imagePath,
        width: imageWidth,
        height: imageHeight,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.white54,
              size: 40,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    double titleFontSize;
    double bodyFontSize;

    if (isMobile) {
      titleFontSize = 20;
      bodyFontSize = 14;
    } else if (isTablet) {
      titleFontSize = 24;
      bodyFontSize = 16;
    } else {
      titleFontSize = 26;
      bodyFontSize = 18;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.3,
          ),
        ),
        SizedBox(height: isDesktop ? 16 : 12),
        Text(
          description,
          style: TextStyle(
            fontSize: bodyFontSize,
            color: Colors.white70,
            height: 1.6,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  double _getHorizontalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth >= 1200) {
      return 40.0;
    } else if (screenWidth > 600) {
      return 30.0;
    } else {
      return 20.0;
    }
  }

  double _getVerticalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth >= 1200) {
      return 40.0;
    } else if (screenWidth > 600) {
      return 35.0;
    } else {
      return 30.0;
    }
  }
}

// Widget with Image on Right Side
class InfoSectionImageRight extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const InfoSectionImageRight({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isDesktop = screenWidth >= 1200;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: isDesktop ? 1200 : double.infinity,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(context),
        vertical: _getVerticalPadding(context),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(context),
                const SizedBox(height: 25),
                _buildTextSection(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildTextSection(context)),
                SizedBox(width: isDesktop ? 40 : 30),
                _buildImage(context),
              ],
            ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    double imageWidth;
    double imageHeight;

    if (isMobile) {
      imageWidth = double.infinity;
      imageHeight = screenWidth * 0.6;
    } else if (isTablet) {
      imageWidth = screenWidth * 0.35;
      imageHeight = screenWidth * 0.25;
    } else {
      imageWidth = screenWidth * 0.25;
      imageHeight = screenWidth * 0.18;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        imagePath,
        width: imageWidth,
        height: imageHeight,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.white54,
              size: 40,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    double titleFontSize;
    double bodyFontSize;

    if (isMobile) {
      titleFontSize = 20;
      bodyFontSize = 14;
    } else if (isTablet) {
      titleFontSize = 24;
      bodyFontSize = 16;
    } else {
      titleFontSize = 26;
      bodyFontSize = 18;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.3,
          ),
        ),
        SizedBox(height: isDesktop ? 16 : 12),
        Text(
          description,
          style: TextStyle(
            fontSize: bodyFontSize,
            color: Colors.white70,
            height: 1.6,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  double _getHorizontalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth >= 1200) {
      return 40.0;
    } else if (screenWidth > 600) {
      return 30.0;
    } else {
      return 20.0;
    }
  }

  double _getVerticalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth >= 1200) {
      return 40.0;
    } else if (screenWidth > 600) {
      return 35.0;
    } else {
      return 30.0;
    }
  }
}