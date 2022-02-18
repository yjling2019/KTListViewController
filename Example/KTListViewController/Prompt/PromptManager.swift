//
//  PromptManager.swift
//  KTListViewController_Example
//
//  Created by KOTU on 2022/2/16.
//  Copyright © 2022 KOTU. All rights reserved.
//

import Foundation

@objcMembers public class PromptManager : NSObject, KTPromptViewDataSource {
	
	public func kt_promptLoadingView() -> UIView & KTPromptViewProtocol {
		let view = PromptView.init()
		view.label.text = "loading..."
		return view
	}
	
	public func kt_promptEmptyDataView() -> UIView & KTPromptViewProtocol {
		let view = PromptView.init()
		view.label.text = "empty data"
		return view
	}
	
	public func kt_promptExceptionView() -> UIView & KTPromptViewProtocol {
		let view = PromptView.init()
		view.label.text = "errer!!!"
		return view
	}
}
