//
//  SaveOutfitView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 09/01/2022.
//

import SwiftUI

struct SaveOutfitView: View {
	
	@Environment(\.presentationMode) private var presentationMode
	
	@State private var name: String = ""
	var image: UIImage
	
	init(_ image: UIImage) {
		self.image = image
	}
	
    var body: some View {
		Spacer()
		VStack {
			Spacer()
			Text("Save this outfit")
				.font(.title)
			Spacer()
			Image(uiImage: image)
			Spacer()
			HStack {
				Text("Name")
					.padding(.trailing, 25.0)
				TextField("Name your outfit", text: $name)
				.frame(width: 150.0)
			}
			.padding(20.0)
			.background(Color("ColorSurface"))
			.cornerRadius(15)
			Spacer()
			HStack{
				Spacer()
				Button(action: {
					presentationMode.wrappedValue.dismiss()
				}){
					Text("Cancel")
						.foregroundColor(Color.white)
						.fontWeight(.bold)
				}
				.frame(width: 100.0, height: 40.0)
				.background(Color("AccentDark"))
				.cornerRadius(10)
				Spacer()
				Button(action: {
					print("save")
				}){
					Text("Save")
						.foregroundColor(Color.white)
						.fontWeight(.bold)
				}
				.frame(width: 100.0, height: 40.0)
				.background(Color("AccentMid"))
				.cornerRadius(10)
				Spacer()
			}
			Spacer()
		}
		Spacer()
    }
}

struct SaveOutfitView_Previews: PreviewProvider {
    static var previews: some View {
		SaveOutfitView(UIImage.init(named: "logo")!)
    }
}
