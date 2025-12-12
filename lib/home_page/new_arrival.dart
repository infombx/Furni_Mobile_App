import 'package:flutter/material.dart';

class NewArrival extends StatefulWidget {
  const NewArrival({super.key});

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- TITLE ---
        const Padding(
          padding: EdgeInsets.only(left: 18),
          child: Text(
            'New',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18),
          child: Text(
            'Arrivals',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 16),

        // Horizontal scroll list
        SizedBox(
          height: 350,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // ---------------- CARD 1 ----------------
                Container(
                  width: 260,
                  //height: 300,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/living_room.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Positioned(
                        top: 16,
                        left: 12,
                        child: Text(
                          'Living Room',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Shop now',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ---------------- CARD 2 ----------------
                Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/bedroom.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Positioned(
                        top: 16,
                        left: 12,
                        child: Text(
                          'Bedroom',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Shop now',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: const [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Text(
                    'More Products',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
