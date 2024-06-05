//
//  MovieViewController.swift
//  swift_codebase_project
//
//  Created by 강한결 on 6/5/24.
//

import UIKit
import SnapKit
import Alamofire

class MovieViewController: UIViewController {
    /**
     @ variables
     */
    var data: [Movie] = []
    
    /**
     @ view instance
     */
    let txf = {
        let f = UITextField()
        
        f.borderStyle = .line
        f.layer.borderColor = UIColor.white.cgColor
        f.textColor = .white
        f.font = .systemFont(ofSize: 15)
        
        return f
    }()
    let btn = {
        let b = UIButton()
        b.setTitle("검색", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 15)
        b.backgroundColor = .black
        return b
    }()
    let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setBackgroundColor(type: .dark)
        
        configureSubView()
        configureLayout()
        fetchData(calcYesterday())
        configureTable()
    }
    
    func configureSubView() {
        [txf, btn, table].forEach {
            view.addSubview($0)
        }
    }
    
    func configureLayout() {
        let v = view.safeAreaLayoutGuide
        txf.snp.makeConstraints { f in
            f.top.equalTo(v).offset(50)
            f.leading.equalTo(v).inset(20)
            f.right.equalTo(btn.snp.left).offset(-16)
            f.height.equalTo(56)
            f.center.equalTo(btn.snp.center)
        }
        btn.snp.makeConstraints { b in
            b.top.equalTo(v).offset(50)
            b.trailing.equalTo(v).inset(20)
            b.height.equalTo(56)
            b.width.equalTo(80)
            b.center.equalTo(txf.snp.center)
        }
        table.snp.makeConstraints { t in
            t.top.equalTo(txf.snp.bottom).offset(32)
            t.horizontalEdges.bottom.equalTo(v).inset(20)
        }
    }
    
    
    func configureTable() {
        table.delegate = self
        table.dataSource = self
        table.register(BoxOfficeCell.self, forCellReuseIdentifier: BoxOfficeCell.id)
        table.rowHeight = 60
    }
    
    /**
     @fetch
     */
    func fetchData(_ date: String) {
        AF.request(Urls.boxOffice.rawValue + "key=\(APIKey.movieAPI)&" + "targetDt=\(date)").responseDecodable(of: BoxOffice.self) { res in
            switch res.result {
            case .success(let v):
                self.data = v.boxOfficeResult.dailyBoxOfficeList
                self.table.reloadData()
            case .failure(let v):
                print(v)
            }
        }
    }
    
    /**
     @ helper
     */
    func helpFormatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko-KR")
        
        return formatter.string(from: date)
    }
    
    func calcYesterday() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        return helpFormatDate(yesterday!)
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: BoxOfficeCell.id, for: indexPath) as! BoxOfficeCell
        
        cell.setCellData(self.data[indexPath.row])
        
        return cell
    }
    
    
}
