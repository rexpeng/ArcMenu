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
        
        configureArcMenu()
    }


    func configureArcMenu() {
        let iView1 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "777", content: "可特休", unit: "(天)", color: UIColor.withInt(0, 117, 235))
        let iView2 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "40.2", content: "可補休", unit: "(時)", color: UIColor.withInt(76, 199, 194))
        let iView3 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "88888", content: "累積", unit: "獎金", color: UIColor.withInt(255, 67, 79))
        let iView4 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "66", content: "考績", unit: "分數", color: UIColor.withInt(255, 107, 68))
        let iView5 = MyMenuItem(width: 80, icon: UIImage(named: "my_top_item_bg"), number: "88", content: "考績", unit: "分數", color: UIColor.withInt(255, 67, 79))

        let menus:[UIView] = [iView1, iView2, iView3, iView4, iView5]
        
        let arcMenu = ArcMenu()
        arcMenu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arcMenu)
        arcMenu.setMenuItem(items: menus)
        
        arcMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        arcMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        arcMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        arcMenu.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        view.backgroundColor = .lightGray
        
    }
}

