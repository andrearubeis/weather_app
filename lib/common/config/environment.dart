enum Flavor {
	DEV,
	TEST,
	PROD
}

class Configuration {

	Flavor environment = Flavor.DEV;
	//static const Flavor environment = Flavor.TEST;
	//static const Flavor environment = Flavor.PROD;

}