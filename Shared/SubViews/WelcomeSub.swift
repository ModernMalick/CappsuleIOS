//
//  WelcomeSub.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 17/02/2022.
//

import SwiftUI
import Purchases

struct WelcomeSub: View {
	
	@AppStorage("subbed") private var subbed = false
	@AppStorage("tried") private var tried = false
	
    var body: some View {
		VStack{
			logoView()
			Spacer()
			Image("gift")
			Spacer()
			Text("As a welcoming gift, please enjoy your first month for free !")
				.font(.title)
				.multilineTextAlignment(.center)
				.padding(.all)
			Spacer()
			Button("Accept gift"){
				var skProduct:SKProduct?
				Purchases.shared.products(["cappsule_monthly"]) { products in
					if !products.isEmpty {
						skProduct = products[0]
						Purchases.shared.purchaseProduct(skProduct!) { (transaction, purchaseinfo, error, userCancelled) in
							if error == nil && !userCancelled {
								subbed = true
								tried = true
							}
						}
					}
				}
			}
			.frame(width: 100.0, height: 45.0)
			.background(Color("AccentLight"))
			.cornerRadius(10)
			.foregroundColor(Color.black)
		}
		.padding(.all)
		.navigationTitle("")
		.navigationBarHidden(true)
	}
}

struct WelcomeSub_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeSub()
    }
}
