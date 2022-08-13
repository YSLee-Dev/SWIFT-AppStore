//
//  CodeBtnCell.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/13.
//

import UIKit

import Then
import SnapKit

class CodeBtnCell : UICollectionViewCell{
    
    let btn = UIButton().then{
        $0.backgroundColor = .secondarySystemBackground
        $0.setTitle("코드교환", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 15
    }
    
    override func layoutSubviews() {
        self.addSubview(self.btn)
        self.btn.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
    }
}
