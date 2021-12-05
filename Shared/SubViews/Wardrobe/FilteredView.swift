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
	
	init(filter: String){
		if(filter == ""){
			_fetchRequest = FetchRequest<Article>(sortDescriptors: [])
		} else {
			_fetchRequest = FetchRequest<Article>(sortDescriptors: [], predicate: NSPredicate(format: "type = %@", filter))
		}
	}
	
    var body: some View {
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
