//
//  TabbarController.swift
//  Three_AppStore
//
//  Created by 이윤수 on 2022/08/03.
//

import UIKit

import Then

class TabbarController: UITabBarController {

    private lazy var todayVC = TodayVC().then{
        $0.tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "mail"), tag: 0)
    }
    
    private lazy var appViewVC = UIViewController().then{
        $0.tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up"), tag: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [self.todayVC, self.appViewVC]
    }
}

