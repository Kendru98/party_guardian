import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_guardian/models/alcohol_model.dart';
import 'package:provider/provider.dart';

import '../providers/managestate.dart';

class AlcoholListTile extends StatelessWidget {
  final Alcohols alcolist;

  AlcoholListTile(this.alcolist);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Manage>(context, listen: false);
    return ListTile(
      leading: SizedBox(
        width: 86,
        child: Column(
          children: [
            chooseIcon(alcolist.name),
            Text(
              alcolist.name,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
      title: Text('${alcolist.percent} %'),
      subtitle: Text('${alcolist.volume} ml'),
      trailing: IconButton(
        onPressed: () {
          provider.removeList(alcolist); //.remove(alcoList);
        },
        icon: const Icon(
          FontAwesomeIcons.x,
          color: Colors.red,
        ),
      ),
    );
  }
}

chooseIcon(String name) {
  if (name == 'Beer') {
    return Icon(
      FontAwesomeIcons.beerMugEmpty,
      size: 40,
    );
  } else if (name == 'Wine') {
    return Icon(FontAwesomeIcons.wineGlass, size: 40);
  } else if (name == 'Champagne') {
    return Icon(FontAwesomeIcons.champagneGlasses, size: 40);
  } else if (name == 'Vodka') {
    return Icon(Icons.liquor_rounded, size: 40);
  }
}
