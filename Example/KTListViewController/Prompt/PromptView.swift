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
	
	public lazy var label : UILabel = {
		let _label = UILabel.init()
		_label.font = UIFont.systemFont(ofSize: 20)
		_label.backgroundColor = UIColor.blue
		_label.textAlignment = .center
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
		
		self.backgroundColor = .red
		
		self.addSubview(self.label)
		self.label.text = "loading"
		self.label.mas_updateConstraints { make in
			make?.top.mas_equalTo()(100)
			make?.height.mas_equalTo()(40)
			make?.centerX.mas_equalTo()(0)
		}
		
		self.addSubview(self.button)
		self.button.mas_updateConstraints { make in
			make?.top.mas_equalTo()(200);
			make?.bottom.mas_equalTo()(-200);
			make?.leading.mas_equalTo()(40);
			make?.trailing.mas_equalTo()(-40);
		}
	}

	@objc func buttonClick() {
		guard (self.promptRefreshBlock != nil) else {
			print("not set refresh block")
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
		self.mas_updateConstraints { make in
			make?.center.mas_equalTo()(0)
			make?.size.mas_equalTo()(CGSize.init(width:300, height:600))
		}
	}
	
	public func promptDismiss() {
		self.removeFromSuperview()
	}
}
