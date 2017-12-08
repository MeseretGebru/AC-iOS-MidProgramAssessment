//
//  ElementDetailViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
import Foundation
class ElementDetailViewController: UIViewController {

    var element: ElementInfo!
    @IBOutlet weak var anElementImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbol: UILabel!
  //  @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    //@IBOutlet weak var discoveryLabel: UILabel!
    
    
//    @IBAction func saveButton(_ sender: UIButton){
//        let favorite = Favorite(image_link: elementImage.webformatURL, student_name: "Meseret")
//        ElementsAPIClient.shared.post(favorite: favorite){print($0)}
//       
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadLabels()
    }
    
    func loadLabels(){
        self.nameLabel.text = element.name ?? ""
        self.symbol.text = "\(element.symbol)\(element.number)" ?? ""
        self.weightLabel.text = "\(element.weight)"  ?? ""
        self.boilingLabel.text = "\(element.boiling_c)" ?? ""
        self.meltingLabel.text = "\(element.melting_c)" ?? ""
       // self.discoveryLabel.text = element.discovery_year
        
        let lowerNsme = element.name?.lowercased()
        let elementImage = "http://images-of-elements.com/\(lowerNsme).jpg"
        
        let setImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.anElementImageView.image = onlineImage
        }
        let errorHandler: (Error) -> Void = {(error:Error) in
            print(error)
        }
        ImageAPIClient.manager.getImage(from: elementImage, completionHandler: setImage, errorHandler: errorHandler)
    
    }
}

