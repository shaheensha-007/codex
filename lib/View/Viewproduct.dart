import 'package:cached_network_image/cached_network_image.dart';
import 'package:codex/View/Homepage.dart';
import 'package:codex/widgets/NavigationServies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloces/viewdetalis_bloc/viewdetalis_bloc.dart';

class Viewproduct extends StatefulWidget {
  const Viewproduct({super.key, required this.productid});
  final String productid;

  @override
  State<Viewproduct> createState() => _ViewproductState();
}

class _ViewproductState extends State<Viewproduct> {
  @override
  void initState() {
    super.initState();
    Viewproductcall();
  }

  void Viewproductcall() async {

    BlocProvider.of<ViewdetalisBloc>(context).add(Fetchviewdetalis(id: widget.productid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Product"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
           NavigationService.pushAndRemoveUntil(Homepage(), (Route<dynamic>route) => false);
          },
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: BlocBuilder<ViewdetalisBloc, ViewdetalisState>(
          builder: (context, state) {
            if (state is ViewdetalisblocLoading) {
              // Show a loading indicator while fetching data.
              return Center(child: CircularProgressIndicator());
            }
            if (state is ViewdetalisblocLoaded) {
              // If data is successfully loaded, show product details.
              final isviewiteams = state.viewProductModel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section
                  CachedNetworkImage(
                    imageUrl: isviewiteams.partImage ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  // Padding for the content
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isviewiteams.partsName ?? "",
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${isviewiteams.price}',
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          isviewiteams.description ?? "",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              isviewiteams.productRating ?? "",
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (state is ViewdetalisblocError) {
              // Show an error message if the API request fails.
              return Center(child: Text(state.errormessage));
            }
            // Return an empty widget if the state is unknown.
            return SizedBox();
          },
        ),
      ),
    );
  }
}
