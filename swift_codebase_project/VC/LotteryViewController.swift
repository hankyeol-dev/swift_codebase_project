//
//  LotteryViewController.swift
//  swift_codebase_project
//
//  Created by 강한결 on 6/5/24.
//

import UIKit
import SnapKit
import Alamofire

class LotteryViewController: UIViewController {
    /**
        @ data variables
     */
    
    var lotteryDrawTimes = Array(900...1122).map { return String($0) }
    var drawNumbers = [0, 0, 0, 0, 0, 0]
    var bonusNumber = 0
    
    /**
        @ View Instance
     */
    let selectDrawTimeTXF = {
        let f = UITextField()
        
        f.borderStyle = .roundedRect
        f.layer.borderColor = UIColor(named: "systemBlue")?.cgColor
        f.tintColor = .clear
        f.textAlignment = .center
        
        return f
    }()
    let selectDrawTimePKV = UIPickerView();
    
    let infoLabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 10)
        l.textAlignment = .left
        l.text = "당첨번호 안내"
        return l
    }()
    let dateLabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 10)
        l.textAlignment = .right
        l.textColor = .lightGray
        l.text = "-"
        return l
    }()
    let divider = {
        let v = UIView()
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.lightGray.cgColor
        return v
    }()
    let lotteryDrawTimeLabel = {
        let l = UILabel()
        
        l.textAlignment = .center
        l.font = .boldSystemFont(ofSize: 32)
        l.text = "보고싶은 회차의 당첨 결과"
        
        return l
    }()
    let lotteryResultStack = {
        let s = UIStackView()
        s.axis = .horizontal
        s.spacing = 8
        s.alignment = .center
        s.distribution = .fillEqually
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundColor(type: .defaults)
        
        configureSubView()
        configureLayout()
        configurePicker()
    }

    /**
        @ configure function
     */
    func configureSubView() {
        [selectDrawTimeTXF, infoLabel, dateLabel, divider, lotteryDrawTimeLabel, lotteryResultStack].forEach {
            view.addSubview($0)
        }
    }
    
    func configureLayout() {
        let viewGuide = view.safeAreaLayoutGuide
        selectDrawTimeTXF.snp.makeConstraints { f in
            f.horizontalEdges.equalTo(viewGuide).inset(20)
            f.top.equalTo(viewGuide).offset(40)
            f.height.equalTo(50)
        }
        infoLabel.snp.makeConstraints { l in
            l.leading.equalTo(viewGuide).inset(20)
            l.top.equalTo(selectDrawTimeTXF.snp.bottom).offset(32)
        }
        dateLabel.snp.makeConstraints { l in
            l.trailing.equalTo(viewGuide).inset(20)
            l.top.equalTo(selectDrawTimeTXF.snp.bottom).offset(32)
        }
        divider.snp.makeConstraints { d in
            d.horizontalEdges.equalTo(viewGuide).inset(20)
            d.top.equalTo(dateLabel.snp.bottom).offset(8)
            d.height.equalTo(1)
        }
        lotteryDrawTimeLabel.snp.makeConstraints { l in
            l.horizontalEdges.equalTo(viewGuide).inset(20)
            l.top.equalTo(divider.snp.bottom).offset(60)
        }
        lotteryResultStack.snp.makeConstraints { s in
            s.horizontalEdges.equalTo(viewGuide).inset(20)
            s.top.equalTo(lotteryDrawTimeLabel.snp.bottom).offset(28)
            s.height.equalTo(44)
        }
        
    }
    
    func configurePicker() {
        selectDrawTimeTXF.inputView = selectDrawTimePKV
        selectDrawTimePKV.delegate = self
        selectDrawTimePKV.dataSource = self
        
    }
    
    func configureDrawers() {
        var numbers = drawNumbers.map {
            String($0)
        }
        
        numbers.append("+")
        numbers.append(String(bonusNumber))
        
        let mappedLabels = numbers.enumerated().map { (idx, v) in
            let b = UILabel()
            
            b._setLotteryBall(index: idx, value: v)
            
            return b
        }
        
        mappedLabels.forEach {
            lotteryResultStack.addArrangedSubview($0)
        }
        
        mappedLabels.forEach {
            $0.snp.makeConstraints { e in
                e.size.equalTo(44)
            }
            
            $0._setLotteryBallRound()
        }
    }
    
    /**
        @ fetch
     */
    func fetcher(_ drawTime: String) {
        AF.request(Urls.lottery.rawValue + drawTime).responseDecodable(of: Lottery.self) { res in
            switch res.result {
            case .success(let v):
                self.dateLabel.text = v.formattedDate
                self.drawNumbers = v.formattedDrawNumbers
                self.bonusNumber = v.bnusNo
                
                self.configureDrawers()
            case .failure(let v):
                print(v)
            }
        }
    }

}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 변수화 하거나 UserDefaults 로 설정
        return lotteryDrawTimes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lotteryDrawTimes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 여기서 textfield 값 바꾸고, data fetching
        selectDrawTimeTXF.text = lotteryDrawTimes[row]
        lotteryDrawTimeLabel.text = lotteryDrawTimes[row] + "회 당첨결과"
        fetcher(lotteryDrawTimes[row])
        
        
        // data fetching -> lotteryResultStack 내부 요소 값 리랜더
        
        view.endEditing(true)
    }
}
