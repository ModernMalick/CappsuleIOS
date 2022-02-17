//
//  ContentView.swift
//  Shared
//
//  Created by Malick NDIAYE on 02/11/2021.
//

import SwiftUI
import Purchases

struct FrameView: View {
	
	@AppStorage("subbed") private var subbed = false
	
	var body: some View {
		VStack{
			logoView()
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
		}.onAppear(){
			Purchases.shared.purchaserInfo { (info, error) in
				if info?.entitlements["All access"]?.isActive == true {
					subbed = true
					print("True")
				} else {
					subbed = false
					print("False")
				}
			}
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


