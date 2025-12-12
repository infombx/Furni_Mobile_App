import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  const QuantityCounter({
    super.key,
    required this.onQuantityChanged,
    this.initialQuantity = 1,
    this.min = 1,
    this.max,
  });

  final void Function(int quantity) onQuantityChanged;
  final int initialQuantity;
  final int min;
  final int? max;

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    // ensure initialQuantity respects min and max
    final int init = widget.initialQuantity;
    if (widget.max != null) {
      quantity = init.clamp(widget.min, widget.max!);
    } else {
      quantity = init >= widget.min ? init : widget.min;
    }
  }

  @override
  void didUpdateWidget(covariant QuantityCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if parent changed the initialQuantity (or min/max), update current
    if (oldWidget.initialQuantity != widget.initialQuantity ||
        oldWidget.min != widget.min ||
        oldWidget.max != widget.max) {
      final int init = widget.initialQuantity;
      setState(() {
        if (widget.max != null) {
          quantity = init.clamp(widget.min, widget.max!);
        } else {
          quantity = init >= widget.min ? init : widget.min;
        }
      });
    }
  }

  void addCounter() {
    final canIncrease = widget.max == null ? true : quantity < widget.max!;
    if (!canIncrease) return;
    setState(() {
      quantity += 1;
    });
    widget.onQuantityChanged(quantity);
  }

  void minCounter() {
    if (quantity <= widget.min) return;
    setState(() {
      quantity -= 1;
    });
    widget.onQuantityChanged(quantity);
  }

  @override
  Widget build(BuildContext context) {
    final atMax = widget.max != null && quantity >= widget.max!;
    final atMin = quantity <= widget.min;

    return Container(
      height: 45,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 40,
            child: IconButton(
              onPressed: atMin ? null : minCounter, // disabled when at min
              icon: Transform.translate(
                offset: const Offset(0, 0),
                child: Icon(Icons.remove, size: 24, color: atMin ? Colors.grey : Colors.black),
              ),
            ),
          ),
          Text(
            '$quantity',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              onPressed: atMax ? null : addCounter, // disabled when at max
              icon: Icon(Icons.add, color: atMax ? Colors.grey : Colors.black, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
