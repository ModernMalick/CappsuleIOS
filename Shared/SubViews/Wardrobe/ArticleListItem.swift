//
//  ArticleListItem.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 01/12/2021.
//

import SwiftUI

struct ArticleListItem: View {
	
	@Environment(\.managedObjectContext) private var viewContext
	@Environment(\.presentationMode) var presentationMode
	@State var presentingModal = false
	
    var body: some View {
		let image = UIImage(data: article.image.unsafelyUnwrapped).unsafelyUnwrapped
		HStack(alignment: .top){
			Image(uiImage: image)
				.resizable()
				.frame(width: 100.0, height: 100.0)
				.border(Color("AccentLight"))
			VStack(alignment: .leading){
				Text(article.type.unsafelyUnwrapped)
				Spacer()
				Text(article.warmth.unsafelyUnwrapped)
				HStack{
					Text("Available")
					Toggle("Available", isOn: Binding<Bool>(
						get: {article.available},
						set: {
							article.available = $0
							try? viewContext.save()
						}))
						.tint(Color("AccentLight"))
						.labelsHidden()
				}
			}
			.padding(.leading, 10.0)
			Spacer()
			Image("editing")
				.renderingMode(.template)
				.resizable()
				.foregroundColor(Color.white)
				.padding(10.0)
				.frame(width: 48.0, height: 48.0)
				.background(Color("AccentMid"))
				.cornerRadius(7.5)
				.onTapGesture {
					self.presentingModal = true
				}
				.sheet(isPresented: $presentingModal) {
					ArticleView(presentedAsModal: self.$presentingModal, article: article)
				}
		}
		.padding(15.0)
	}
}

