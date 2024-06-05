//
//  BoxOfficeCell.swift
//  swift_codebase_project
//
//  Created by 강한결 on 6/5/24.
//

import UIKit
import SnapKit

class BoxOfficeCell: UITableViewCell {
    
    var cellData: Movie?
    
    let backView = UIView()
    let rankLabel = UILabel()
    let titleLabel = UILabel()
    let openDateLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubview()
        configureLayout()
        configureUI()
    }
    
    
    func configureSubview() {
        self.contentView.addSubview(backView)
        [rankLabel,titleLabel,openDateLabel].forEach {
            backView.addSubview($0)
        }
        
    }
    
    func configureLayout() {
        backView.snp.makeConstraints { v in
            v.edges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
        }
        rankLabel.snp.makeConstraints { l in
            l.leading.verticalEdges.equalTo(backView)
            l.width.equalTo(32)
        }
        titleLabel.snp.makeConstraints { l in
            l.verticalEdges.equalTo(backView)
            l.leading.equalTo(rankLabel.snp.trailing).offset(12)
            l.trailing.equalTo(openDateLabel.snp.leading).offset(-12)
        }
        openDateLabel.snp.makeConstraints { l in
            l.trailing.verticalEdges.equalTo(backView).inset(8)
        }
    }
    
    func configureUI() {
        rankLabel.textColor = .black
        rankLabel.font = .systemFont(ofSize: 15)
        rankLabel.textAlignment = .center
//        rankLabel.backgroundColor = .white
        
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 15)
        
        openDateLabel.font = .systemFont(ofSize: 12)
        openDateLabel.textColor = .black
    }
    
    func setCellData(_ data: Movie) {
        cellData = data
        
        if let cellData {
            rankLabel.text = cellData.rank
            titleLabel.text = cellData.movieNm
            openDateLabel.text = cellData.openDt
        }
    }
}
