//
//  BoxOffice.swift
//  swift_codebase_project
//
//  Created by 강한결 on 6/5/24.
//

import Foundation

struct Movie: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}

struct InnerBoxOffice: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [Movie]
}

struct BoxOffice: Decodable {
    let boxOfficeResult: InnerBoxOffice
}

