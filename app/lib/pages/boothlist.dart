import 'package:flutter/material.dart';

class BoothList extends StatefulWidget {
  @override
  _BoothListState createState() => _BoothListState();
}

class _BoothListState extends State<BoothList> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  final List<Booth> booths = [
    Booth(
      name: 'Basic Booth',
      details: 'Size: 10x10 ft\nBasic\nRM 400 per unit',
      image: 'assets/image/basic.jpg',
      description: 'A basic booth suitable for small exhibitors.',
      features: ['Basic lighting', 'One table', 'Two chairs'],
      priceDetails: 'RM 400 per unit.',
    ),
    Booth(
      name: 'Standard Booth',
      details: 'Size: 15x15 ft\nStandard\nRM 800 per unit',
      image: 'assets/image/standard.jpg',
      description: 'A standard booth with additional space.',
      features: ['Enhanced lighting', 'Two tables', 'Four chairs'],
      priceDetails: 'RM 800 per unit.',
    ),
    Booth(
      name: 'Premium Booth',
      details: 'Size: 20x20 ft\nPremium\nRM 1200 per unit',
      image: 'assets/image/premium.jpg',
      description: 'A premium booth for larger displays.',
      features: ['Premium lighting', 'Three tables', 'Six chairs', 'Carpet'],
      priceDetails: 'RM 1200 per unit.',
    ),
    Booth(
      name: 'Luxury Booth',
      details: 'Size: 25x25 ft\nLuxury\nRM 2000 per unit',
      image: 'assets/image/luxury.jpg',
      description: 'A luxury booth for high-end exhibitors.',
      features: [
        'Luxury lighting',
        'Four tables',
        'Eight chairs',
        'Carpet',
        'WiFi'
      ],
      priceDetails: 'RM 2000 per unit.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int page = _pageController.page!.round();
      if (page == booths.length) {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Booths'),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: booths.length,
        itemBuilder: (context, index) {
          return Center(
            child: BoothCard(booth: booths[index]),
          );
        },
      ),
    );
  }
}

class Booth {
  final String name;
  final String details;
  final String image;
  final String description;
  final List<String> features;
  final String priceDetails;

  Booth({
    required this.name,
    required this.details,
    required this.image,
    required this.description,
    required this.features,
    required this.priceDetails,
  });
}

class BoothCard extends StatelessWidget {
  final Booth booth;
  const BoothCard({required this.booth});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              booth.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booth.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Additional Items:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...booth.features.map((feature) => Text('- $feature')),
                  const SizedBox(height: 10),
                  Text(
                    'Price Details:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(booth.priceDetails),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                booth.image,
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                booth.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                booth.details,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Tap for Details',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.blue[300],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BoothList(),
  ));
}
