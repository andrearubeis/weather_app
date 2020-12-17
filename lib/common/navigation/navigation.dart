import 'dart:io';
import 'package:flutter/material.dart';
import 'package:weather_app/pages/city_page/city_page.dart';
import 'package:weather_app/pages/home_page/home_page.dart';
import 'package:weather_app/pages/search_city_page/search_city_page.dart';
import 'package:weather_app/pages/splash_page/splash_page.dart';

class RouteData {
	final Object model;
	final bool isFullScreen;
	final List<Object> additionalData;

	RouteData(
		{@required this.model,
			@required this.isFullScreen,
			@required this.additionalData});
}

enum AppPage {
	splash,
	home,
	city,
	searchCity
}

class RouteName {
	static const routeSplash = "/";
	static const routeHome = "home";
	static const routeCity = "city";
	static const routeSearchCity = "search_city";
}

class Navigation {
	static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>(debugLabel: 'Navigation');

	static isInRoute (String routeName) {
		if (ModalRoute.of(navKey.currentContext) != null){
			return ModalRoute.of(navKey.currentState.context).settings.name == routeName;
		}
	}

	static String _getRouteName(AppPage page) {
		String route;
		switch (page) {
			case AppPage.splash:
				route = RouteName.routeSplash;
				break;
			case AppPage.home:
				route = RouteName.routeHome;
				break;
			case AppPage.city:
				route = RouteName.routeCity;
				break;
		  case AppPage.searchCity:
			  route = RouteName.routeSearchCity;
			  break;
		}
		return route;
	}

	static Future pushTo(AppPage page, Object viewModel,
		{bool isFullsScreen = false, List<Object> additionalData}) {
		var route = _getRouteName(page);
		return Future.delayed(Duration.zero, () {
			return Navigation.navKey.currentState.pushNamed(route,
				arguments: RouteData(
					model: viewModel,
					isFullScreen: isFullsScreen,
					additionalData: additionalData));
		});
	}

	static pushReplacement(AppPage page,
		{Object viewModel,
			bool clearAll = false,
			bool isFullsScreen = false,
			List<Object> additionalData}) {
		var route = _getRouteName(page);
		Future.delayed(Duration.zero, () {
			if (clearAll) {
				// push and clear history
				Navigation.navKey.currentState.pushNamedAndRemoveUntil(
					route, (Route<dynamic> route) => false,
					arguments: RouteData(
						model: viewModel,
						isFullScreen: isFullsScreen,
						additionalData: additionalData));
			} else {
				// push and replace
				Navigation.navKey.currentState.pushReplacementNamed(route,
					arguments: RouteData(
						model: viewModel,
						isFullScreen: isFullsScreen,
						additionalData: additionalData,
					));
			}
		});
	}

	static popUntilRoot() {
		Navigation.navKey.currentState.popUntil((route) => route.isFirst);
	}

	static pop() {
		Future.delayed(Duration.zero, () {
			Navigation.navKey.currentState.pop();
		});
	}

	static Route getRoute(RouteSettings settings) {
		final RouteData object = settings.arguments;
		final model = object.model;
		final fullScreen = object.isFullScreen;
		switch (settings.name) {
			case RouteName.routeSplash:
				RouteSettings newSettings =
				RouteSettings(name: settings.name, arguments: settings.arguments);
				return _buildRoute(newSettings, SplashPage(model), fullScreen);
				break;
			case RouteName.routeHome:
				return _buildRoute(settings, HomePage(model), fullScreen);
				break;
			case RouteName.routeCity:
				return _buildRouteFade(settings, CityPage(model), fullScreen);
				break;
			case RouteName.routeSearchCity:
				return _buildRouteFromBottom(settings, SearchCityPage(model), fullScreen);
				break;
			default:
				print("Navigation: - Unknown route!");
				return null;
		}
	}

	static Route _buildRouteFade(
		RouteSettings settings, Widget builder, bool fullScreen) {
		return PageRouteBuilder(
			settings: settings,
			transitionDuration: Duration(milliseconds: 300),
			pageBuilder:
				(BuildContext context, Animation animation, Animation animation2) =>
			builder,
			transitionsBuilder: (BuildContext context, Animation animation,
				Animation animation2, Widget child) {
				return FadeTransition(
					opacity: animation,
					child: child,
				);
			});
	}

	static Route _buildRoute(
		RouteSettings settings, Widget builder, bool fullScreen) {
		if (!Platform.isIOS) {
			return PageRouteBuilder(
				settings: settings,
				transitionDuration: Duration(milliseconds: 200),
				pageBuilder: (BuildContext context, Animation animation,
					Animation animation2) =>
				builder,
				transitionsBuilder: (BuildContext context, Animation animation,
					Animation animation2, Widget child) {
					var begin;
					if (fullScreen) {
						begin = Offset(0.0, 1.0);
					} else {
						begin = Offset(1.0, 0.0);
					}
					var end = Offset.zero;
					var tween = Tween<Offset>(begin: begin, end: end);
					return SlideTransition(
						position: tween.animate(animation),
						child: child,
					);
				});
		} else {
			return MaterialPageRoute(
				fullscreenDialog: fullScreen,
				settings: settings,
				builder: (BuildContext context) => builder,
			);
		}
	}

	static Route _buildRouteFromTop(
		RouteSettings settings, Widget builder, bool fullScreen) {
		return PageRouteBuilder(
			settings: settings,
			transitionDuration: Duration(milliseconds: 400),
			pageBuilder: (BuildContext context, Animation animation, Animation animation2) =>
			builder,
			transitionsBuilder: (BuildContext context, Animation animation,
				Animation animation2, Widget child) {
				Tween t4 = new Tween<Offset>(
					begin: const Offset(0.0, -1.0),
					end: const Offset(0.0, 0.0),
				);

				Tween t12 = new Tween<Offset>(
					begin: const Offset(0.0, 0.0),
					end: const Offset(0.0, 0.8),
				);

				return SlideTransition(
					position: t4.animate(
						CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
					child: SlideTransition(
						position: t12.animate(CurvedAnimation(
							parent: animation2, curve: Curves.easeOutCubic)),
						child: child,
					),
				);
			});
	}

	static Route _buildRouteFromBottom(
		RouteSettings settings, Widget builder, bool fullScreen) {
		return PageRouteBuilder(
			settings: settings,
			transitionDuration: Duration(milliseconds: 400),
			pageBuilder:
				(BuildContext context, Animation animation, Animation animation2) {
				return builder;
			},
			transitionsBuilder: (BuildContext context, Animation animation,
				Animation animation2, Widget child) {
				Tween t4 = new Tween<Offset>(
					begin: const Offset(0.0, 1.0),
					end: const Offset(0.0, 0.0),
				);

				Tween t12 = new Tween<Offset>(
					begin: const Offset(0.0, 0.0),
					end: const Offset(0.0, 0.8),
				);

				return SlideTransition(
					position: t4.animate(
						CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
					child: child,
				);
			});
	}
}
