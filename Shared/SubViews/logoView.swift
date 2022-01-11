//
//  logoView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 11/01/2022.
//

import SwiftUI

struct logoView: View {
    var body: some View {
		HStack(spacing: 5.0) {
			Image("logo")
				.resizable()
				.frame(width: 50.0, height: 50.0)
			VStack(alignment: .leading) {
				Text("Cappsule")
					.font(.headline)
				Text("Dressing made easy")
					.font(.subheadline)
					.foregroundColor(Color.gray)
			}
			Spacer()
		}
		.padding(10.0)
	}
}

struct logoView_Previews: PreviewProvider {
    static var previews: some View {
        logoView()
    }
}
