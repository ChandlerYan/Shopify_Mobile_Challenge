//
//  Order.swift
//  Shopify_Order_Summary
//
//  Created by Yucheng Yan on 2018-05-08.
//  Copyright © 2018 Yucheng Yan. All rights reserved.
//

import Foundation

class Order {
	let id: Int64
	let total_price: String
	let currency: String
	let financial_status: String
	let ship_province: String
	let created_year: String
	
	init(dict: Dictionary<String, AnyObject>) {
		id = (dict["id"] as? Int64) ?? 0
		
		total_price = (dict["total_price"] as? String) ?? ""
		
		currency = (dict["currency"] as? String) ?? ""
		
		financial_status = (dict["financial_status"] as? String) ?? ""
		
		if let shippingAddress = dict["shipping_address"] as? Dictionary<String, AnyObject>,
			let parsedProvince = shippingAddress["province"] as? String {
			ship_province = parsedProvince
		} else {
			ship_province = "Unknown"
		}
		
		if let parsedCreatedTime = dict["created_at"] as? String {
			created_year = String(parsedCreatedTime.prefix(4))
		} else {
			created_year = ""
		}
	}
}
