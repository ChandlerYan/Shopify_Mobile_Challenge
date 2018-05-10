//
//  OrdersByProvinceTableViewHeaderView.swift
//  Shopify_Order_Summary
//
//  Created by Yucheng Yan on 2018-05-09.
//  Copyright © 2018 Yucheng Yan. All rights reserved.
//

import Foundation
import UIKit

protocol OrdersByProvinceTableViewHeaderViewDelegate {
	func tapHeaderView(section: Int)
}

class OrdersTableViewHeaderView: UITableViewHeaderFooterView {
	static let reusableIdentifier: String = "OrdersTableViewHeaderView"
	
	var delegate: OrdersByProvinceTableViewHeaderViewDelegate?
	
	var section: Int?
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
		addGestureRecognizer(tapGesture)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func tapped() {
		guard let section = section else { return }
		delegate?.tapHeaderView(section: section)
	}
}
