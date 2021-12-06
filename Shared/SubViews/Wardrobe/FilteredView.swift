//
//  FilteredView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 05/12/2021.
//

import SwiftUI

struct FilteredView: View {
	
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest var fetchRequest: FetchedResults<Article>
	@State var selectedArticle: Article?
	var filtered: Bool
	
	init(filterType: String, filterWarmth: String, filterAvailability: Bool?){
		if(filterType == "" && filterWarmth == "" && filterAvailability == nil){
			_fetchRequest = FetchRequest<Article>(sortDescriptors: [])
			filtered = false
		} else {
			filtered = true
			var predicates = [NSPredicate]()
			if(filterType != ""){
				predicates.append(NSPredicate(format: "type == %@", filterType))
			}
			if(filterWarmth != ""){
				predicates.append(NSPredicate(format: "warmth == %@", filterWarmth))
			}
			if(filterAvailability != nil){
				predicates.append(NSPredicate(format: "available == %@", NSNumber(value: filterAvailability.unsafelyUnwrapped)))
			}
			let searchPredicate:NSPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
			_fetchRequest = FetchRequest<Article>(sortDescriptors: [], predicate: searchPredicate)
		}
	}
	
    var body: some View {
		if(fetchRequest.count > 0){
			List {
				ForEach(fetchRequest) { article in
					HStack(alignment: .top){
						Image(uiImage: UIImage(data: article.image!)!)
							.resizable()
							.frame(width: 100.0, height: 100.0)
							.border(Color("AccentLight"))
						VStack(alignment: .leading){
							Text(article.type!)
							Spacer()
							Text(article.warmth!)
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
							.background(Color("AccentColor"))
							.cornerRadius(7.5)
							.onTapGesture {
								self.selectedArticle = article
							}
					}
					.padding(15.0)
				}.onDelete(perform: deleteArticle)
			}
			.cornerRadius(15)
			.sheet(item: self.$selectedArticle) {
				ArticleView(article: $0)
			}
		} else {
			Spacer()
			Image("box")
				.renderingMode(.template)
				.resizable()
				.foregroundColor(Color("ColorOnBackground"))
				.frame(width: 250.0, height: 250.0)
			Text("Wow, such empty")
				.font(.largeTitle)
			if(filtered){
				Text("Try different filters !")
					.font(.title3)
				.foregroundColor(Color.gray)
			} else {
				Text("Add articles with your camera !")
					.font(.title3)
				.foregroundColor(Color.gray)
			}
		}
	}
	func deleteArticle(at offsets: IndexSet){
		for offset in offsets {
			let article = fetchRequest[offset]
			viewContext.delete(article)
		}
		saveVC()
	}
	
	func saveVC(){
		do {
			try viewContext.save()
		} catch {
			let error = error as NSError
			fatalError("Unresolved Error: \(error)")
		}
	}
}
