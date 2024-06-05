//
//  ExtensionLabel.swift
//  swift_codebase_project
//
//  Created by 강한결 on 6/5/24.
//

import Foundation
import UIKit

func configureLotteryBallColor(_ value: Int) -> UIColor {
    switch value {
    case 1..<11:
        return .systemYellow
    case 11..<21:
        return .systemBlue
    default:
        return .systemGray
    }
}

extension UILabel {
    func _setLotteryBall(index: Int, value: String) {
        self.text = value
        self.textAlignment = .center
        self.font = .boldSystemFont(ofSize: 12)
       
        
        if index == 6 {
            self.textColor = .black
            self.backgroundColor = .clear
        } else {
            self.textColor = .white
            self.backgroundColor = configureLotteryBallColor(Int(value)!)
        }
    }
    
    func _setLotteryBallRound() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
