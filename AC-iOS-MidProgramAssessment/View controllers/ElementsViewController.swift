//
//  ViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q  on 12/7/17.
//  Copyright © 2017 C4Q . All rights reserved.
//
import Foundation
import UIKit

class ElementsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var elementsTableView: UITableView!
    
    var elements = [ElementInfo](){
        didSet {
            self.elementsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elementsTableView.dataSource = self
        self.elementsTableView.delegate = self
        loadData()
    }

    func loadData(){
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let setElements = {(onlineElements: [ElementInfo]) in
            
            self.elements = onlineElements
            self.elementsTableView.reloadData()
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        ElementsAPIClient.shared.getElements(from: urlStr,
                                              completionHandler: setElements,
                                              errorHandler: printErrors)
    }
}

extension ElementsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Elements Cell", for: indexPath) as? ElementsTableViewCell
        let element = elements[indexPath.row]
        if let unwrappedCell = cell {
            unwrappedCell.nameLabel.text = element.name
            unwrappedCell.symbolLabel.text = element.symbol
            unwrappedCell.numberLabel.text = "\(element.number ?? 0)"
            unwrappedCell.atomicWeightLabel.text = "\(element.weight ?? 0.0)"
            
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell?.elementsImageView?.image = onlineImage
            cell?.setNeedsLayout()
        }
        let errorHandler: (Error) -> Void = {(error: Error) in
            print(error)
        }
            
        let  elementNumber = "\(element.number)"
            if elementNumber.count != 3 {
                let elementNumberWithThreeDigits = String(format: "%03ld", element.number!)
               print(elementNumberWithThreeDigits)
            
            let imageUrlStr = "http://www.theodoregray.com/periodictable/Tiles/\(elementNumberWithThreeDigits)/s7.JPG"
            
   
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: errorHandler)
            }
            return unwrappedCell
        }
        
        return cell!
        
    }
    

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destinationElementDVC = segue.destination as? ElementDetailViewController{
            destinationElementDVC.element = elements[elementsTableView.indexPathForSelectedRow!.row]
        }
   }



}
