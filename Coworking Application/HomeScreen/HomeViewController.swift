//
//  HomeViewController.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    @IBOutlet weak var BookedWorkStationImageView: UIImageView!
    
    @IBOutlet weak var meetingroomImageView: UIImageView!
    
    @IBOutlet weak var Bookview: UIView!
    
    @IBOutlet weak var roomBookView: UIView!
    
    
    override func viewDidLoad() {
        Bookview.layer.cornerRadius  = 10
        roomBookView.layer.cornerRadius = 10
        super.viewDidLoad()
Addgesture()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Booking History", style: .plain, target: self, action: #selector(bookedTap)
    )
        navigationItem.rightBarButtonItem?.customView?.backgroundColor = UIColor.systemBlue
        self.navigationItem.title = "Co-Working"

        // Do any additional setup after loading the view.
    }
    func Addgesture(){
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture1.numberOfTapsRequired = 1
        tapGesture1.numberOfTouchesRequired = 1
        BookedWorkStationImageView.addGestureRecognizer(tapGesture1)
        BookedWorkStationImageView.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture2))
        tapGesture2.numberOfTapsRequired = 1
        tapGesture2.numberOfTouchesRequired = 1
        meetingroomImageView.addGestureRecognizer(tapGesture2)
        meetingroomImageView.isUserInteractionEnabled = true
        
    }

    @objc private func handleTapGesture() {
        let nav2 = storyboard?.instantiateViewController(withIdentifier: "desk1ViewController")as! desk1ViewController
        Bookview.backgroundColor = UIColor(red: 77/255, green: 98/255, blue: 224/255, alpha: 1.0)
        let vv = "1"
        nav2.BookWorkStationHomeViewController = vv
        navigationController?.pushViewController(nav2, animated: true)
    }
    @objc private func handleTapGesture2() {
        let nav2 = storyboard?.instantiateViewController(withIdentifier: "desk1ViewController")as! desk1ViewController
        roomBookView.backgroundColor = UIColor(red: 77/255, green: 98/255, blue: 224/255, alpha: 1.0)
        let hh = "2"
        nav2.MeetingRoomHomeViewController = hh
        navigationController?.pushViewController(nav2, animated: true)
    }
    
     @objc private func bookedTap(){
        
        
        let nav1 = storyboard?.instantiateViewController(withIdentifier: "BookingViewController")as! BookingViewController
        navigationController?.pushViewController(nav1, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
