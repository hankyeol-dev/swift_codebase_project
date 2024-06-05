//
//  Lottery.swift
//  swift_codebase_project
//
//  Created by 강한결 on 6/5/24.
//

import Foundation

struct Lottery: Decodable {
    let drwNo: Int
    let drwNoDate: String
    let totSellamnt: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    
    var formattedDate: String {
        let strArray = drwNoDate.split(separator: "-")
        return "\(strArray[0])년 \(strArray[1])월 \(strArray[2])일"
    }
    
    var formattedDrawTime: String {
        return "\(drwNo)회"
    }
    
    var formattedDrawNumbers: [Int] {
        return [drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6]
    }
}
