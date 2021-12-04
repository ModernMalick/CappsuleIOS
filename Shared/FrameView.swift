//
//  ContentView.swift
//  Shared
//
//  Created by Malick NDIAYE on 02/11/2021.
//

import SwiftUI

struct FrameView: View {
	var body: some View {
		VStack{
			HStack(spacing: 5.0) {
				Image("logo")
					.resizable()
					.frame(width: 50.0, height: 50.0)
				VStack(alignment: .leading) {
					Text("Cappsule")
						.font(.headline)
					Text("Dressing made easy")
						.font(.subheadline)
						.foregroundColor(Color.gray)
				}
				Spacer()
				Menu{
					Button("Rate Cappsule", action: rateApp)
					Link("More from the author", destination: URL(string: "https://mn10games.github.io")!)
				} label: {
					Label("YES", systemImage: "ellipsis")
						.labelStyle(.iconOnly)
						.foregroundColor(Color("ColorOnBackground"))
						.rotationEffect(.degrees(90))
						.imageScale(Image.Scale.large)
						.scaleEffect(1.25)
						.padding([.top, .leading, .bottom], 30)
				}
			}
			.padding(10.0)
			TabView {
				HomeView()
					.tabItem {
						Image("home").renderingMode(.template)
						Text("Home")
					}
					.tag(0)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				WardrobeView()
					.tabItem {
						Image("wardrobe").renderingMode(.template)
						Text("Wardrobe")
					}
					.tag(1)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				OutfitsView()
					.tabItem {
						Image("clothes").renderingMode(.template)
						Text("Outfits")
					}
					.tag(2)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				SettingsView()
					.tabItem {
						Image("settings").renderingMode(.template)
						Text("Settings")
					}
					.tag(3)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
			.background(Color("AccentColor"))
			.accentColor(.white)
			.onAppear {
				UITabBar.appearance().isTranslucent = false
			}
			.ignoresSafeArea()
		}
	}
	
	func rateApp(){
		print("TOUCHER")
	}

	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
			Group {
				FrameView()
					.previewInterfaceOrientation(.portrait)
			}
		}
	}
}


