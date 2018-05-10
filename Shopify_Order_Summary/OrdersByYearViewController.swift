//
//  OrdersByYearViewController.swift
//  Shopify_Order_Summary
//
//  Created by Yucheng Yan on 2018-05-09.
//  Copyright © 2018 Yucheng Yan. All rights reserved.
//

import Foundation
import UIKit

class OrdersByYearViewController: UITableViewController {
	private struct Constants {
		static let ordersByYearTitle = "Orders By Year"
		static let ordersByYearStatement = " number of orders created in "
		static let headerViewHeight: CGFloat = 40
		static let cellHeight: CGFloat = 122
	}
	
	var data: [(key: String, value: [Order])]? {
		didSet {
			tableView.reloadData()
		}
	}
	
	private var isExpandedDict: Dictionary<String, Bool> = Dictionary<String, Bool>()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		edgesForExtendedLayout = .all
		extendedLayoutIncludesOpaqueBars = false
		
		setupNavigationBarTitle()
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(OrdersTableViewCell.self, forCellReuseIdentifier: OrdersTableViewCell.reusableIdentifier)
		tableView.register(OrdersTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: OrdersTableViewHeaderView.reusableIdentifier)
	}
	
	private func isExpanded(section: Int) -> Bool {
		guard let unwrappedData = data else { return false }
		guard let isExpanded = isExpandedDict[unwrappedData[section].key] else {
			isExpandedDict[unwrappedData[section].key] = false
			return false
		}
		return isExpanded
	}
	
	
	private func setupNavigationBarTitle() {
		let button =  UIButton(type: .custom)
		button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
		button.setTitle(Constants.ordersByYearTitle, for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.addTarget(self, action: #selector(tapNavigationBar), for: .touchUpInside)
		navigationItem.titleView = button
	}
	
	@objc private func tapNavigationBar() {
		guard let unwrappedData = data else { return }
		if isExpandedDict.contains(where: { !$0.value }) {
			isExpandedDict.forEach({ isExpandedDict[$0.key] = true })
		} else {
			isExpandedDict.forEach({ isExpandedDict[$0.key] = false })
		}
		
		let indexSet = IndexSet(0..<unwrappedData.count)
		tableView.reloadSections(indexSet, with: .fade)
	}
	
	override public func numberOfSections(in tableView: UITableView) -> Int {
		guard let unwrappedData = data else { return 0 }
		return unwrappedData.count
	}
	
	override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isExpanded(section: section) {
			guard let unwrappedData = data else { return 0 }
			return min(unwrappedData[section].value.count, 10)
		} else {
			return 0
		}
	}
	
	override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let unwrappedData = data else { return UITableViewCell() }
		if isExpanded(section: indexPath.section) {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTableViewCell.reusableIdentifier) as? OrdersTableViewCell else {
				return UITableViewCell()
			}
			
			cell.setTexts(order: unwrappedData[indexPath.section].value[indexPath.row])
			return cell
		} else {
			return UITableViewCell()
		}
	}
	
	override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return cellText(section: section)
	}
	
	override public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return Constants.headerViewHeight
	}
	
	override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return Constants.cellHeight
	}
	
	override public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: OrdersTableViewHeaderView.reusableIdentifier) as? OrdersTableViewHeaderView {
			headerView.section = section
			headerView.delegate = self
			return headerView
		} else {
			return UITableViewHeaderFooterView()
		}
	}
	
	private func cellText(section: Int) -> String? {
		guard let unwrappedData = data else { return nil }
		if isExpanded(section: section) {
			return unwrappedData[section].key
		} else {
			return String(unwrappedData[section].value.count)
				+ Constants.ordersByYearStatement
				+ unwrappedData[section].key
		}
	}
}

extension OrdersByYearViewController: OrdersByProvinceTableViewHeaderViewDelegate {
	func tapHeaderView(section: Int) {
		guard let unwrappedData = data else { return }
		isExpandedDict[unwrappedData[section].key] = !isExpanded(section: section)
		tableView.reloadSections(IndexSet(integer: section), with: .fade)
	}
}

