//
//  LargeCell.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/04.
//

import UIKit

import Then
import SnapKit

class LargeCell : UICollectionViewCell{
    
    let cellID = "LargeCell"
    
    var topTitle = UILabel().then{
        $0.textColor = .blue
        $0.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    var mainTitle = UILabel().then{
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    var subTitle = UILabel().then{
        $0.textColor = .gray
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    var imageView = UIImageView().then{
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        [self.topTitle, self.mainTitle, self.subTitle, self.imageView].forEach{
            self.addSubview($0)
        }
        
        self.topTitle.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
        }
        self.mainTitle.snp.makeConstraints{
            $0.leading.equalTo(self.topTitle)
            $0.top.equalTo(self.topTitle.snp.bottom).offset(5)
        }
        self.subTitle.snp.makeConstraints{
            $0.leading.equalTo(self.topTitle)
            $0.top.equalTo(self.mainTitle.snp.bottom).offset(5)
        }
        self.imageView.snp.makeConstraints{
            $0.width.equalToSuperview().inset(5)
            $0.height.equalTo(self.imageView.snp.width)
            $0.leading.equalToSuperview()
            $0.top.equalTo(self.subTitle.snp.bottom).offset(5)
        }
    }
}
