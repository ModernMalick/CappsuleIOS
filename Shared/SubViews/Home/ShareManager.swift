//
//  ShareManager.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 05/01/2022.
//

import SwiftUI

extension View {
	func snapshot() -> UIImage {
		let controller = UIHostingController(rootView: self)
		let view = controller.view
		let targetSize = controller.view.intrinsicContentSize
		view?.bounds = CGRect(origin: .zero, size: targetSize)
		view?.backgroundColor = .clear
		let renderer = UIGraphicsImageRenderer(size: targetSize)
		return renderer.image { _ in
			view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
		}
	}
}

struct ShareSheet : UIViewControllerRepresentable {
	var items : [Any]
	
	func makeUIViewController(context: Context) -> some UIViewController {
		let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
		return controller
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		
	}
}
