//
//  AvailabilityCollectionViewCell.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import UIKit

class AvailabilityCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var AvailableDesks12 :Availability?{
        didSet{
            AvailableDesksDetailsConfigration()
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view1.layer.cornerRadius = 5
    }
   func AvailableDesksDetailsConfigration(){
       guard let AvailableDesks12 else{return}
       nameLabel.text = AvailableDesks12.name
       if AvailableDesks12.Active == true{
           view1.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 255/255, alpha: 1.0)
       
   }
       else{
           
           view1.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1.0)
       }
    }
   

}
