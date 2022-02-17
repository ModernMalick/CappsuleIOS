//
//  Welcome.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 11/01/2022.
//

import SwiftUI

struct Welcome: View {
	@State private var image = "welcome"
	@State private var text = "Welcome to Cappsule, the e-wardrobe that dresses you !"
	@State private var page = 1
	@AppStorage("boarded") private var boarded = false
	
    var body: some View {
		VStack{
			logoView()
			Spacer()
			Image(image)
			Spacer()
			Text(text)
				.font(.title)
				.multilineTextAlignment(.center)
				.padding(.all)
			Spacer()
			HStack{
				if(page > 1){
					Button("Back"){
						page -= 1
						switch page {
							case 2:
								image = "explanation"
								text = "Just take pictures of your clothes and categorize them to set it up !"
							case 3:
								image = "start"
								text = "Cappsule will then suggest outfits based on your needs !"
							default:
							image = "welcome"
							text = "Welcome to Cappsule, the e-wardrobe that dresses you !"
						}
					}
					.frame(width: 100.0, height: 45.0)
					.background(Color("AccentDark"))
					.cornerRadius(10)
					.foregroundColor(Color.white)
				} else {
					Spacer()
						.frame(width: 100.0)
				}
				Spacer()
				Text("\(page)/3")
				Spacer()
				if(page < 3){
					Button("Next"){
						page += 1
						switch page {
							case 2:
								image = "explanation"
								text = "Just take pictures of your clothes and categorize them to set it up !"
							case 3:
								image = "start"
								text = "Cappsule will then suggest outfits based on your needs !"
							default:
								image = "welcome"
								text = "Welcome to Cappsule, the e-wardrobe that dresses you !"
						}
					}
					.frame(width: 100.0, height: 45.0)
					.background(Color("AccentColor"))
					.cornerRadius(10)
					.foregroundColor(Color.white)
				} else {
					Button("Start"){
						boarded = true
					}
					.frame(width: 100.0, height: 45.0)
					.background(Color("AccentLight"))
					.cornerRadius(10)
					.foregroundColor(Color.black)
				}
			}
		}
		.padding(.all)
		.navigationTitle("")
		.navigationBarHidden(true)
	}
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
