//
//  SeparatorCell.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/13.
//

import UIKit

import SnapKit
import Then

class SeparatorCell : UICollectionReusableView{
    let separator = UIView().then{
        $0.backgroundColor = .separator
    }
    
    override func layoutSubviews() {
        self.addSubview(self.separator)
        self.separator.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
