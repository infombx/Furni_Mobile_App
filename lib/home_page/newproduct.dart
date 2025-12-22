import 'package:flutter/material.dart';
import 'package:furni_mobile_app/data/dummy_data.dart';
import 'package:furni_mobile_app/home_page/widget.dart';
import 'package:furni_mobile_app/shop/shopPage.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';

class NewArrival extends StatefulWidget {
  const NewArrival({super.key});

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  final PageController _controller = PageController(viewportFraction: 0.75);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18),
          child: Text(
            'New',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18),
          child: Text(
            'Arrivals',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 20),

        // ---------------- Product Slider ----------------
        SizedBox(
          height: 380,
          child: PageView.builder(
            controller: _controller,
            itemCount: dummyData.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double scale = (1 - ((_currentPage - index).abs() * 0.1))
                      .clamp(0.9, 1.0);

                  return Transform.scale(
                    scale: scale,
                    child: NewProductCard(item: dummyProducts[index]),
                  );
                },
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // ---------------- Indicator Bar ----------------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(50),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (_currentPage + 1) / dummyProducts.length,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ---------------- More Products ----------------
Row(
              mainAxisSize: MainAxisSize.min,
              children:  [
                Padding(
                  padding: EdgeInsets.only(right: 6.0),
                  child:  TextButton(onPressed:(){Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Shoppage()));}, child: 
                   Column(
                     children: [
                       Row(
                         children: [
                           Container(
                             decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black, width: 1.2),
              ),
            ),
                     padding: const EdgeInsets.only(bottom: 4),
                             child: Text(
                              'More Products',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black),
                              
                                               ),
                           ), Icon(Icons.arrow_forward, size: 16, color: Colors.black),
                         ],
                       ),
                     ],
                   ),
              
                  
                ),
                   )
              ],
            ),
         ] );
  }
}
