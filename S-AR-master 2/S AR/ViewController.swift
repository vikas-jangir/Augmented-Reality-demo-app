//
//  ViewController.swift
//  S AR
//
//  Created by Vikas Kumar Jangir on 26/01/18.
//  Copyright © 2018 Vikas Kumar Jangir. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController,UICollectionViewDataSource ,UICollectionViewDelegate{

    let itemArray :[String] = ["cup" ,"table", "vase" ,"boxing", "Hawk_T2", "Froakie","Wolf" , "Linoone"];
    @IBOutlet weak var sceneview: ARSCNView!
    @IBOutlet weak var itemCollectionView: UICollectionView!
   

    
    let configuration = ARWorldTrackingConfiguration();
    var selectItem : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sceneview.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin];
        self.sceneview.session.run(configuration);
        self.itemCollectionView.dataSource = self;
        self.itemCollectionView.delegate = self;
        self.registerTapRecoginser();
      
    }
    
    @IBAction func cameraCapture(_ sender: Any) {
//        let imagShow = ImageViewAR();
        let imageScreen : UIImage = sceneview.snapshot();
//        imagePicker.image = imageScreen;
    
        let imagShow : ImageViewAR = ImageViewAR();
        imagShow.addimage(image: imageScreen)
    }
    
    
    func registerTapRecoginser() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneview.addGestureRecognizer(tapGestureRecognizer);
        
    }
    @objc func tapped(sender : UITapGestureRecognizer) {
        _ = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneview);
        let hitTest = sceneview.hitTest(tapLocation, types: .estimatedHorizontalPlane);
        if !hitTest.isEmpty{
            self.addItemAtDown(hitTestResunlt: hitTest.first!)
        }else {
            self.addItemAtSky();
        }
    }
    
    func addItemAtDown(hitTestResunlt : ARHitTestResult){
        let item : String = self.selectItem
        
        if !item.isEmpty {
            let scene = SCNScene(named: "Models.scnassets/\(item).scn");
            let node = (scene?.rootNode.childNode(withName:item, recursively: true))!
            if item == "Hawk_T2"{
                node.position = SCNVector3(0,0,-20);
                 self.sceneview.scene.rootNode.addChildNode(node);
                let moveAction  = SCNAction.moveBy(x: 0, y: 0, z: 20, duration: 10);
                node.runAction(moveAction);
            }
            else {
            let transform = hitTestResunlt.worldTransform;
            let thiredColoum = transform.columns.3;
            node.position = SCNVector3(thiredColoum.x,thiredColoum.y,thiredColoum.z);
                 self.sceneview.scene.rootNode.addChildNode(node);
            }
            
        }
    }
    
    func addItemAtSky() {
        let item : String = self.selectItem
        
        if !item.isEmpty {
            let scene = SCNScene(named: "Models.scnassets/\(item).scn");
            let node = (scene?.rootNode.childNode(withName:item, recursively: true))!
            if item == "Hawk_T2"{
                node.position = SCNVector3(0,0,-20);
                self.sceneview.scene.rootNode.addChildNode(node);
                let moveAction  = SCNAction.moveBy(x: 0, y: 0, z: 20, duration: 10);
                node.runAction(moveAction);
            }
            else {
                print("Reset")
            }
            
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession() {
        self.sceneview.session.pause();
        self.sceneview.scene.rootNode.enumerateChildNodes{(node ,_) in
            node.removeFromParentNode();
        }
        self.sceneview.session.run(configuration, options: [.removeExistingAnchors,.resetTracking]);
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ARModelCell;
        cell.itemLabel.text = self.itemArray[indexPath.row];
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath);
        self.selectItem = itemArray[indexPath.row];
        cell?.backgroundColor = UIColor.green;
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath);
        cell?.backgroundColor = UIColor.orange;
    }

    
}



