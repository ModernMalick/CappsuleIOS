//
//  HomeView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 03/11/2021.
//

import SwiftUI

struct HomeView: View {
	
	@State private var selectedWarmthHeavy = true
	@State private var selectedWarmthFilter = "Heavy"
	@State private var weatherDesc = ""
	@State private var weatherlogo = "weather"
	@State private var temperature = ""
	@State private var city = ""
	@State private var showMore = false
	private var apiKey = "d6ec42cf87a93d3d280eb8b3e98d8436"
	
	@StateObject var locationManager = LocationManager()
	
	@State private var instanceID = 1;
	
	@ObservedObject var networkManager = NetworkManager()
	
	var userLatitude: String {
		return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
	}
	
	var userLongitude: String {
		return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
	}
	
	var outfitView: some View {
		HomeOutfitView(selectedWarmth: selectedWarmthFilter, instanceID: instanceID).equatable()
	}
	
	@State var items : [Any] = []
	@State var shareSheet = false
	
	@State var saveSheet = false
	@State var outfitImage : UIImage = UIImage.init(named: "logo")!
	
	@AppStorage("metric") private var useMetric = true
	@AppStorage("minLight") private var minLight = 20
	
	@State private var unitSymbol = "C"
	
    var body: some View {
		ZStack{
			VStack{
				if((locationManager.statusString == "authorizedWhenInUse" || locationManager.statusString == "authorizedAlways") && networkManager.isConnected){
					HStack(){
						Image("location")
							.renderingMode(.template)
							.foregroundColor(Color("ColorOnBackground"))
						Text(city)
							.frame(width: 90.0)
						Spacer()
						Image(weatherlogo)
							.resizable()
							.frame(width: 60.0, height: 60.0)
						Spacer()
						Text(temperature + "°" + unitSymbol)
							.frame(width: 90.0, alignment: .trailing)
						Image("thermometer")
							.renderingMode(.template)
							.foregroundColor(Color("ColorOnBackground"))
					}.onAppear(perform: getWeather)
						.padding(.horizontal, 10.0)
					Spacer()
				}
				HStack{
					Text("Light")
						.fontWeight(selectedWarmthHeavy ? .regular : .bold)
						.frame(width: 55.0)
					Spacer()
						.frame(width: 50.0)
					Toggle("", isOn: Binding<Bool>(
						get: {selectedWarmthHeavy},
						set: {
							selectedWarmthHeavy = $0
							setWeather()
						}))
						.tint(Color("AccentLight"))
						.labelsHidden()
					Spacer()
						.frame(width: 50.0)
					Text("Heavy")
						.fontWeight(selectedWarmthHeavy ? .bold : .regular)
						.frame(width: 55.0)
				}
				Spacer()
				outfitView
				Spacer()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			HStack{
				Spacer()
				VStack{
					Spacer()
					Button(action: {
						instanceID += 1
					}){
						Image(systemName: "arrow.2.circlepath")
							.scaleEffect(1.65)
							.tint(Color.black)
					}
					.frame(width: 65, height: 65)
					.background(Color("AccentLight"))
					.cornerRadius(50)
					
				}
			}
			.frame(maxWidth: .infinity)
		}
		.onChange(of: locationManager.lastLocation) { newValue in
			getWeather()
		}
		.padding(.all, 20.0)
		.sheet(isPresented: $shareSheet, content: {
			ShareSheet(items: items)
		})
		.sheet(isPresented: $saveSheet, content: {
			SaveOutfitView(outfitImage)
		})
	}
	func getWeather(){
		if(locationManager.lastLocation != nil){
		locationManager.geocoder.reverseGeocodeLocation(locationManager.lastLocation!, completionHandler:
		{
			placemarks, error -> Void in
				
		guard let placeMark = placemarks?.first else {return}
		
		if let cityName = placeMark.locality{
			city = cityName
			var unit = ""
			if(useMetric){
				unit = "metric"
				unitSymbol = "C"
			} else {
				unit = "imperial"
				unitSymbol = "F"
			}
			let data = getData(city: city, unit: unit, apiKey: apiKey)
			fetchData(url:data) { (dict, error) in
				if let main = dict!["main"] as? NSDictionary {
					if let temp = main["temp"] as? Double {
						temperature = String(describing: temp)
						if(temp < Double(minLight)){
							selectedWarmthHeavy = true
						} else {
							selectedWarmthHeavy = false
						}
						setWeather()
					}
				}
				if let weather = dict!["weather"] as? [NSDictionary] {
					if let weatherA = weather.first {
						if let weatherMain = weatherA["main"] as? String {
							weatherDesc = weatherMain
							switch weatherDesc {
								case "Thunderstorm", "Drizzle", "Rain":
									weatherlogo = "rain"
									
								case "Snow":
									weatherlogo = "snow"
									
								case "Clouds", "Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash", "Squall", "Tornado":
									weatherlogo = "cloudy"
									
								case "Clear":
									weatherlogo = "sun"

								default:
									weatherlogo = "weather"
							}
						}
					}
				}
			}
		}
		})}
	}
	func setWeather(){
		if(selectedWarmthHeavy){
			selectedWarmthFilter = "Heavy"
		} else {
			selectedWarmthFilter = "Light"
		}
		instanceID += 1
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
		HomeView()
    }
}
