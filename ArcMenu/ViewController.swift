//
//  ViewController.swift
//  ArcMenu
//
//  Created by Rex Peng on 2019/10/4.
//  Copyright © 2019 Rex Peng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //configureArcMenu()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureArcMenu()
    }
    
    func configureArcMenu() {
        let iView1 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "777", content: "事假", unit: "(天)", color: UIColor.withInt(0, 117, 235))
        let iView2 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "40.2", content: "加班", unit: "(時)", color: UIColor.withInt(76, 199, 194))
        let iView3 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "88888", content: "累積", unit: "獎金", color: UIColor.withInt(255, 67, 79))
        let iView4 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "66", content: "考績", unit: "分數", color: UIColor.withInt(255, 107, 68))
        let iView5 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "88", content: "睡眠", unit: "小時", color: UIColor.withInt(255, 67, 79))
        let iView6 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "77", content: "運動", unit: "分鐘", color: UIColor.withInt(255, 67, 79))
        let iView7 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "999", content: "消耗", unit: "卡路里", color: UIColor.withInt(255, 67, 79))

        let menus:[UIView] = [iView1, iView2, iView3, iView4, iView5, iView6, iView7]
        
        let arcMenu = ArcMenu(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 120))
        //arcMenu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arcMenu)
        arcMenu.setMenuItem(items: menus)
        
//        arcMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        arcMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//        arcMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        arcMenu.heightAnchor.constraint(equalToConstant: 180).isActive = true
        arcMenu.backgroundColor = .gray
        view.backgroundColor = .lightGray
        
    }
}

