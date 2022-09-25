import 'package:banco_tiempo_app/app/presentation/shared_widgets/custom_input_text_widget.dart';
import 'package:banco_tiempo_app/cross_features/authentication/presentation/widgets/input_field.dart';
import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';
import 'package:banco_tiempo_app/cross_features/category/infraestructure/category_repository.dart';
import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/poc/presentation/pages/post_list.dart';
import 'package:banco_tiempo_app/features/services/domain/service_entity.dart';
import 'package:banco_tiempo_app/features/services/infraestructure/payload/service_payload.dart';
import 'package:banco_tiempo_app/features/services/presentation/bloc/service_bloc.dart';
import 'package:banco_tiempo_app/features/services/presentation/pages/service_list.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/app_theme.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Text("Servicios, Talentos o Bienes"),
        ),
        body: BlocProvider(
          create: (context) => ServiceBloc()
            ..add(
              RefreshServices(),
            ),
          child: ServiceBody(),
        ));
  }
}

class ServiceBody extends StatefulWidget {
  const ServiceBody({Key? key}) : super(key: key);

  @override
  State<ServiceBody> createState() => _ServiceBodyState();
}

class _ServiceBodyState extends State<ServiceBody> {
  ScrollController _scrollController = ScrollController();
  late ServiceBloc _serviceBloc;
  late TextEditingController searchBarController;
  late FocusNode searchBarFocus;
  late List<Categoria> categories;
  late Categoria selectedCategory;
  late bool isOpen;
  CategoryRepository _categoryRepository = CategoryRepository();

  late List<Categoria>? dynamicCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _serviceBloc = context.read<ServiceBloc>();
    _scrollController.addListener(_onScroll);
    searchBarController = TextEditingController();
    searchBarFocus = FocusNode();
    isOpen = false;

    categories = [
      Categoria(
        id: "0",
        nombre: "Cargando",
        imagenUrl: "imagenUrl",
      ),
    ];

    selectedCategory = categories.first;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategories();
    });
  }

  _getCategories() async {
    await _categoryRepository.getCategories().then((value) {
      setState(() {
        print("entra aqui o ke");
        print(value);
        categories = value ?? categories;
        selectedCategory = categories.first;
        print(categories);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorPrimary.primaryColor),
      child: Column(
        children: [
          Padding(
            padding: kVPadding,
            child: ExpandablePanel(
              theme: ExpandableThemeData(
                hasIcon: false,
              ),
              header: Container(
                height: 30,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "FILTRO",
                        style: titleLable.copyWith(
                            color: ColorPrimary.primaryColor),
                      ),
                      Icon(
                        Icons.filter_list,
                        color: ColorPrimary.primaryColor,
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              collapsed: SizedBox(),
              expanded: Padding(
                padding: const EdgeInsets.only(
                    right: 0.0, left: 0.0, top: 10, bottom: 0),
                child: Column(
                  children: [
                    verticalSpace10,
                    DropdownButtonFormField<Categoria>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      items: categories
                          .map((e) => DropdownMenuItem<Categoria>(
                                child: Text(e.nombre),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) => setState(() {
                        selectedCategory = value!;
                      }),
                      value: selectedCategory,
                    ),
                    verticalSpace10,
                    InputField(
                      padding: EdgeInsets.zero,
                      focusNode: searchBarFocus,
                      textController: searchBarController,
                      label: "Buscar Servicios",
                      icons: const Icon(
                        Icons.search,
                        color: ColorPrimary.primaryColor,
                      ),
                      isPassword: false,
                      backgroundColor: Colors.white,
                      color: ColorPrimary.primaryColor,
                    ),
                    verticalSpace10,
                    Padding(
                      padding: EdgeInsets.zero,
                      child: InkWell(
                        child: Container(
                          height: 40,
                          color: Colors.white,
                          child: Center(
                            child: Text("FILTRAR"),
                          ),
                        ),
                        onTap: () {
                          print(searchBarController.text);
                          print(selectedCategory.id);
                          _serviceBloc
                            ..add(
                              FilterServices(
                                servicePayload: ServicePayload(
                                    categorias: (selectedCategory.id != 0)
                                        ? [selectedCategory.id]
                                        : [],
                                    pagina: 0,
                                    query: searchBarController.text),
                              ),
                            );
                        },
                      ),
                    ),
                    verticalSpace10,
                  ],
                ),
              ),
            ),
          ),
          verticalSpace10,
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {
                  if (state is ServiceInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ServiceLoaded) {
                    if (state.services.isEmpty)
                      return Center(
                        child: Text("No Services"),
                      );

                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ServiceList(
                        scrollController: _scrollController,
                        state: state,
                      ),
                    );
                  }

                  return Center(child: Text("Error Fetched Posts"));
                },
              ),
            ),
          ),
        ],
      ),
    );

    /* return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, state) {
        if (state is ServiceInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ServiceLoaded) {
          if (state.services.isEmpty)
            return Center(
              child: Text("No Services"),
            );

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ServiceList(
              scrollController: _scrollController,
              state: state,
            ),
          );
        }

        return Center(child: Text("Error Fetched Posts"));
      },
    ); */
  }

  Future<void> _onRefresh() async {
    _serviceBloc..add(RefreshServices());
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll)
      _serviceBloc
        ..add(
          GetServices(
            servicePayload: ServicePayload(
                categorias: [],
                pagina: _serviceBloc.state.actualPage,
                query: ""),
          ),
        );
  }
}
