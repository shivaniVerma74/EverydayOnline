// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:eshop_multivendor/Helper/Color.dart';
// import 'package:eshop_multivendor/Helper/String.dart';
// import 'package:eshop_multivendor/Provider/CategoryProvider.dart';
// import 'package:eshop_multivendor/Provider/HomeProvider.dart';
// import 'package:eshop_multivendor/Screen/SubCategory.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
//
// import '../Helper/Session.dart';
// import '../Model/Section_Model.dart';
// import 'HomePage.dart';
// import 'ProductList.dart';
//
// class AllCategory extends StatefulWidget {
//   @override
//   State<AllCategory> createState() => _AllCategoryState();
// }
//
// class _AllCategoryState extends State<AllCategory> {
//   @override
//   void initState() {
//     super.initState();
//     getCat();
//   }
//   Future<void> getCat() async {
//     await Future.delayed(Duration.zero);
//     Map parameter = {
//       CAT_FILTER: "false",
//     };
//     apiBaseHelper.postAPICall(getCatApi, parameter).then((getdata) {
//       bool error = getdata["error"];
//       String? msg = getdata["message"];
//       print("Categories parameter ${parameter.toString()}");
//       if (!error) {
//         var data = getdata["data"];
//         catList =
//             (data as List).map((data) => new Product.fromCat(data)).toList();
//         if (getdata.containsKey("popular_categories")) {
//           var data = getdata["popular_categories"];
//           print("successssss");
//           popularList =
//               (data as List).map((data) => new Product.fromCat(data)).toList();
//           if (popularList.length > 0) {
//             Product pop = new Product.popular("Popular", imagePath + "popular.svg");
//             catList.insert(0, pop);
//             context.read<CategoryProvider>().setSubList(popularList);
//           }
//         }
//       } else {
//         setSnackbar(msg!, context);
//       }
//       context.read<HomeProvider>().setCatLoading(false);
//     }, onError: (error) {
//       setSnackbar(error.toString(), context);
//       context.read<HomeProvider>().setCatLoading(false);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<HomeProvider>(
//         builder: (context, homeProvider, _) {
//           if (homeProvider.catLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return catList.length > 0
//               ? Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Expanded(
//                       child: Selector<CategoryProvider, List<Product>>(
//                         builder: (context, data, child) {
//                           return data.length > 0
//                               ? GridView.count(
//                                   padding: EdgeInsets.symmetric(horizontal: 20),
//                                   crossAxisCount: 3,
//                                   shrinkWrap: true,
//                                   crossAxisSpacing: 5,
//                                   children: List.generate(
//                                     data.length,
//                                     (index) {
//                                       return subCatItem(data, index, context);
//                                     },
//                                   ))
//                               : Center(
//                                   child:
//                                       Text(getTranslated(context, 'noItem')!));
//                         },
//                         selector: (_, categoryProvider) =>
//                             categoryProvider.subList,
//                       ),
//                     ),
//                   ],
//                 )
//               : Container();
//         },
//       ),
//     );
//   }
//
//   Widget catItem(int index, BuildContext context1) {
//     return Selector<CategoryProvider, int>(
//       builder: (context, data, child) {
//         if (index == 0 && (popularList.length > 0)) {
//           return GestureDetector(
//             child: Container(
//               height: 100,
//               decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: data == index
//                       ? Theme.of(context).colorScheme.white
//                       : Colors.transparent,
//                   border: data == index
//                       ? Border(
//                           left: BorderSide(width: 5.0, color: colors.primary),
//                         )
//                       : null
//                   // borderRadius: BorderRadius.all(Radius.circular(20))
//                   ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(25.0),
//                       child: SvgPicture.asset(
//                         data == index
//                             ? imagePath + "popular_sel.svg"
//                             : imagePath + "popular.svg",
//                         color: colors.primary,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     catList[index].name! + "\n",
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context1).textTheme.caption!.copyWith(
//                         color: data == index
//                             ? colors.primary
//                             : Theme.of(context).colorScheme.fontColor),
//                   )
//                 ],
//               ),
//             ),
//             onTap: () {
//               context1.read<CategoryProvider>().setCurSelected(index);
//               context1.read<CategoryProvider>().setSubList(popularList);
//             },
//           );
//         } else {
//           return GestureDetector(
//             child: Container(
//               height: 100,
//               decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: data == index
//                       ? Theme.of(context).colorScheme.white
//                       : Colors.transparent,
//                   border: data == index
//                       ? Border(
//                           left: BorderSide(width: 5.0, color: colors.primary),
//                         )
//                       : null),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(25.0),
//                           child: FadeInImage(
//                             image: CachedNetworkImageProvider(
//                                 catList[index].image!),
//                             fadeInDuration: Duration(milliseconds: 150),
//                             fit: BoxFit.contain,
//                             imageErrorBuilder: (context, error, stackTrace) =>
//                                 erroWidget(50),
//                             placeholder: placeHolder(50),
//                           )),
//                     ),
//                   ),
//                   Text(
//                     catList[index].name! + "\n",
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context1).textTheme.caption!.copyWith(
//                         color: data == index
//                             ? colors.primary
//                             : Theme.of(context).colorScheme.fontColor),
//                   )
//                 ],
//               ),
//             ),
//             onTap: () {
//               context1.read<CategoryProvider>().setCurSelected(index);
//               if (catList[index].subList == null ||
//                   catList[index].subList!.length == 0) {
//                 print("kjhasdashjkdkashjdksahdsahdk");
//                 context1.read<CategoryProvider>().setSubList([]);
//                 Navigator.push(
//                     context1,
//                     MaterialPageRoute(
//                       builder: (context) => ProductList(
//                         name: catList[index].name,
//                         id: catList[index].id,
//                         tag: false,
//                         fromSeller: false,
//                       ),
//                     ));
//               } else {
//                 context1
//                     .read<CategoryProvider>()
//                     .setSubList(catList[index].subList);
//               }
//             },
//           );
//         }
//       },
//       selector: (_, cat) => cat.curCat,
//     );
//   }
//
//   subCatItem(List<Product> subList, int index, BuildContext context) {
//     return GestureDetector(
//       child: Column(
//         children: <Widget>[
//           Expanded(
//               child: Card(
//             elevation: 4,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   image: DecorationImage(
//                       fit: BoxFit.contain,
//                       image: NetworkImage('${subList[index].image!}'))),
//               // child: FadeInImage(
//               //   image: CachedNetworkImageProvider(subList[index].image!),
//               //   fadeInDuration: Duration(milliseconds: 150),
//               //   fit: BoxFit.cover,
//               //   imageErrorBuilder: (context, error, stackTrace) =>
//               //       erroWidget(50),
//               //   placeholder: placeHolder(50),
//               // ),
//             ),
//           )),
//           Text(
//             subList[index].name! + "\n",
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: Theme.of(context)
//                 .textTheme
//                 .caption!
//                 .copyWith(color: Theme.of(context).colorScheme.fontColor),
//           )
//         ],
//       ),
//       onTap: () {
//         if (context.read<CategoryProvider>().curCat == 0 &&
//             popularList.length > 0) {
//           if (popularList[index].subList == null ||
//               popularList[index].subList!.length == 0) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductList(
//                     name: popularList[index].name,
//                     id: popularList[index].id,
//                     tag: false,
//                     fromSeller: false,
//                   ),
//                 ));
//           } else {
//
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SubCategory(
//                     subList: popularList[index].subList,
//                     title: popularList[index].name ?? "",
//                     catId: popularList[index].id,
//                   ),
//                 ));
//           }
//         } else if (subList[index].subList == null ||
//             subList[index].subList!.length == 0) {
//           print(StackTrace.current);
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ProductList(
//                   name: subList[index].name,
//                   id: subList[index].id,
//                   tag: false,
//                   fromSeller: false,
//                 ),
//               ));
//         } else {
//           print(StackTrace.current);
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SubCategory(
//                   subList: subList[index].subList,
//                   title: subList[index].name ?? "",
//                 ),
//               ));
//         }
//       },
//     );
//   }
// }
//
//
//

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:eshop_multivendor/Provider/CategoryProvider.dart';
import 'package:eshop_multivendor/Provider/HomeProvider.dart';
import 'package:eshop_multivendor/Screen/SubCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../Helper/Session.dart';
import '../Model/Section_Model.dart';
import 'Favorite.dart';
import 'HomePage.dart';
import 'Login.dart';
import 'NotificationLIst.dart';
import 'ProductList.dart';
import 'Search.dart';

class AllCategory extends StatefulWidget {
  final bool isAppBar;
  final String? catId;
  AllCategory({Key? key, required this.isAppBar, this.catId}) : super(key: key);
  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  @override
  void initState() {
    super.initState();
    getCat();
  }

  List<Product> catList = [];
  Future<void> getCat() async {
    await Future.delayed(Duration.zero);
    Map parameter = {
      CAT_FILTER: "false",
    };
    apiBaseHelper.postAPICall(getCatApi, parameter).then((getdata) {
      bool error = getdata["error"];
      String? msg = getdata["message"];
      if (!error) {
        var data = getdata["data"];
        catList =
            (data as List).map((data) => new Product.fromCat(data)).toList();
        if (getdata.containsKey("popular_categories")) {
          var data = getdata["popular_categories"];
          // popularList =
          //     (data as List).map((data) => new Product.fromCat(data)).toList();
          // if (popularList.length > 0) {
          //   Product pop =
          //       new Product.popular("Popular", imagePath + "popular.svg");
          //   catList.insert(0, pop);
          //   context.read<CategoryProvider>().setSubList(popularList);
          // }
        }
      } else {
        setSnackbar(msg!, context);
      }

      context.read<HomeProvider>().setCatLoading(false);
    }, onError: (error) {
      setSnackbar(error.toString(), context);
      context.read<HomeProvider>().setCatLoading(false);
    });
  }

  // AppBar _getAppBar() {
  //   return  widget.isAppBar ?
  //   AppBar(
  //       elevation: 0,
  //       centerTitle:  false,
  //       title:  Text(
  //         getTranslated(context, 'CATEGORY')!,
  //         style: TextStyle(
  //             color: colors.lightWhite2, fontWeight: FontWeight.normal),
  //       ),
  //       iconTheme: new IconThemeData(color: colors.lightWhite2),
  //       // centerTitle:_curSelected == 0? false:true,
  //       actions: <Widget>[
  //         InkWell(
  //           child: Center(
  //               child: SvgPicture.asset(
  //                 imagePath + "search.svg",
  //                 height: 20,
  //                 color: colors.lightWhite2,
  //               )),
  //           onTap: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => Search(),
  //                 ));
  //           },
  //         ),
  //         IconButton(
  //           icon: SvgPicture.asset(
  //             imagePath + "desel_notification.svg",
  //             color: colors.lightWhite2,
  //           ),
  //           onPressed: () {
  //             CUR_USERID != null
  //                 ? Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => NotificationList(),
  //                 ))
  //                 : Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => Login(),
  //                 ));
  //           },
  //         ),
  //         IconButton(
  //           padding: EdgeInsets.all(0),
  //           icon: SvgPicture.asset(
  //             imagePath + "desel_fav.svg",
  //             color: colors.lightWhite2,
  //           ),
  //           onPressed: () {
  //             CUR_USERID != null
  //                 ? Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => Favorite(),
  //                 ))
  //                 : Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => Login(),
  //                 ));
  //           },
  //         ),
  //       ],
  //       backgroundColor: colors.primary
  //   )
  //       : AppBar(
  //     elevation: 0,
  //     backgroundColor:  Theme.of(context).colorScheme.lightWhite,
  //   );
  // }

  _searchBar() {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: colors.primary),
                color: Theme.of(context).colorScheme.white),
            // padding: EdgeInsets.symmetric(vertical: 8),
            // color: Theme.of(context).colorScheme.white,
            child: ListTile(
              dense: true,
              minLeadingWidth: 10,
              leading: Icon(
                Icons.search,
              ),
              title: Text("Search Here", style: TextStyle(fontSize: 16, color: Colors.black26),),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _getAppBar(),
      body:
      Consumer<HomeProvider>(
        builder: (context, homeProvider, _) {
          if (homeProvider.catLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return catList.length > 0
              ? Column(
            children: [
              SizedBox(
                height: 10,
              ),
              _searchBar(),
              SizedBox(
                height: 10,
              ),
              Expanded(child: catList.length >0  ? GridView.count(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  crossAxisSpacing: 5,
                  children: List.generate(
                    catList.length,
                        (index) {
                      return subCatItem(catList, index, context);
                    },
                  )) : Center(child: Text("No category to show"))),
              // Expanded(
              //   child: Selector<CategoryProvider, List<Product>>(
              //     builder: (context, data, child) {
              //       return data.length > 0
              //           ? GridView.count(
              //               padding: EdgeInsets.symmetric(horizontal: 20),
              //               crossAxisCount: 3,
              //               shrinkWrap: true,
              //               crossAxisSpacing: 5,
              //               children: List.generate(
              //                 data.length,
              //                 (index) {
              //                   return subCatItem(data, index, context);
              //                 },
              //               ))
              //           : Center(
              //               child:
              //                   Text(getTranslated(context, 'noItem')!));
              //     },
              //     selector: (_, categoryProvider) =>
              //         categoryProvider.subList,
              //   ),
              // ),
            ],
          ) : Container();
        },
      ),
    );
  }


  Widget catItem(int index, BuildContext context1) {
    return Selector<CategoryProvider, int>(
      builder: (context, data, child) {
        if (index == 0 && (popularList.length > 0)) {
          return GestureDetector(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: data == index
                      ? Theme.of(context).colorScheme.white
                      : Colors.transparent,
                  border: data == index
                      ? Border(
                    left: BorderSide(width: 5.0, color: colors.primary),
                  ) : null
                // borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: SvgPicture.asset(
                        data == index
                            ? imagePath + "popular_sel.svg"
                            : imagePath + "popular.svg",
                        color: colors.primary,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    catList[index].name! + "\n",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context1).textTheme.caption!.copyWith(
                        color: data == index
                            ? colors.primary
                            : Theme.of(context).colorScheme.fontColor),
                  )
                ],
              ),
            ),
            onTap: () {
              context1.read<CategoryProvider>().setCurSelected(index);
              context1.read<CategoryProvider>().setSubList(popularList);
            },
          );
        } else {
          return GestureDetector(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: data == index
                      ? Theme.of(context).colorScheme.white
                      : Colors.transparent,
                  border: data == index
                      ? Border(
                    left: BorderSide(width: 5.0, color: colors.primary),
                  )
                      : null),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: FadeInImage(
                            image: CachedNetworkImageProvider(
                                catList[index].image!),
                            fadeInDuration: Duration(milliseconds: 150),
                            fit: BoxFit.fill,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                erroWidget(50),
                            placeholder: placeHolder(50),
                          )),
                    ),
                  ),
                  Text(
                    catList[index].name! + "\n",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context1).textTheme.caption!.copyWith(
                        color: data == index
                            ? colors.primary
                            : Theme.of(context).colorScheme.fontColor),
                  )
                ],
              ),
            ),
            onTap: () {
              context1.read<CategoryProvider>().setCurSelected(index);
              if (catList[index].subList == null ||
                  catList[index].subList!.length == 0) {
                print("kjhasdashjkdkashjdksahdsahdk");
                context1.read<CategoryProvider>().setSubList([]);
                Navigator.push(
                    context1,
                    MaterialPageRoute(
                      builder: (context) => ProductList(
                        name: catList[index].name,
                        id: catList[index].id,
                        tag: false,
                        catId: widget.catId,
                        fromSeller: false,
                      ),
                    ));
              } else {
                context1
                    .read<CategoryProvider>()
                    .setSubList(catList[index].subList);
              }
            },
          );
        }
      },
      selector: (_, cat) => cat.curCat,
    );
  }

  // subCatItem(List<Product> subList, int index, BuildContext context) {
  //   return GestureDetector(
  //     child: Column(
  //       children: <Widget>[
  //         Expanded(
  //             child: Card(
  //               elevation: 4,
  //               shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(15),
  //                     image: DecorationImage(
  //                         fit: BoxFit.contain,
  //                         image: NetworkImage('${subList[index].image!}'))),
  //                 // child: FadeInImage(
  //                 //   image: CachedNetworkImageProvider(subList[index].image!),
  //                 //   fadeInDuration: Duration(milliseconds: 150),
  //                 //   fit: BoxFit.cover,
  //                 //   imageErrorBuilder: (context, error, stackTrace) =>
  //                 //       erroWidget(50),
  //                 //   placeholder: placeHolder(50),
  //                 // ),
  //               ),
  //             )),
  //         Text(
  //           subList[index].name! + "\n",
  //           textAlign: TextAlign.center,
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //           style: Theme.of(context)
  //               .textTheme
  //               .caption!
  //               .copyWith(color: Theme.of(context).colorScheme.fontColor),
  //         )
  //       ],
  //     ),
  //     onTap: () {
  //       if (context.read<CategoryProvider>().curCat == 0 &&
  //           popularList.length > 0) {
  //         print("checking admin data here ${popularList[index].subList} and ${popularList[index].id}");
  //         if (popularList[index].subList == null ||
  //             popularList[index].subList!.length == 0) {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => ProductList(
  //                   name: popularList[index].name,
  //                   id: popularList[index].id,
  //                   catId: popularList[index].id,
  //                   tag: false,
  //                   fromSeller: false,
  //                 ),
  //               ));
  //         } else {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => SubCategory(
  //                   subList: popularList[index].subList,
  //                   title: popularList[index].name ?? "",
  //                   catId: popularList[index].id,
  //                 ),
  //               ));
  //         }
  //       } else if (subList[index].subList == null ||
  //           subList[index].subList!.length == 0) {
  //         print(StackTrace.current);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => ProductList(
  //                 name: subList[index].name,
  //                 id: subList[index].id,
  //                 tag: false,
  //                 fromSeller: false,
  //               ),
  //             ));
  //       } else {
  //         print(StackTrace.current);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SubCategory(
  //                 subList: subList[index].subList,
  //                 title: subList[index].name ?? "",
  //               ),
  //             ));
  //       }
  //     },
  //   );
  // }

  subCatItem(List<Product> subList, int index, BuildContext context)
  {
    print("surendra=========>${subList[index].id}");
    print("sublist ${subList[index]}");
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 5,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('${subList[index].image!}'),),),
                  // child: FadeInImage(
                  //   image: CachedNetworkImageProvider(subList[index].image!),
                  //   fadeInDuration: Duration(milliseconds: 150),
                  //   fit: BoxFit.cover,
                  //   imageErrorBuilder: (context, error, stackTrace) =>
                  //       erroWidget(50),
                  //   placeholder: placeHolder(50),
                  // ),
                )),

            Text(
              subList[index].name! + "\n",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Theme.of(context).colorScheme.fontColor),
            )

          ],
        ),
      ),
      onTap: () {
        if (context.read<CategoryProvider>().curCat == 0 &&
            popularList.length > 0) {
          if (popularList[index].subList == null ||
              popularList[index].subList!.length == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductList(
                    name: popularList[index].name,
                    id: popularList[index].id,
                    tag: false,
                    fromSeller: false,
                  ),
                ));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCategory(
                    subList: popularList[index].subList,
                    title: popularList[index].name ?? "",
                     catId: popularList[index].id,
                  ),
                ));
          }
        } else if (subList[index].subList == null ||
            subList[index].subList!.length == 0) {
          print(StackTrace.current);
          print("sublist ${subList[index]}");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductList(
                  name: subList[index].name,
                  id: subList[index].id,
                  tag: false,
                  fromSeller: false,
                   catId: subList[index].id,
                  // catId: "${widget.catId.toString()}",
                  // catId: subList[index].categoryId,
                ),
              ));
        } else {
          print(StackTrace.current);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubCategory(
                  subList: subList[index].subList,
                  title: subList[index].name ?? "",
                    catId: subList[index].id
                ),
              ));
        }
      },
    );
  }

}

