import 'package:flutter/material.dart';
import 'package:furni_mobile_app/home_page/shopNow_widget.dart';

class Bundle extends StatelessWidget {
  const Bundle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // --- Container 1 ---
            Container(
              // height: 300,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/LivingRoom.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Text(
                      'Living Room',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Positioned(top: 30, right: 0, child: ShopNowLink()),
                ],
              ),
            ),
            //--------------------------------container 2------------------------
            Container(
              height: 230,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(100, 243, 245, 247),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/bedroom.png',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 55,
                    left: 10,
                    child: Text(
                      'Bedroom',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 24, 24, 24),
                        fontSize: 24,
                      ),
                    ),
                  ),

                  Positioned(bottom: 20, left: 0, child: ShopNowLink()),
                ],
              ),
            ),
            //------------------------------container 3------------------------
            Container(
              height: 230,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(100, 243, 245, 247),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/kitchen0.png',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 55,
                    left: 10,
                    child: Text(
                      'Kitchen',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 25, 24, 24),
                        fontSize: 24,
                      ),
                    ),
                  ),

                  Positioned(bottom: 20, left: 0, child: ShopNowLink()),
                ],
              ),
            ), //3
          ],
        ),
      ),
    );
  }
}
