//
//  OnboardingTemplate.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 11/01/2022.
//

import SwiftUI

struct OnboardingTemplate: View {
	@State private var image: String
	@State private var text: String
	
	init(image: String, text: String){
		self.image = image
		self.text = text
	}
	
    var body: some View {
		Image(image)
		Spacer()
		Text(text)
			.font(.title)
			.multilineTextAlignment(.center)
			.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct OnboardingTemplate_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTemplate(image: "welcome", text: "Welcome to Cappsule, the e-wardrobe that dresses you !")
    }
}
