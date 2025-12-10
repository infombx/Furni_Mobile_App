import 'package:flutter/material.dart';

class RatingStar extends StatefulWidget {
  final int maxRating;
  final double size;
  final Function(int)? onRatingSelected;
  final int initialRating;
  final bool readOnly;

  const RatingStar({
    super.key,
    this.maxRating = 5,
    this.size = 20,
    this.onRatingSelected,
    this.initialRating = 0,
    this.readOnly = false,
  });

  @override
  State<RatingStar> createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  int currentRating = 0;

  @override
  void initState() {
    super.initState();
    currentRating = widget.initialRating;
  }

  @override
  void didUpdateWidget(covariant RatingStar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      currentRating = widget.initialRating;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.maxRating, (index) {
        final starIndex = index + 1;

        return GestureDetector(
          onTap: widget.readOnly
              ? null
              : () {
                  setState(() {
                    currentRating = starIndex;
                  });

                  if (widget.onRatingSelected != null) {
                    widget.onRatingSelected!(currentRating);
                  }
                },

          onDoubleTap: widget.readOnly
              ? null
              : () {
                  setState(() {
                    currentRating = 0;
                  });

                  if (widget.onRatingSelected != null) {
                    widget.onRatingSelected!(0);
                  }
                },

          child: Icon(
            starIndex <= currentRating
                ? Icons.star_rounded
                : Icons.star_border_rounded,
            size: widget.size,
            color: const Color.fromARGB(255, 52, 55, 57),
          ),
        );
      }),
    );
  }
}
