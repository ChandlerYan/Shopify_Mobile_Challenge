//
//  ViewController.swift
//  Shopify_Order_Summary
//
//  Created by Yucheng Yan on 2018-05-08.
//  Copyright © 2018 Yucheng Yan. All rights reserved.
//

import UIKit

class ShopifyOrderSummaryViewController: UITabBarController {
	private struct Constants {
		static let ordersByProvinceTitle = "Orders By Province"
		static let ordersByYearTitle = "Orders By Year"
	}
	
	let requester = ShopifyAPIRequester()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		let ordersByProvinceVC = OrdersByProvinceViewController()
		ordersByProvinceVC.tabBarItem = UITabBarItem(title: Constants.ordersByProvinceTitle, image: UIImage(named: "map-pin"), tag: 0)
		
		let ordersByYearVC = OrdersByYearViewController()
		ordersByYearVC.tabBarItem = UITabBarItem(title: Constants.ordersByYearTitle, image: UIImage(named: "calendar"), tag: 1)
		
		let controllers = [ordersByProvinceVC, ordersByYearVC]
		
		viewControllers = controllers.map { UINavigationController(rootViewController: $0) }

		requester.requestOrders(completion: { [weak self] orders in
			guard let this = self else { return }
			ordersByProvinceVC.data = this.getOrdersByProvinceData(orders: orders)
			ordersByYearVC.data = this.getOrdersByYearData(orders: orders)
		})
	}
	
	private func getOrdersByProvinceData(orders: [Order]) -> [(key: String, value: [Order])] {
		var dict = Dictionary<String, [Order]>()
		for order in orders {
			guard let orderArray = dict[order.ship_province] else {
				dict[order.ship_province] = [order]
				continue
			}
			var newArray = orderArray
			newArray.append(order)
			dict[order.ship_province] = newArray
		}
		return dict.sorted(by: { $0.0 < $1.0 })
	}
	
	private func getOrdersByYearData(orders: [Order]) -> [(key: String, value: [Order])] {
		var dict = Dictionary<String, [Order]>()
		for order in orders {
			guard let orderArray = dict[order.created_year] else {
				dict[order.created_year] = [order]
				continue
			}
			var newArray = orderArray
			newArray.append(order)
			dict[order.created_year] = newArray
		}
		return dict.sorted(by: { $0.0 < $1.0 })
	}
}

