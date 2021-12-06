//
//  HomeView.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 03/11/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
		HomeOutfitView(selectedWarmth: "Heavy")
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
