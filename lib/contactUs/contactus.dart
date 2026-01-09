import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/contactUs/about.dart';
import 'package:furni_mobile_app/contactUs/widget/contactForm.dart';
import 'package:furni_mobile_app/contactUs/widget/info_card.dart';
import 'package:furni_mobile_app/contactUs/widget/services.dart';
import 'package:furni_mobile_app/contactUs/widget/shopnow.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/services/contactus_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/contactUs/widget/location.dart';

class Contactus extends StatelessWidget {
  const Contactus({super.key});

  Widget _infoCard(String asset, String title, String content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SvgPicture.asset(asset),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: const Color.fromARGB(255, 108, 114, 117),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Header(), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
        child: Column(
          children: [
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context, {});
                  },

                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 11,
                    color: Colors.black54,
                  ),
                  label: const Text(
                    'back',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),

            About(),
            const SizedBox(height: 20),
            FutureBuilder<List<dynamic>>(
              future: ContactPageService.fetchBlocks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return const Text('Failed to load About section');
                }

                final blocks = snapshot.data!;

                final aboutBlock = blocks.firstWhere(
                  (b) => b['__component'] == 'blocks.about-section',
                  orElse: () => null,
                );

                if (aboutBlock == null) {
                  return const SizedBox();
                }

                return Shopnow(block: aboutBlock);
              },
            ),

            const SizedBox(height: 40),

            FutureBuilder<List<dynamic>>(
              future: ContactPageService.fetchBlocks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return const SizedBox();
                }

                final blocks = snapshot.data!;

                final headingBlocks = blocks
                    .where((b) => b['__component'] == 'blocks.heading')
                    .toList();

                final headingBlock = headingBlocks.length > 1
                    ? headingBlocks[1]
                    : null;
                if (headingBlock == null) return const SizedBox();

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    headingBlock['heading'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            FutureBuilder<List<dynamic>>(
              future: ContactPageService.fetchBlocks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return const SizedBox();
                }

                final blocks = snapshot.data!;

                final cardBlocks = blocks
                    .where((b) => b['__component'] == 'blocks.card')
                    .take(3)
                    .toList();
                if (cardBlocks.isEmpty) return const SizedBox();

                return Column(
                  children: cardBlocks.map((card) {
                    final icon = card['icon'];
                    final iconUrl = icon != null
                        ? 'http://159.65.15.249:1337${icon['url']}'
                        : '';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InfoCard(
                        title: card['title'] ?? '',
                        text: card['text'] ?? '',
                        iconUrl: iconUrl,
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 32),
            Location(),
            const SizedBox(height: 32),

            Contactform(),
            const SizedBox(height: 50),
            Services(),
          ],
        ),
      ),
    );
  }
}
