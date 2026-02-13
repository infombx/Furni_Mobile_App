import 'package:flutter/material.dart';
import 'package:teakworld/Header/header.dart';
import 'package:teakworld/Items/cart_listview.dart';
import 'package:teakworld/dummy%20items/data_required.dart';
import 'package:teakworld/dummy%20items/myItems.dart';
import 'package:teakworld/models/user_model.dart';
import 'package:teakworld/screens/order_complete_screen.dart';
import 'package:teakworld/services/auth_service.dart';
import 'package:teakworld/services/order_items_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/product/data/orders.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({
    super.key,
    required this.subtotal,
    required this.Total,
    required this.shipping,
    required this.quantities,
    this.onSaved,
  });

  final double subtotal;
  final double Total;
  final double shipping;
  final Map<int, int> quantities;
  final void Function(Map<String, dynamic> values)? onSaved;

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  AppUser? currentUser;
  bool isLoading = true;
 List<MyOrders> get userCart {
    if (currentUser == null) return [];
    return ordersList.where((order) => order.userId == currentUser!.id).toList();
  }
  double itemprice = 0;
  Map<int, int> itemQuantities = {};
  double get total => itemprice + widget.shipping;

  String modePay = 'Credit Card';

  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController streetAddress = TextEditingController();
  final TextEditingController townCity = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expirationDate = TextEditingController();
  final TextEditingController cvc = TextEditingController();

  Country? selected;

  final RegExp emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$");

  String? _nonEmptyValidator(String? v, String fieldName) {
    if (v == null || v.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _phoneValidator(String? v) {
    final basic = _nonEmptyValidator(v, 'Phone number');
    if (basic != null) return basic;

    final digitsOnly = v!.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 7 || digitsOnly.length > 15) {
      return 'Enter a valid phone number (7-15 digits)';
    }
    return null;
  }

  String? _emailValidator(String? v) {
    final basic = _nonEmptyValidator(v, 'Email');
    if (basic != null) return basic;

    if (!emailRegExp.hasMatch(v!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

 void _popWithResult() {
  Navigator.of(context).pop(<String, dynamic>{
    'quantities': itemQuantities,
    'subtotal': itemprice,
  });
}
void _loadUser() async {
  final user = await AuthService().fetchMe();
  setState(() {
    currentUser = user;
    isLoading = false;
  });
}

@override
void initState() {
  super.initState();
  itemprice = widget.subtotal;
  itemQuantities = Map.from(widget.quantities); 
    _loadUser();
}
final OrderApi _orderApi = OrderApi();
bool _isUploading = false;

void _handleSubmit() async {
  if (_formKey.currentState?.validate() ?? false) {
    setState(() => _isUploading = true);

    Map<String, dynamic> addressInfo = {
      'firstName': firstNameCtrl.text.trim(),
      'lastName': lastNameCtrl.text.trim(),
      'phone': phoneCtrl.text.trim(),
      'email': emailCtrl.text.trim(),
      'street': streetAddress.text.trim(),
      'city': townCity.text.trim(),
      'state': stateCtrl.text.trim(),
      'zip': zipCode.text.trim(),
      'country': selected?.name ?? '', 
      'userId': currentUser?.id,
      
    };

    bool success = await _orderApi.createOrder(
      addressData: addressInfo,
      cartItems: userCart,
    );

    setState(() => _isUploading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order Placed Successfully!')),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => OrderCompleteScreen(
            item: userCart,
            Total: total,
            paymode: modePay,
            quantity: itemQuantities,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save order to server.')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
      if (isLoading) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Header(),
        backgroundColor: const Color.fromRGBO(1, 100, 109, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey, // single form for all fields
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: _popWithResult,
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
                Text(
                  'Check Out',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 30),
                // header step row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              '2',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Checkout details',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: const Color(0xFFB1B5C3),
                      ),
                      child: Center(
                        child: Text(
                          '3',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.black, endIndent: 70, thickness: 2),
                const SizedBox(height: 30),

                // CONTACT INFORMATION card
                Container(
                  height: 400,

                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'Contact Information',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            // FIRST NAME
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'FIRST NAME',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      controller: firstNameCtrl,
                                      validator: (v) =>
                                          _nonEmptyValidator(v, 'First Name'),
                                      decoration: InputDecoration(
                                        hintText: 'First name',
                                        hintStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 16),

                            // LAST NAME
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LAST NAME',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      controller: lastNameCtrl,
                                      validator: (v) =>
                                          _nonEmptyValidator(v, 'Last Name'),
                                      decoration: InputDecoration(
                                        hintText: 'Last name',
                                        hintStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // PHONE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PHONE NUMBER',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 50,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                controller: phoneCtrl,
                                validator: _phoneValidator,
                                decoration: InputDecoration(
                                  hintText: 'Phone number',
                                  hintStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // EMAIL
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'EMAIL ADDRESS',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 50,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                controller: emailCtrl,
                                validator: _emailValidator,
                                decoration: InputDecoration(
                                  hintText: 'Your Email',
                                  hintStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // SHIPPING ADDRESS card
                Container(
                  height: 500,

                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'Shipping Address',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // STREET
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'STREET ADDRESS *',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 50,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                controller: streetAddress,
                                validator: (v) =>
                                    _nonEmptyValidator(v, 'Street Address'),
                                decoration: InputDecoration(
                                  hintText: 'Street Address',
                                  hintStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // COUNTRY
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'COUNTRY *',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 50,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                              ),
                              child: DropdownButtonFormField<Country>(
                                items: Country.values
                                    .map(
                                      (c) => DropdownMenuItem(
                                        value: c,
                                        child: Text(c.name),
                                      ),
                                    )
                                    .toList(),
                                hint: Text(
                                  'Country',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                ),
                                onChanged: (value) =>
                                    setState(() => selected = value),
                                validator: (v) =>
                                    v == null ? 'Country is required' : null,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // TOWN/CITY
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOWN/CITY *',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 50,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                controller: townCity,
                                validator: (v) =>
                                    _nonEmptyValidator(v, 'Town/City'),
                                decoration: InputDecoration(
                                  hintText: 'Town/ City',
                                  hintStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            // STATE
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'STATE',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      controller: stateCtrl,
                                      validator: (v) =>
                                          _nonEmptyValidator(v, 'State'),
                                      decoration: InputDecoration(
                                        hintText: 'State',
                                        hintStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 16),

                            // ZIP
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ZIP CODE',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      controller: zipCode,
                                      validator: (v) =>
                                          _nonEmptyValidator(v, 'Zip Code'),
                                      decoration: InputDecoration(
                                        hintText: 'Zip Code',
                                        hintStyle: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // // PAYMENT METHOD card
                // Container(
                //   height: 500,

                //   decoration: BoxDecoration(
                //     border: Border.all(width: 1, color: Colors.black),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const SizedBox(height: 30),
                //         Text(
                //           'Payment Method',
                //           style: GoogleFonts.poppins(
                //             fontWeight: FontWeight.w500,
                //             fontSize: 20,
                //           ),
                //         ),
                //         const SizedBox(height: 30),

                //         Container(
                //           height: 60,
                //           decoration: BoxDecoration(
                //             border: Border.all(width: 1, color: Colors.black),
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           child: RadioListTile<String>(
                //             activeColor: Colors.black,
                //             title: Text(
                //               'Pay by Card Credit',
                //               style: GoogleFonts.inter(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //             value: 'Credit Card',
                //             groupValue: modePay,
                //             onChanged: (v) =>
                //                 setState(() => modePay = v ?? modePay),
                //             visualDensity: const VisualDensity(
                //               horizontal: -4.0,
                //             ),
                //           ),
                //         ),

                //         const SizedBox(height: 20),

                //         Container(
                //           height: 60,
                //           decoration: BoxDecoration(
                //             border: Border.all(width: 1, color: Colors.black),
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           child: RadioListTile<String>(
                //             activeColor: Colors.black,
                //             title: Text(
                //               'Paypal',
                //               style: GoogleFonts.inter(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //             value: 'PayPal',
                //             groupValue: modePay,
                //             onChanged: (v) =>
                //                 setState(() => modePay = v ?? modePay),
                //             visualDensity: const VisualDensity(
                //               horizontal: -4.0,
                //             ),
                //           ),
                //         ),

                //         const SizedBox(height: 20),
                //         const Divider(thickness: 1),
                //         const SizedBox(height: 20),

                //         // Card fields
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'CARD NUMBER',
                //               style: GoogleFonts.inter(
                //                 fontWeight: FontWeight.w700,
                //                 fontSize: 12,
                //               ),
                //             ),
                //             const SizedBox(height: 10),
                //             Container(
                //               height: 50,

                //               padding: const EdgeInsets.symmetric(
                //                 horizontal: 12,
                //               ),
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8),
                //                 border: Border.all(color: Colors.grey),
                //                 color: Colors.white,
                //               ),
                //               child: TextFormField(
                //                 controller: cardNumber,
                //                 validator: (v) =>
                //                     _nonEmptyValidator(v, 'Card Number'),
                //                 decoration: InputDecoration(
                //                   hintText: '1234 1234 1234',
                //                   hintStyle: GoogleFonts.inter(
                //                     fontWeight: FontWeight.w400,
                //                     fontSize: 16,
                //                   ),
                //                   border: InputBorder.none,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),

                //         const SizedBox(height: 16),

                //         Row(
                //           children: [
                //             Expanded(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     'EXPIRATION DATE',
                //                     style: GoogleFonts.inter(
                //                       fontWeight: FontWeight.w700,
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                   const SizedBox(height: 10),
                //                   Container(
                //                     height: 50,
                //                     padding: const EdgeInsets.symmetric(
                //                       horizontal: 12,
                //                     ),
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(8),
                //                       border: Border.all(color: Colors.grey),
                //                       color: Colors.white,
                //                     ),
                //                     child: TextFormField(
                //                       controller: expirationDate,
                //                       validator: (v) => _nonEmptyValidator(
                //                         v,
                //                         'Expiration Date',
                //                       ),
                //                       decoration: InputDecoration(
                //                         hintText: 'MM/YY',
                //                         hintStyle: GoogleFonts.inter(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 16,
                //                         ),
                //                         border: InputBorder.none,
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             const SizedBox(width: 16),
                //             Expanded(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     'CVC',
                //                     style: GoogleFonts.inter(
                //                       fontWeight: FontWeight.w700,
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                   const SizedBox(height: 10),
                //                   Container(
                //                     height: 50,
                //                     padding: const EdgeInsets.symmetric(
                //                       horizontal: 12,
                //                     ),
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(8),
                //                       border: Border.all(color: Colors.grey),
                //                       color: Colors.white,
                //                     ),
                //                     child: TextFormField(
                //                       controller: cvc,
                //                       validator: (v) =>
                //                           _nonEmptyValidator(v, 'CVC Code'),
                //                       decoration: InputDecoration(
                //                         hintText: 'CVC code',
                //                         hintStyle: GoogleFonts.inter(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 16,
                //                         ),
                //                         border: InputBorder.none,
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // const SizedBox(height: 30),

                // Order summary block
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Summary',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 400,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListedItems(
                                  initialQuantities: widget.quantities,
                                  onSubtotalChanged: (subtotal) {
                                    setState(() {
                                      itemprice = subtotal;
                                    });
                                  },
                                  onQuantityChanged: (quantities) =>
                                      setState(() {
                                        itemQuantities = Map<int, int>.from(
                                          quantities,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Shipping',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${widget.shipping}',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1, color: Colors.black12),
                        Row(
                          children: [
                            Text(
                              'Subtotal',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '$itemprice',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1, color: Colors.black12),
                        Row(
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '$total',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Place order button
                Container(
                  width: 450,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: _handleSubmit,
                    child: Text(
                      'Place Order',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
