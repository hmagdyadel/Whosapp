import 'package:flutter/material.dart';
import 'package:whosapp/model/country_model.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key, this.setCountryData}) : super(key: key);
  final Function? setCountryData;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<CountryModel> countries = [
    CountryModel(name: 'Australia', code: '+61', flag: '🇦🇺'),
    CountryModel(name: 'Belgium', code: '+32', flag: '🇧🇪'),
    CountryModel(name: 'China', code: '+86', flag: '🇨🇳'),
    CountryModel(name: 'Egypt', code: '+2', flag: '🇪🇬'),
    CountryModel(name: 'Germany', code: '+49', flag: '🇩🇪'),
    CountryModel(name: 'Italy', code: '+39', flag: '🇮🇹'),
    CountryModel(name: 'Kuwait', code: '+965', flag: '🇰🇼'),
    CountryModel(name: 'Spain', code: '+34', flag: '🇪🇸'),
    CountryModel(name: 'South Africa', code: '+27', flag: '🇿🇦'),
    CountryModel(name: 'United States', code: '+1', flag: '🇺🇸'),
    CountryModel(name: 'United Kingdom', code: '+44', flag: '🇬🇧'),
    CountryModel(name: 'United Arab Emirates', code: '+971', flag: '🇦🇪'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.teal,
          ),
        ),
        title: const Text(
          'Choose a country',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            wordSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.teal,
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) => cart(
          countries[index],
        ),
      ),
    );
  }

  Widget cart(CountryModel country) {
    return InkWell(
      onTap: () {
        widget.setCountryData!(country);
      },
      child: Card(
        margin: const EdgeInsets.all(0.15),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Row(
            children: [
              Text(
                country.flag!,
              ),
              const SizedBox(width: 15),
              Text(
                country.name!,
              ),
              Expanded(
                child: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        country.code!,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
