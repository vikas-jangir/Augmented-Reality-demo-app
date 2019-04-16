//
//  ImageView.swift
//  S AR
//
//  Created by Vikas Kumar Jangir on 28/01/18.
//  Copyright © 2018 Vikas Kumar Jangir. All rights reserved.
//

import UIKit

class ImageViewAR: UIViewController {
    
    
  
     var arImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arImageView = UIImageView();
        arImageView =  UIImageView(frame:CGRect(x:10, y:50, width:100, height:300));
        
        self.view.addSubview(arImageView);
        // Do any additional setup after loading the view.
    }

    func addimage(image : UIImage) {
        super.viewDidLoad()
        arImageView =  UIImageView(frame:CGRect(x:10, y:150, width:100, height:300));
          let imageScreen : UIImage = image
        arImageView.image = imageScreen
        self.view.addSubview(arImageView);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveImg(_ sender: UIButton) {
        print("save image")
    }
    
    @IBAction func cancel(_ sender: Any) {
        print("cacel button")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
