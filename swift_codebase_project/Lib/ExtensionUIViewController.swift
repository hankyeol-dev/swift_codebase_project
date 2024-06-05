//
//  ExtensionUIViewController.swift
//  swift_codebase_project
//
//  Created by 강한결 on 6/5/24.
//

import Foundation
import UIKit

enum BackgroundType {
    case defaults
    case dark
    case differ
}

extension UIViewController {
    func _setBackgroundColor(type: BackgroundType) {
        switch type {
        case .defaults:
            view.backgroundColor = .white
        case .dark:
            view.backgroundColor = .darkGray
        case .differ:
            view.backgroundColor = .systemRed
        }
    }
}
