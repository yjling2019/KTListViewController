//
//  PromptView.swift
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/16.
//  Copyright © 2022 KOTU. All rights reserved.
//

import Foundation
import UIKit

@objcMembers public class PromptView : UIView, KTPromptViewProtocol {
	public var promptRefreshBlock : KTPromptRefreshBlock?
	public weak var showInView : UIView?
	
	lazy var label : UILabel = {
		let _label = UILabel.init()
		_label.font = UIFont.systemFont(ofSize: 12)
		_label.backgroundColor = UIColor.blue
		_label.isUserInteractionEnabled = true
		return _label
	}()
	
	lazy var button : UIButton = {
		let _btn = UIButton.init()
		_btn.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
		_btn.backgroundColor = UIColor.purple
		return _btn
	}()
	
	public init() {
		super.init(frame: CGRect.zero)
		
		self.addSubview(self.label)
		self.label.mas_updateConstraints { make in
			make?.top.mas_equalTo()(100);
			make?.bottom.mas_equalTo()(-100);
			make?.leading.mas_equalTo()(20);
			make?.trailing.mas_equalTo()(-20);
		}
		
		self.label.addSubview(self.button)
		self.button.mas_updateConstraints { make in
			make?.top.mas_equalTo()(100);
			make?.bottom.mas_equalTo()(-100);
			make?.leading.mas_equalTo()(20);
			make?.trailing.mas_equalTo()(-20);
		}
	}

	@objc func buttonClick() {
		guard (self.promptRefreshBlock != nil) else {
			print("SSS")
			return
		}
		self.promptRefreshBlock!()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func showPromptView(in showInView: UIView) {
		self.showInView = showInView
		showInView.addSubview(self)
		let array = self.mas_updateConstraints { make in
			make?.edges.mas_equalTo()(0)
		}
		print(array?.count ?? 0)
	}
	
	public func promptDismiss() {
		self.showInView?.removeFromSuperview()
	}
}
