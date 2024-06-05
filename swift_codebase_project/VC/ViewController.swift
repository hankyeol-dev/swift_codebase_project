//
//  ViewController.swift
//  swift_codebase_project
//
//  Created by 강한결 on 6/5/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let buttonTitles = ["Lottery API", "Movie API", "Weather API"]
    let buttonStackView = {
        let stack = UIStackView()
        return stack;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubview()
        configureLayout()
        configureUI()
    }
    
    /**
     @ configure function
     */
    func configureSubview() {
        view.addSubview(buttonStackView)
        generateButtons().forEach {
            buttonStackView.addArrangedSubview($0)
        }
    }
    
    func configureLayout() {
        buttonStackView.snp.makeConstraints { stack in
            stack.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            stack.verticalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(80)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 12
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
    }
    
    /**
     @ action function
     */
    
    @objc func navigateToVC(_ sender: UIButton) {
        
        var vc: UIViewController?
        
        // tag 값에 따라서 서로 다른 VC로 이동하는 로직 넣기
        switch sender.tag {
        case 0:
            vc = LotteryViewController()
            break;
        case 1:
            vc = MovieViewController()
            break;
        case 2:
            vc = WeatherViewController()
            break
        default:
            vc = nil
        }
        guard let vc else {return}
        // navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true)
    }
    
    /**
     @ etc function
     */
    func generateButtons() -> [UIButton] {
        return buttonTitles.enumerated().map { (index, element) in
            let button = UIButton()
            button.setTitle(element, for: .normal)
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 4
            button.titleLabel?.font = .systemFont(ofSize: 13)
            button.tag = index
            
            button.addTarget(self, action: #selector(navigateToVC), for: .touchUpInside)
            return button
        }
    }
}

