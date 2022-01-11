//
//  SettingsView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 03/11/2021.
//

import SwiftUI

struct SettingsView: View {
	
	@AppStorage("metric") private var metric = true
	@AppStorage("minLight") private var minLight = 20
	@State private var unit = "C"
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack(alignment: .top) {
				Text("Use the metric system")
					.font(.headline)
				Toggle("", isOn: $metric)
					.tint(Color("AccentLight"))
			}
			Text("Use the metric system to display the current weather's temperature")
				.font(.subheadline)
				.foregroundColor(Color.gray)
			Spacer()
			HStack(alignment: .top) {
				Text("Minimum light warmth temperature")
					.font(.headline)
				Spacer()
				TextField("", text: Binding(get: {String(minLight)}, set: {minLight = Int($0) ?? 0}))
					.frame(width: 50.0)
					.multilineTextAlignment(.center)
					.background(Color("ColorSurface"))
					.keyboardType(.numberPad)
				Text("°" + unit)
			}
			Text("Set the minimum temperature for light warmth clothes using your chosen unit system")
				.font(.subheadline)
				.foregroundColor(Color.gray)
			Spacer()
			Link("- Rate Cappsule", destination: URL(string: "https://mn10games.github.io")!)
				.font(.headline)
				.accentColor(Color("ColorOnBackground"))
			Text("Help Cappsule by sharing your experience")
				.font(.subheadline)
				.foregroundColor(Color.gray)
			Group{
				Spacer()
				Link("- More from the author", destination: URL(string: "https://malick-ndiaye.github.io")!)
					.font(.headline)
					.accentColor(Color("ColorOnBackground"))
				Text("Visit my website for more of my creations")
					.font(.subheadline)
					.foregroundColor(Color.gray)
				Spacer()
				Link("- Illustrations by storyset", destination: URL(string: "https://storyset.com")!)
					.font(.headline)
					.accentColor(Color("ColorOnBackground"))
				Text("Visit storyset to see more illustrations like the ones used Cappsule")
					.font(.subheadline)
					.foregroundColor(Color.gray)
				Spacer()
				Link("- Icons by flaticon", destination: URL(string: "https://flaticon.com")!)
					.font(.headline)
					.accentColor(Color("ColorOnBackground"))
				Text("All the icons used on Cappsule from this website")
					.font(.subheadline)
					.foregroundColor(Color.gray)
			}
			
		}
		.padding(.all)
		.onChange(of: metric) { newValue in
			if(newValue){
				unit = "C"
			} else {
				unit = "F"
			}
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
