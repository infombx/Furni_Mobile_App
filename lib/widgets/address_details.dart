import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teakworld/models/user_model.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({
    super.key,
    required this.currentUser,
    required this.isLoading,
  });

  final AppUser? currentUser;
  final bool isLoading;

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
                  if (isLoading)
                    const CircularProgressIndicator()
                  else if (currentUser != null)
                    Column(
                      children: [
                        Text(currentUser!.displayName, style: titleStyle),
                      ],
                    )
                  else
                    const Text('Failed to load user'),
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
