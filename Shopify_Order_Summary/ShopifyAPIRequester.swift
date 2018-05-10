//
//  ShopifyAPIRequester.swift
//  Shopify_Order_Summary
//
//  Created by Yucheng Yan on 2018-05-08.
//  Copyright © 2018 Yucheng Yan. All rights reserved.
//

import Foundation
import Alamofire

class ShopifyAPIRequester {
	private struct Constants {
		static let ordersApiURL = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
	}
	
	func requestOrders(completion: (([Order])->())?) {
		Alamofire.request(Constants.ordersApiURL)
			.responseJSON(completionHandler: { [weak self] response in
				guard let this = self else { return }
				switch response.result {
				case .success(let content):
					guard let json = content as? Dictionary<String, AnyObject>, let ordersDict = json.first?.value as? [Dictionary<String, AnyObject>] else { return }
					let orders = this.parseOrdersJSON(ordersDict: ordersDict)
					completion?(orders)
				case .failure(let error):
					print("Request Error: \(error)")
				}
			})
	}
	
	private func parseOrdersJSON(ordersDict: [Dictionary<String, AnyObject>]) -> [Order] {
		var orders: [Order] = []
		for order in ordersDict {
			orders.append(Order(dict: order))
		}
		return orders
	}
}
