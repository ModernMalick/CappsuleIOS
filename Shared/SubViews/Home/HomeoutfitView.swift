//
//  HomeOutfitView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 06/12/2021.
//

import SwiftUI

struct HomeOutfitView: View {
    var body: some View {
		VStack {
			HStack{
				Image("logo")
					.resizable()
					.frame(width: 150.0, height: 150.0)
					.border(Color("AccentLight"))
				Spacer()
					.frame(width: 30.0)
				Image("logo")
					.resizable()
					.frame(width: 150.0, height: 150.0)
					.border(Color("AccentLight"))
			}
			Spacer()
				.frame(height: 30.0)
			HStack{
				Image("logo")
					.resizable()
					.frame(width: 150.0, height: 150.0)
					.border(Color("AccentLight"))
				Spacer()
					.frame(width: 30.0)
				Image("logo")
					.resizable()
					.frame(width: 150.0, height: 150.0)
					.border(Color("AccentLight"))
			}
		}
		.padding(20.0)
		.background(Color("ColorSurface"))
		.cornerRadius(15)
    }
}

struct HomeOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        HomeOutfitView()
    }
}
