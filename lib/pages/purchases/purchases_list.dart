import 'package:flutter/material.dart';
import 'package:raspcandy/providers/purchase_provider.dart';

import '../../utils/icon_util.dart';
import '../../widgets/back_button.dart';

class PurchasesList extends StatelessWidget {
  const PurchasesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Text(
                'Compras',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: purchaseProvider.getPurchases(),
                  initialData: [],
                  builder: (context, snapshot) {
                    return _createPurchasesList(context, snapshot.data!);
                  })
            ],
          ),
        )),
      ),
      floatingActionButton:
          FloatingBackButton(pressed: () => Navigator.pop(context)),
    );
  }

  Widget _createPurchasesList(BuildContext context, List<dynamic> purchases) {
    List<Widget> purchasesArray = [];

    for (var purchase in purchases) {
      purchasesArray.add(ListTile(
        leading: getCustomIcon('shopping', 30, 'primary'),
        title: Text('${purchase['candyName']}'),
        subtitle: Text('Fecha: ${purchase['dateOfPurchase']}'),
        trailing: Text('${purchase['size']}'),
        onTap: () {},
      ));
    }

    return Column(
      children: purchasesArray,
    );
  }
}
