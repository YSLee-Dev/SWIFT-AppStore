//
//  HeaderCell.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/03.
//

import UIKit

import Then
import SnapKit

final class HeaderCell: UICollectionReusableView {
    let cellID = "HeaderView"
    
    let date = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .gray
    }
    
    let titleLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 36)
        $0.textColor = .black
    }
    
    override func layoutSubviews() {
        self.addSubview(self.date)
        self.date.snp.makeConstraints{
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.date.snp.bottom).inset(-5)
            $0.leading.equalToSuperview()
        }
    }
}
