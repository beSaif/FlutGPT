import 'package:flutgpt/model/empty_state_card_model.dart';
import 'package:flutter/material.dart';

class IntroCards extends StatelessWidget {
  final EmptyStateCardModel card;
  const IntroCards({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(card.icon),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(card.title, style: Theme.of(context).textTheme.headline3),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: card.items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${card.items[index]}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
