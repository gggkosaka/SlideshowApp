//
//  ViewController.swift
//  SlideshowApp
//
//  Created by gkosaka on 2020/10/07.
//  Copyright © 2020 gggkosaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // タイマー
    var timer: Timer!
    // 画像一覧
    var images : [String] = []
    
    var i = 0
    let first = 0
    var last = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        let fileManager = FileManager()
        let path = Bundle.main.bundlePath

        do {
            let files = try fileManager.contentsOfDirectory(atPath: path)

//            // 画像一覧
//            var images : [String] = []
            
            for file in files {
                // pngファイルを追加
                if file.hasSuffix(".png") {
                    images.append(file)
                }
            }
            last = images.count - 1
            print(images)
            //print(last)

        }
        catch let error {
            print(error)
        }
        
        
        
        
        
        // バンドルした画像ファイルを読み込み
        //let image = UIImage(named: "01_one")
        let image = UIImage(named: images[i])

        // Image Viewに画像を設定
        imageView.image = image
        
        //ImageViewのタップ認識をONにする
        imageView.isUserInteractionEnabled = true

        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.imageViewTapped(_:))))
        self.view.addSubview(imageView)
        

    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnRun: UIButton!
    
    // 進む
    @IBAction func next(_ sender: Any) {
        if i == last{
            i = first
        }else{
            i = i + 1
        }
        //print(i)
        // Image Viewに画像を設定
        imageView.image = UIImage(named: images[i])
    }
    
     // 戻る
    @IBAction func prev(_ sender: Any) {
        if i == first{
            i = last
        }else{
            i = i - 1
        }
        //print(i)
        // Image Viewに画像を設定
        imageView.image = UIImage(named: images[i])
    }
    
    // 再生／停止ボタン
    @IBAction func autodisp(_ sender: Any) {

        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(nextImg(_:)), userInfo: nil, repeats: true)
        }

        // 活性と非活性を交互に
        if btnNext.isEnabled {
            // 再生クリック時（＝活性時）はタイトルを「停止」にして非活性に
            btnRun.setTitle("停止", for: .normal)
            btnNext.isEnabled = false
            btnPrev.isEnabled = false
        }else{
            // 停止クリック時（＝非活性時）はタイトルを「再生」にして活性に
            btnRun.setTitle("再生", for: .normal)
            btnNext.isEnabled = true
            btnPrev.isEnabled = true
            
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // startTimer() の self.timer == nil で判断するために、 self.timer = nil としておく
        }
    }
    
    // timeInterval: 2.0, repeats: true で指定された通り、2秒毎に呼び出され続ける
    @objc func nextImg(_ timer: Timer) {
        if i == last{
            i = first
        }else{
            i = i + 1
        }
        //print(i)
        // Image Viewに画像を設定
        imageView.image = UIImage(named: images[i])
    }

    // 画像がタップされたら呼ばれる
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        //画面遷移
        self.performSegue(withIdentifier: "toImageExpansion", sender: nil)
        
        // 自動送りしている場合は、停止させる
        if !btnNext.isEnabled {
            // 停止クリック時（＝非活性時）はタイトルを「再生」にして活性に
            btnRun.setTitle("再生", for: .normal)
            btnNext.isEnabled = true
            btnPrev.isEnabled = true
            
            self.timer.invalidate()   // タイマー停止
            self.timer = nil
        }

    }

    // 遷移時に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のimageExpansionViewControllerを取得する
        let imgViewController:imageExpansionViewController = segue.destination as! imageExpansionViewController
        // 遷移先に値を代入して渡す
        imgViewController.recvImg = images[i]

    }

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 他の画面から segue を使って戻ってきた時に呼ばれる
    }

}

