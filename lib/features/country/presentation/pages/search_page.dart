import 'package:weather_app/core/widgets/custom_error_message.dart';
import 'package:weather_app/core/widgets/gridient_scaffold.dart';
import 'package:weather_app/features/country/presentation/bloc/country/country_bloc.dart';
import 'package:weather_app/features/country/presentation/widgets/country_tile.dart';
import 'package:weather_app/features/wether/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool search = true;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: BlocConsumer<CountryBloc, CountryStates>(
        listener: (context, state) {
          if (state is SetLocationCountySuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customErrorMessage(state.country.country),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(
                  countryEnitity: state.country,
                ),
              ),
            );
          } else if (state is CountrySearchFaildState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customErrorMessage(state.message),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: search
                  ? TextField(
                      controller: searchController,
                      autofocus: true,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        if (value.length > 2) {
                          BlocProvider.of<CountryBloc>(context).add(
                            SearchForCountryEvent(query: value),
                          );
                        }
                      },
                    )
                  : const Text("Select a Country"),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        search = !search;
                      },
                    );
                  },
                  icon: search
                      ? const Icon(Icons.close)
                      : Image.asset(
                          "assets/images/search.png",
                          fit: BoxFit.cover,
                          height: 40,
                        ),
                ),
              ],
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }
}

Widget _buildBody(CountryStates state) {
  if (state is CountryInitState) {
    return const Center(
      child: Text(
        "Search for Country",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  if (state is CountryLoadingSearchState) {
    return const Center(
      child: CircularProgressIndicator(color: Colors.black),
    );
  } else if (state is CountryFinishSearchingState) {
    if (state.countrys.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.countrys.length,
        itemBuilder: (context, index) =>
            CountryTile(country: state.countrys[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      );
    }
    return const Center(
      child: Text(
        "No Country find with the provided data",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  return const SizedBox();
}
