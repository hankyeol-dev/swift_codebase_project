//
//  ExtensionVCIdentifier.swift
//  swift_codebase_project
//
//  Created by 강한결 on 6/5/24.
//

import Foundation
import UIKit

protocol SetIdentifier {
    static var id: String { get }
}

extension UIViewController: SetIdentifier {
    static var id: String {
        return String(describing: self)
    }
}

extension UITableViewCell: SetIdentifier {
    static var id: String {
        return String(describing: self)
    }
}
