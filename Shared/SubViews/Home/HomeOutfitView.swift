//
//  HomeOutfitView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 06/12/2021.
//

import SwiftUI

struct HomeOutfitView: View, Equatable {
	
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.instance == rhs.instance
	}
	
	let instance: Int
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest var fetchRequestLayer: FetchedResults<Article>
	@FetchRequest var fetchRequestTop: FetchedResults<Article>
	@FetchRequest var fetchRequestBottom: FetchedResults<Article>
	@FetchRequest var fetchRequestShoes: FetchedResults<Article>
	
	init(selectedWarmth: String, instanceID: Int){
		_fetchRequestLayer = FetchRequest<Article>(sortDescriptors: [], predicate: NSPredicate(format: "type == %@ AND available == true AND (warmth == %@ OR warmth == %@)", "Layer", "Both", selectedWarmth))
		_fetchRequestTop = FetchRequest<Article>(sortDescriptors: [], predicate: NSPredicate(format: "type == %@  AND available == true AND (warmth == %@ OR warmth == %@)", "Top", "Both", selectedWarmth))
		_fetchRequestBottom = FetchRequest<Article>(sortDescriptors: [], predicate: NSPredicate(format: "type == %@ AND available == true AND (warmth == %@ OR warmth == %@)", "Bottom", "Both", selectedWarmth))
		_fetchRequestShoes = FetchRequest<Article>(sortDescriptors: [], predicate: NSPredicate(format: "type == %@ AND available == true AND (warmth == %@ OR warmth == %@)", "Shoes", "Both", selectedWarmth))
		instance = instanceID
	}
	
    var body: some View {
		VStack {
			HStack{
				if(fetchRequestLayer.count > 0){
					Image(uiImage: UIImage(data: fetchRequestLayer.randomElement()!.image!)!)
						.resizable()
						.frame(width: 150.0, height: 150.0)
					.border(Color("AccentLight"))
				} else {
					Image("logo")
						.resizable()
						.frame(width: 150.0, height: 150.0)
					.border(Color("AccentLight"))
				}
				Spacer()
					.frame(width: 30.0)
				if(fetchRequestTop.count > 0){
					Image(uiImage: UIImage(data: fetchRequestTop.randomElement()!.image!)!)
						.resizable()
						.frame(width: 150.0, height: 150.0)
						.border(Color("AccentLight"))
				} else {
					Image("logo")
						.resizable()
						.frame(width: 150.0, height: 150.0)
						.border(Color("AccentLight"))
				}
			}
			Spacer()
				.frame(height: 30.0)
			HStack{
				if(fetchRequestBottom.count > 0){
					Image(uiImage: UIImage(data: fetchRequestBottom.randomElement()!.image!)!)
						.resizable()
						.frame(width: 150.0, height: 150.0)
						.border(Color("AccentLight"))
				} else {
					Image("logo")
						.resizable()
						.frame(width: 150.0, height: 150.0)
						.border(Color("AccentLight"))
				}
				Spacer()
					.frame(width: 30.0)
				if(fetchRequestShoes.count > 0){
					Image(uiImage: UIImage(data: fetchRequestShoes.randomElement()!.image!)!)
						.resizable()
						.frame(width: 150.0, height: 150.0)
						.border(Color("AccentLight"))
				} else {
					Image("logo")
						.resizable()
						.frame(width: 150.0, height: 150.0)
						.border(Color("AccentLight"))
				}
			}
		}
		.padding(20.0)
		.background(Color("ColorSurface"))
		.cornerRadius(15)
    }
}
