//
//  TodayCell.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/03.
//

import UIKit

import Then
import SnapKit

final class TodayCell : UICollectionViewCell{
    
    let cellId = "TodayCell"
    
    var mainTitle = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.textColor = .white
    }
    
    var subTitle = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 13)
        $0.textColor = .white
    }
    
    var footerTitle = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 13)
        $0.textColor = .white
    }
    
    var imageView = UIImageView().then{
        $0.backgroundColor = .darkGray
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        self.imageView.addSubview(self.subTitle)
        self.subTitle.snp.makeConstraints{
            $0.leading.top.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(-25)
            
        }
        
        self.imageView.addSubview(self.mainTitle)
        self.mainTitle.snp.makeConstraints{
            $0.leading.trailing.equalTo(self.subTitle)
            $0.top.equalTo(self.subTitle.snp.bottom).inset(-10)
        }
        self.imageView.addSubview(self.footerTitle)
        self.footerTitle.snp.makeConstraints{
            $0.leading.trailing.equalTo(self.subTitle)
            $0.bottom.equalToSuperview().inset(25)
        }
    }
}
