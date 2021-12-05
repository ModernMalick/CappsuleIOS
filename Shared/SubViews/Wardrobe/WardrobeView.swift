//
//  WardrobeView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 03/11/2021.
//

import SwiftUI

struct WardrobeView: View {
	
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest(sortDescriptors: [])
	private var articles: FetchedResults<Article>
	
	@State private var filteredType = ""
	
	@State private var selectedType = Types.AnyType
	@State var image: UIImage = UIImage(named: "logo").unsafelyUnwrapped
	@State var showCaptureImageView: Bool = false
	@State var newImage = false
	
    var body: some View {
		VStack(){
			HStack{
				Spacer()
				HStack{
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
				Spacer()
				HStack{
					Picker("Warmth", selection: $selectedType){
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
				Spacer()
				HStack{
					Picker("Availability", selection: $selectedType){
						Text("All Availabilities")
							.tag(Availabilities.AnyAvailability)
						Text("Available")
							.tag(Availabilities.Available)
						Text("Unavailable")
							.tag(Availabilities.Unavailable)
					}
					.accentColor(Color("ColorOnBackground"))
					Image(systemName: "arrowtriangle.down.fill")
						.scaleEffect(0.65)
						.foregroundColor(Color("AccentLight"))
				}
				Spacer()
			}
			Spacer()
			if(articles.count > 0){
				FilteredView(filter: filteredType)
			} else {
				Spacer()
				Image("box")
					.renderingMode(.template)
					.resizable()
					.foregroundColor(Color("ColorOnBackground"))
					.frame(width: 250.0, height: 250.0)
				Text("Wow, such empty")
					.font(.largeTitle)
				Text("Add outfits from the home screen !")
					.font(.title3)
					.foregroundColor(Color.gray)
			}
			Spacer()
			Spacer()
			HStack(){
				Spacer()
				Button(action: {
					self.showCaptureImageView.toggle()
				}){
					Image(systemName: "camera")
						.scaleEffect(1.65)
						.tint(Color.black)
				}
				.frame(width: 65, height: 65)
				.background(Color("AccentLight"))
				.cornerRadius(50)
			}
			.frame(maxWidth: .infinity)
			.fullScreenCover(isPresented: $showCaptureImageView) {
				CaptureImageView(isShown: $showCaptureImageView, image: $image, newImage: $newImage)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding(20)
		.onChange(of: newImage){ value in
			if(value == true){
				addArticle(picture: image)
				saveVC()
				newImage = false
			}
		}
	}
	func addArticle(picture: UIImage){
		let newArticle = Article(context: viewContext)
		newArticle.type = "Type not set"
		newArticle.warmth = "Warmth not set"
		newArticle.available = true
		newArticle.image = picture.jpegData(compressionQuality: 1.0)
	}
	
	func deleteArticle(at offsets: IndexSet){
		for offset in offsets {
			let article = articles[offset]
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

struct CaptureImageView {
	@Binding var isShown: Bool
	@Binding var image: UIImage
	@Binding var newImage: Bool
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(isShown: $isShown, image: $image, newImage: $newImage)
	}
}
extension CaptureImageView: UIViewControllerRepresentable {
	func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
		let picker = UIImagePickerController()
		picker.delegate = context.coordinator
		picker.sourceType = .camera
		return picker
	}
	
	func updateUIViewController(_ uiViewController: UIImagePickerController,
								context: UIViewControllerRepresentableContext<CaptureImageView>) {}
}

struct WardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeView()
    }
}
