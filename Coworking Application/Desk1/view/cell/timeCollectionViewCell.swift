//
//  timeCollectionViewCell.swift
//  Coworking Application
//
//  Created by STC on 10/10/23.
//

import UIKit

class timeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    var AvailableSlots12:Slots?{
        didSet{
            AvailableSlotsDetailsConfigration()
        }
    }
override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view2.layer.cornerRadius = 5
    }
    func AvailableSlotsDetailsConfigration(){
        guard let AvailableSlots12 else{return}
        timeLabel.text = AvailableSlots12.Sname
        if AvailableSlots12.Sactive == true{
            view2.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 255/255, alpha: 1.0)
    }
        else{
            view2.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1.0)
        }
     }
 }


