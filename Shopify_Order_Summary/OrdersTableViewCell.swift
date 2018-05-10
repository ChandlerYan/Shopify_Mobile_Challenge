//
//  OrdersTableViewCell.swift
//  Shopify_Order_Summary
//
//  Created by Yucheng Yan on 2018-05-09.
//  Copyright © 2018 Yucheng Yan. All rights reserved.
//

import Foundation
import UIKit

class OrdersTableViewCell: UITableViewCell {
	static let reusableIdentifier = "OrdersTableViewCell"
	
	private struct Constants {
		static let orderTitle: String = "- Order "
		static let yearTitle: String = "Created Year: "
		static let provinceTitle: String = "Shipping Province: "
		static let priceTitle: String = "Price: "
		static let financeStatucTitle: String = "Finance Status: "
		
		static let titleLabelFontSize: CGFloat = 18
		static let titleLabelHeight: CGFloat = 20
		static let titleLabelTopPadding: CGFloat = 5
		static let titleLabelLeftPadding: CGFloat = 20
		
		static let featureLabelFontSize: CGFloat = 16
		static let featureLabelHeight: CGFloat = 18
		static let featureLabelLeftPadding: CGFloat = 40
		
		static let yearLabelTopPadding: CGFloat = 30
		static let provinceLabelTopPadding: CGFloat = 53
		static let priceLabelTopPadding: CGFloat = 76
		static let financeStatusLabelTopPadding: CGFloat = 99
	}
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.textColor = .black
		label.autoresizingMask = .flexibleWidth
		label.font = UIFont(name: "Arial-BoldMT", size: Constants.titleLabelFontSize)
		return label
	}()
	
	private lazy var yearLabel: UILabel = {
		return featureLabel()
	}()
	
	private lazy var provinceLabel: UILabel = {
		return featureLabel()
	}()
	
	private lazy var priceLabel: UILabel = {
		return featureLabel()
	}()
	
	private lazy var financialStatusLabel: UILabel = {
		return featureLabel()
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(titleLabel)
		contentView.addSubview(yearLabel)
		contentView.addSubview(provinceLabel)
		contentView.addSubview(priceLabel)
		contentView.addSubview(financialStatusLabel)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		titleLabel.frame = CGRect(x: Constants.titleLabelLeftPadding,
								  y: Constants.titleLabelTopPadding,
								  width: frame.width - Constants.titleLabelLeftPadding,
								  height: Constants.titleLabelHeight)
		
		yearLabel.frame = CGRect(x: Constants.featureLabelLeftPadding,
								 y: Constants.yearLabelTopPadding,
								 width: frame.width - Constants.featureLabelLeftPadding,
								 height: Constants.featureLabelHeight)
		
		provinceLabel.frame = CGRect(x: Constants.featureLabelLeftPadding,
								 y: Constants.provinceLabelTopPadding,
								 width: frame.width - Constants.featureLabelLeftPadding,
								 height: Constants.featureLabelHeight)
		
		priceLabel.frame = CGRect(x: Constants.featureLabelLeftPadding,
								 y: Constants.priceLabelTopPadding,
								 width: frame.width - Constants.featureLabelLeftPadding,
								 height: Constants.featureLabelHeight)
		
		financialStatusLabel.frame = CGRect(x: Constants.featureLabelLeftPadding,
								 y: Constants.financeStatusLabelTopPadding,
								 width: frame.width - Constants.featureLabelLeftPadding,
								 height: Constants.featureLabelHeight)
	}
	
	func setTexts(order: Order) {
		titleLabel.text = Constants.orderTitle + String(order.id)
		yearLabel.text = Constants.yearTitle + order.created_year
		provinceLabel.text = Constants.provinceTitle + order.ship_province
		priceLabel.text = Constants.priceTitle + order.total_price + " " + order.currency
		financialStatusLabel.text = Constants.financeStatucTitle + order.financial_status
	}
	
	private func featureLabel() -> UILabel {
		let label = UILabel(frame: .zero)
		label.textColor = .black
		label.autoresizingMask = .flexibleWidth
		label.font = UIFont(name: "ArialMT", size: Constants.featureLabelFontSize)
		return label
	}
}
