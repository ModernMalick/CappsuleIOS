//
//  Explanation.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 11/01/2022.
//

import SwiftUI

struct Explanation: View {
    var body: some View {
		NavigationView{
			VStack{
				logoView()
				Spacer()
				Image("explanation")
				Spacer()
				Text("Just take pictures of your clothes and categorize them to set it up !")
					.font(.title)
					.multilineTextAlignment(.center)
					.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
				Spacer()
				HStack{
					Text("2/4")
					Spacer()
					NavigationLink(destination: Welcome()){
						Text("Next")
					}
					.frame(width: 100.0, height: 45.0)
					.background(Color("AccentColor"))
					.cornerRadius(10)
					.foregroundColor(Color.white)
				}
			}
			.padding(.all)
		}
	}
}

struct Explanation_Previews: PreviewProvider {
    static var previews: some View {
        Explanation()
    }
}
