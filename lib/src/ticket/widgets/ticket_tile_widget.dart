import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptom_widgetbook/toptom_widgetbook.dart';

class TicketTileWidget extends StatelessWidget {
  const TicketTileWidget({
    this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onPressed,
    child: Row(
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '12.00',
              style: ThemeCore.of(context).typography.h5,
            ),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: '27 октября, ',
                  style: ThemeCore.of(context).typography.paragraphSmall,
                ),
                TextSpan(
                  text: 'пятница',
                  style: ThemeCore.of(context).typography.paragraphSmall.copyWith(
                    color: ThemeCore.of(context).color.scheme.textSecondary,
                    fontWeight: FontWeight.w400
                  ),
                )
              ]
            ),),
          ],
        ),
        const Spacer(),
        ElevatedButton(onPressed: onPressed,
            child: Text('9900 ₸'),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              textStyle: WidgetStatePropertyAll(ThemeCore.of(context).typography.paragraphSmall)
            ),
        ),
      ],
    ),
  );
}