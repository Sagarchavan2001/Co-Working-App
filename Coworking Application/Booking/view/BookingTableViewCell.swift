//
//  BookingTableViewCell.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import UIKit

class BookingTableViewCell: UITableViewCell {
    
   //mark - Outlets for elements
    @IBOutlet weak var bookIdLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bookedOnLabel: UILabel!
    var booking12 : Booking?{
        didSet{
            BookingsDetailsConfigration()
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stackView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//Mark -  function for BookingsDetailsConfigration.
    func BookingsDetailsConfigration(){
        guard let booking12 else{return}
        bookIdLabel.text = String(booking12.deskId)
        nameLabel.text = booking12.name
        bookedOnLabel.text = booking12.bookedOn
        
    }
}
