//
//  DetailVC.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/16.
//

import UIKit

import Then
import SnapKit

class DetailVC : UIViewController {
    
    var appIcon = UIImageView().then{
        $0.layer.cornerRadius = 10
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.backgroundColor = .systemBlue
    }
    
    var mainTitle = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .label
        $0.text = "mainTitle"
    }
    
    var subTitle = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .secondaryLabel
        $0.text = "subTitle"
    }
    
    var downloadBtn = UIButton().then{
        $0.backgroundColor = .systemBlue
        $0.setTitle("받기", for: .normal)
        $0.layer.cornerRadius = 12
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    var shareBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        $0.tintColor = .systemBlue
        
    }
    
    override func viewDidLoad() {
        setView()
    }
}

// MARK: EXTENSION
private extension DetailVC {
    func setView(){
        
        self.view.backgroundColor = .systemBackground
        
        [self.appIcon, self.mainTitle, self.subTitle, self.downloadBtn, self.shareBtn].forEach{
            self.view.addSubview($0)
        }
        
        self.appIcon.snp.makeConstraints{
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).inset(15)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        
        self.mainTitle.snp.makeConstraints{
            $0.top.equalTo(self.appIcon)
            $0.leading.equalTo(self.appIcon.snp.trailing).offset(15)
        }
        
        self.subTitle.snp.makeConstraints{
            $0.top.equalTo(self.mainTitle.snp.bottom).offset(5)
            $0.leading.equalTo(self.mainTitle)
        }
        
        self.downloadBtn.snp.makeConstraints{
            $0.leading.equalTo(self.mainTitle)
            $0.bottom.equalTo(self.appIcon)
            $0.width.equalTo(60)
            $0.height.equalTo(25)
        }
        
        self.shareBtn.snp.makeConstraints{
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(15)
            $0.bottom.equalTo(self.appIcon)
            $0.width.equalTo(32)
            $0.height.equalTo(32)
        }
    }
}
