//
//  WardrobeView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 03/11/2021.
//

import SwiftUI

struct WardrobeView: View {
	
	@Environment(\.managedObjectContext) private var viewContext
	
	@State private var filteredType = ""
	@State private var filteredWarmth = ""
	@State private var filteredAvailability: Bool? = nil
	
	@State private var selectedType = Types.AnyType
	@State private var selectedWarmth = Warmths.AnyWarmth
	@State private var selectedAvailability = Availabilities.AnyAvailability
	
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
				Spacer()
				HStack{
					Picker("Availability", selection: $selectedAvailability){
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
			FilteredView(filterType: filteredType, filterWarmth: filteredWarmth, filterAvailability: filteredAvailability)
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
		.onChange(of: selectedType){ value in
			if(value == Types.Layer){
				filteredType = "Layer"
			} else if(value == Types.Top){
				filteredType = "Top"
			} else if(value == Types.Bottom){
				filteredType = "Bottom"
			} else if(value == Types.Shoes){
				filteredType = "shoes"
			} else {
				filteredType = ""
			}
		}
		.onChange(of: selectedWarmth){ value in
			if(value == Warmths.Light){
				filteredWarmth = "Light"
			} else if(value == Warmths.Both){
				filteredWarmth = "Both"
			} else if(value == Warmths.Heavy){
				filteredWarmth = "Heavy"
			} else {
				filteredWarmth = ""
			}
		}
		.onChange(of: selectedAvailability){ value in
			if(value == Availabilities.Available){
				filteredAvailability = true
			} else if(value == Availabilities.Unavailable){
				filteredAvailability = false
			} else {
				filteredAvailability = nil
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
