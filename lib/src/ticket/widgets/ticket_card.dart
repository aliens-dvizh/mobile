import 'package:dvizh_mob/src/shared/widgets/app_image.dart';
import 'package:dvizh_mob/src/ticket/models/ticket_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {


  const TicketCard({required this.onPressed, required this.ticket, super.key});

  final TicketModel ticket;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            AppImage(
              image: ticket.event?.images.firstOrNull?.url,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Text.rich(
              TextSpan(
                children: [
                  if(ticket.event?.holdedAt != null)... [
                    TextSpan(
                      text: DateFormat('MMMM, dd')
                          .format(ticket.event?.holdedAt ?? DateTime.now()),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: 5,
                        height: 5,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                  ],

                  TextSpan(
                    text: ticket.event?.category?.name,
                  ),
                ],
              ),
            ),
            Text(
              ticket.event?.name ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
  
}