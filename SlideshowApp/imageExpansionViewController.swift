//
//  imageExpansionViewController.swift
//  SlideshowApp
//
//  Created by gkosaka on 2020/10/08.
//  Copyright © 2020 gggkosaka. All rights reserved.
//

import UIKit

class imageExpansionViewController: UIViewController {

    var recvImg:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         // ViewController.prepare で設定した画像名を元に設定
        exImage.image = UIImage(named: recvImg)
/*
        let w:CGFloat = exImage.image!.size.width
        let h:CGFloat = exImage.image!.size.height
        //print(w)
        //print(h)
        
        // 画像の表示サイズを設定（1.5倍）
        exImage.frame = CGRect(x: 0,
        y: 0,
        width: w * 1.5,
        height: h * 1.5)
        
        // 画像を中央に
        exImage.center = self.view.center
*/
        
    }
    
    @IBOutlet weak var exImage: UIImageView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
