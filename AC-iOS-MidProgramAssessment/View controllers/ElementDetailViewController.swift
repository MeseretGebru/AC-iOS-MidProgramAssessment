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
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var discoveryLabel: UILabel!
    
    
    @IBAction func saveButton(_ sender: UIButton){
        let favorite = Favorite(name: "Meseret", favorite_element: element.name)
        ElementsAPIClient.shared.post(favorite: favorite){print($0)}
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadLabels()
    }
    
    func loadLabels(){
        self.numberLabel.text = "\(element.number ?? 0)"
        self.nameLabel.text = element.name ?? ""
        self.symbol.text = "\(element.symbol ?? "n/a")\(element.number?.description ?? "")"
        self.weightLabel.text = "\(element.weight?.description ?? "")"
        self.boilingLabel.text = "Boiling: \(element.boilingC?.description ?? "")"
        self.meltingLabel.text = "Melting: \(element.meltingC?.description ?? "")"
        
        let lowerName = element.name?.lowercased()
        let elementImage = "http://images-of-elements.com/\(lowerName ?? "").jpg"
        
        let setImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.anElementImageView.image = onlineImage
        }
        let errorHandler: (Error) -> Void = {(error:Error) in
            print(error)
        }
        ImageAPIClient.manager.getImage(from: elementImage, completionHandler: setImage, errorHandler: errorHandler)
    
    }
}

