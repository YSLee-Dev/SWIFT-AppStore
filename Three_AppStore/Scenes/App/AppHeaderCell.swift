//
//  AppHeaderCell.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/04.
//

import UIKit

import Then
import SnapKit

class AppHeaderCell : UICollectionReusableView {
    
    let cellId = "AppHeaderCell"
    
    var mainTitle = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    var moreBtn = UIButton().then{
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.setTitleColor(.blue, for: .normal)
    }
    
    override func layoutSubviews() {
        self.addSubview(self.mainTitle)
        self.addSubview(self.moreBtn)
        
        self.mainTitle.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(5)
            $0.top.equalToSuperview()
        }
        self.moreBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-5)
            $0.centerY.equalTo(self.mainTitle)
        }
    }
}

