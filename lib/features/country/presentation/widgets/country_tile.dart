import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/country/presentation/bloc/country/country_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CountryTile extends StatelessWidget {
  final CountryEnitity country;

  const CountryTile({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<CountryBloc>(context).add(
          SetLocationEvent(
            country: country,
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
        height: MediaQuery.sizeOf(context).height * 0.08,
        decoration: BoxDecoration(
          color: const Color.fromARGB(94, 255, 255, 255),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .75,
              child: Text(
                "${country.country}/${country.name}",
                softWrap: true,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              child: SvgPicture.network(
                "https://hatscripts.github.io/circle-flags/flags/${country.countryCode.toString().toLowerCase()}.svg",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
