//
//  WeatherManager.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 08/12/2021.
//

import Foundation

func getData(city:String, unit:String, apiKey:String) -> URL{
	let queryItems = [URLQueryItem(name: "q", value: city), URLQueryItem(name: "units", value: unit), URLQueryItem(name: "appid", value: apiKey)]
	var urlComps = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
	urlComps?.queryItems = queryItems
	let result = urlComps!.url!
	return result
}

func fetchData(url:URL, completion: @escaping ([String:Any]?, Error?) -> Void) {
	let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
		guard let data = data else { return }
		do {
			if let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
				completion(array, nil)
			}
		} catch {
			print(error)
			completion(nil, error)
		}
	}
	task.resume()
}
