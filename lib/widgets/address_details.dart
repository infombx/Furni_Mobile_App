import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furni_mobile_app/widgets/account details.dart';
import 'package:furni_mobile_app/widgets/user_profile.dart';
class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = TextStyle(fontSize: 17);
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Address',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),

          Container(
            width: double.infinity,

            decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Shipping Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/images/edit_button.svg'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(UserProfile.displayName, style: titleStyle),
                  Text('(+1) 234 567 890', style: titleStyle),
                  Text(
                    '345 Long Island, New York, United States',
                    style: titleStyle,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
