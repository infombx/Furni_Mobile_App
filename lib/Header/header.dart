import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ...existing code...
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return 
           Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/furniLogo.svg', 
                  alignment: Alignment.centerRight,
                  width: 70,
                ),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/search.svg',
                        width: 24,
                        height: 24,
                        alignment: Alignment.topLeft ,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            );
        
  }
}
// ...existing code...