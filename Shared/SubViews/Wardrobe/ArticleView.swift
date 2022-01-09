//
//  ArticleView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 02/12/2021.
//

import SwiftUI

struct ArticleView: View {
	
	@Environment(\.managedObjectContext) private var viewContext
	@Environment(\.presentationMode) private var presentationMode
	@State var selectedType = Types.AnyType
	@State var selectedWarmth = Warmths.AnyWarmth
	var article: Article
	
    var body: some View {
		VStack{
			Spacer()
			Text("Modify your article")
				.font(.title)
			Spacer()
			Image(uiImage: UIImage(data: article.image!)!)
				.resizable()
				.frame(width: 300.0, height: 300.0)
			Spacer()
			VStack(){
				HStack{
					Text("Type").foregroundColor(Color("AccentLight"))
					Spacer()
					Picker("Type", selection: $selectedType){
						Text("All types")
							.tag(Types.AnyType)
						Text("Layer")
							.tag(Types.Layer)
						Text("Top")
							.tag(Types.Top)
						Text("Bottom")
							.tag(Types.Bottom)
						Text("Shoes")
							.tag(Types.Shoes)
					}
					.accentColor(Color("ColorOnBackground"))
					Image(systemName: "arrowtriangle.down.fill")
						.scaleEffect(0.65)
						.foregroundColor(Color("AccentLight"))
				}
				.padding()
				.frame(width: 300.0)
				.background(Color("ColorSurface"))
				.cornerRadius(15)
				Spacer()
					.frame(height: 25.0)
				HStack{
					Text("Warmth").foregroundColor(Color("AccentLight"))
					Spacer()
					Picker("Warmth", selection: $selectedWarmth){
						Text("All Warmths")
							.tag(Warmths.AnyWarmth)
						Text("Light")
							.tag(Warmths.Light)
						Text("Both")
							.tag(Warmths.Both)
						Text("Heavy")
							.tag(Warmths.Heavy)
					}
					.accentColor(Color("ColorOnBackground"))
					Image(systemName: "arrowtriangle.down.fill")
						.scaleEffect(0.65)
						.foregroundColor(Color("AccentLight"))
				}
				.padding()
				.frame(width: 300.0)
				.background(Color("ColorSurface"))
				.cornerRadius(15)
			}
			Spacer()
			HStack{
				Button(action: {presentationMode.wrappedValue.dismiss()}){
					Spacer()
					Text("CANCEL")
						.foregroundColor(Color.white)
					Spacer()
				}
				.padding(10.0).frame(width: 110.0)
				.background(Color("AccentDark"))
				.cornerRadius(8)
				Spacer()
				Button(action: {
					updateArticle()
					saveVC()
					presentationMode.wrappedValue.dismiss()
				}){
					Spacer()
					Text("SAVE")
						.foregroundColor(Color.white)
					Spacer()
				}
				.padding(10.0).frame(width: 110.0)
				.background(Color("AccentMid"))
				.cornerRadius(8)
			}
			.frame(width: 300.0)
			Spacer()
		}
		.onAppear {
			getArticleData()
		}
	}
	func saveVC(){
		do {
			try viewContext.save()
		} catch {
			let error = error as NSError
			fatalError("Unresolved Error: \(error)")
		}
	}
	
	func getArticleData(){
		if(article.type == "Type not set"){
			selectedType = Types.AnyType
		}
		else if(article.type == "Layer"){
			selectedType = Types.Layer
		}
		else if(article.type == "Top"){
			selectedType = Types.Top
		}
		else if(article.type == "Bottom"){
			selectedType = Types.Bottom
		}
		else if(article.type == "Shoes"){
			selectedType = Types.Shoes
		}
		
		if(article.warmth == "Warmth not set"){
			selectedWarmth = Warmths.AnyWarmth
		}
		else if(article.warmth == "Light"){
			selectedWarmth = Warmths.Light
		}
		else if(article.warmth == "Both"){
			selectedWarmth = Warmths.Both
		}
		else if(article.warmth == "Heavy"){
			selectedWarmth = Warmths.Heavy
		}
	}
	
	func updateArticle(){
		if(selectedType == Types.AnyType){
			article.type = "Type not set"
		}
		else if(selectedType == Types.Layer){
			article.type = "Layer"
		}
		else if(selectedType == Types.Top){
			article.type = "Top"
		}
		else if(selectedType == Types.Bottom){
			article.type = "Bottom"
		}
		else if(selectedType == Types.Shoes){
			article.type = "Shoes"
		}
		
		if(selectedWarmth == Warmths.AnyWarmth){
			article.warmth = "Warmth not set"
		}
		else if(selectedWarmth == Warmths.Light){
			article.warmth = "Light"
		}
		else if(selectedWarmth == Warmths.Both){
			article.warmth = "Both"
		}
		else if(selectedWarmth == Warmths.Heavy){
			article.warmth = "Heavy"
		}
	}
}

