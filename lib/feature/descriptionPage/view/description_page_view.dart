import 'package:flutter/material.dart';

class DescriptionPageView extends StatelessWidget {
  const DescriptionPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://picsum.photos/300/300",
                  fit: BoxFit.cover,
                ),
                const Text("Köpek Gezdirme", textAlign: TextAlign.end),
                const Text("Golden cinsi köpeğimi Atatürk parkında 1 saat gezdirecek birini arıyorum"),
                   const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "İlan Detayları",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("İlan Tarihi 22.03.2022")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text("Furkan Can Altunbaş"),
                        
                        Text("Fiyat : 50TL"),
                        Text("Cep: 055550000000"),
                        Text("ADDRESS"),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
