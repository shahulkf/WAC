

import 'dart:convert';
import 'dart:developer';
import 'dart:io'; // For handling SocketException

import 'package:flutter/material.dart';
import 'package:task/model/model.dart';
import 'package:task/services/api_services.dart';
import 'package:task/services/local_db_services.dart';
import 'package:task/view/widgets/banner_slider.dart';
import 'package:task/view/widgets/category.dart';
import 'package:task/view/widgets/product.dart';
import 'package:task/view/widgets/single_banner.dart';

class HomeViewModel extends ChangeNotifier {
  bool homeLoading = false;
  bool isOffline = false;

  updateNetworkStatus([bool value = false]) {
    isOffline = value;
    notifyListeners();
  }

  updateLoading([bool value = false]) {
    homeLoading = value;
    notifyListeners();
  }

  List<Model> _data = [];
  int _selectedIndex = 0;
  final ApiService _apiService;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Widget> homePageWidgets = [];
  List<Model> get data => _data;
  int get selectedIndex => _selectedIndex;

  HomeViewModel(this._apiService) {
    fetchDatas();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> fetchDatas() async {
    homePageWidgets = <Widget>[];
    updateLoading(true);
    try {
      _data = await _apiService.fetchProductData();
      for (var item in _data) {
        switch (item.type) {
          case "banner_slider":
            final contents = item.contents;
            if ((contents ?? []).isNotEmpty) {
              homePageWidgets.add(BannerSliderWidget(contents ?? []));
            }
            break;
          case "products":
            final contents = item.contents;
            if ((contents ?? []).isNotEmpty) {
              homePageWidgets.add(ProductWidget(
                contents ?? [],
                title: item.title,
              ));
            }
            break;
          case "banner_single":
            final imageUrl = item.imageUrl;
            if (imageUrl != null) {
              homePageWidgets.add(SingleBannerWidget(imageUrl));
            }
            break;
          case "categories": // Corrected spelling to 'categories'
            final contents = item.contents;
            if ((contents ?? []).isNotEmpty) {
              homePageWidgets.add(CategoryWidget(contents ?? []));
            }
            break;
          default:
            log('Unknown widget type: ${item.type}');
        }
      }

      // Save data to local database for offline use
      await _dbHelper
          .insertData(json.encode(_data.map((item) => item.toJson()).toList()));

      notifyListeners();
    } on SocketException {
      updateNetworkStatus(true);
      log('Network error: Unable to reach the server.');
      await fetchDataFromDatabase();
    } catch (e) {
      log('Unexpected error: $e');
    } finally {
      updateLoading(false);
    }
  }

  Future<void> fetchDataFromDatabase() async {
    try {
      _data = await _dbHelper.fetchData();
      homePageWidgets = <Widget>[];

      for (var item in _data) {
        switch (item.type) {
          case "banner_slider":
            final contents = item.contents;
            if ((contents ?? []).isNotEmpty) {
              homePageWidgets.add(BannerSliderWidget(contents ?? []));
            }
            break;
          case "products":
            final contents = item.contents;
            if ((contents ?? []).isNotEmpty) {
              homePageWidgets.add(ProductWidget(
                contents ?? [],
                title: item.title,
              ));
            }
            break;
          case "banner_single":
            final imageUrl = item.imageUrl;
            if (imageUrl != null) {
              homePageWidgets.add(SingleBannerWidget(imageUrl));
            }
            break;
          case "categories": // Corrected spelling to 'categories'
            final contents = item.contents;
            if ((contents ?? []).isNotEmpty) {
              homePageWidgets.add(CategoryWidget(contents ?? []));
            }
            break;
          default:
            log('Unknown widget type: ${item.type}');
        }
      }

      notifyListeners();
    } catch (e) {
      log('Error fetching data from database: $e');
    }
  }
}
