//
//  Coordinator.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 07/11/2021.
//

import Foundation
import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	@Binding var isCoordinatorShown: Bool
	@Binding var imageInCoordinator: UIImage
	@Binding var newImageInCoordinator: Bool
	init(isShown: Binding<Bool>, image: Binding<UIImage>, newImage: Binding<Bool>) {
		_isCoordinatorShown = isShown
		_imageInCoordinator = image
		_newImageInCoordinator = newImage
	}
	func imagePickerController(_ picker: UIImagePickerController,
							   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
		imageInCoordinator = unwrapImage
		isCoordinatorShown = false
		newImageInCoordinator = true
	}
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		isCoordinatorShown = false
	}
}
