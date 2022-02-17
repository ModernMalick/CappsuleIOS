//
//  Subscribe.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 17/02/2022.
//

import SwiftUI
import Purchases

struct Subscribe: View {
		@AppStorage("subbed") private var subbed = false
		
		var body: some View {
			VStack{
				logoView()
				Spacer()
				Image("subscribe")
				Spacer()
				Text("Time flies when dressing easy. Your subscription has unfortunately ran out.")
					.font(.title)
					.multilineTextAlignment(.center)
					.padding(.all)
				Spacer()
				Button("Renew"){
					var skProduct:SKProduct?
					Purchases.shared.products(["cappsule_monthly"]) { products in
						if !products.isEmpty {
							skProduct = products[0]
							Purchases.shared.purchaseProduct(skProduct!) { (transaction, purchaseinfo, error, userCancelled) in
								if error == nil && !userCancelled {
									subbed = true
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

struct Subscribe_Previews: PreviewProvider {
    static var previews: some View {
        Subscribe()
    }
}
