import 'package:cached_network_image/cached_network_image.dart';
import 'package:codex/widgets/NavigationServies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloces/productdetalis_bloc/productdetalis_bloc.dart';
import 'Viewproduct.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<ProductdetalisBloc>(context).add(FetchProductdetalis());
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<ProductdetalisBloc, ProductdetalisState>(
        builder: (context, state) {
          if (state is ProductdetalisblocLoding) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProductdetalisblocLoaded) {
            final productList = state.productdetalisModel;
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75, // Adjust the aspect ratio as needed
              ),
              itemCount:productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return InkWell(
                  onTap: ()async{
                  NavigationService.pushAndRemoveUntil(Viewproduct(productid: product.id.toString(),), (Route<dynamic>route) => false);
                  },
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: product.partImage ?? "",
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.partsName ?? "No Name",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                product.description ?? "No Description",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                "\$${product.price}",
                                style: const TextStyle(
                                    color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16.0),
                                  const SizedBox(width: 4.0),
                                  Text(product.productRating??""),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is ProductdetalisblocError) {
            return Center(child: Text(state.Errormessage));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
