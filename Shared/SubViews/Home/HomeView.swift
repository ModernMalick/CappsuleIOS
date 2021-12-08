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
	@State private var weatherlogo = "weather"
	@State private var temperature = "9.18"
	@State private var unit = "C"
	@State private var city = ""
	private var apiKey = "d6ec42cf87a93d3d280eb8b3e98d8436"
	
	@StateObject var locationManager = LocationManager()
	
	var userLatitude: String {
		return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
	}
	
	var userLongitude: String {
		return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
	}
	
    var body: some View {
		VStack{
			if(locationManager.statusString == "authorizedWhenInUse" || locationManager.statusString == "authorizedAlways"){
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
					Text(temperature + "°" + unit)
						.frame(width: 90.0, alignment: .trailing)
					Image("thermometer")
						.renderingMode(.template)
						.foregroundColor(Color("ColorOnBackground"))
				}.onAppear(perform: getCity)
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
						if(selectedWarmthHeavy){
							selectedWarmthFilter = "Heavy"
						} else {
							selectedWarmthFilter = "Light"
						}
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
			HomeOutfitView(selectedWarmth: selectedWarmthFilter)
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
	func getCity(){
		locationManager.geocoder.reverseGeocodeLocation(locationManager.lastLocation!, completionHandler:
		{
			placemarks, error -> Void in
				
		guard let placeMark = placemarks?.first else {return}
		
		if let cityName = placeMark.locality{
			city = cityName
			let data = getData(city: city, unit: "metric", apiKey: apiKey)
			fetchData(url:data) { (dict, error) in
				print(dict.self?.keys as Any)
			}
		}
		})
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
