//
//  BookingViewController.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import UIKit

class BookingViewController: UIViewController {
    @IBOutlet weak var bookingTableView: UITableView!
    private var bookingViewModal = BookingViewModal()
//Mark - ViewDid Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Booking History"
        configration()
    }
}

//Mark- extension...
extension BookingViewController{
    func configration(){
        //delegate And Data source of tableview
        bookingTableView.dataSource = self
        bookingTableView.delegate = self
        bookingTableView.register(UINib(nibName: "BookingTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingTableViewCell")
//function calling
         initViewModal()
         observeEvent()
    }
    func initViewModal(){
        bookingViewModal.fetchBooking()
    }
    //data binding
    func observeEvent(){
            bookingViewModal.eventHandler = {[weak self] event in
            guard let self else{
                return
            }
            switch event {
            case .loading : print("booking Loading....")
            case .stopLoading : print("bookings Loaded....")
            case .dataLoaded :
             //  print("Bookings.......\(self.bookingViewModal.bookigs1)")
             DispatchQueue.main.async {
                   self.bookingTableView.reloadData()
             }
            case .error(_error: let error) :
                print(error)
                
            }
            
        }
    }
}

extension BookingViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookingViewModal.bookigs1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookingTableView.dequeueReusableCell(withIdentifier: "BookingTableViewCell", for: indexPath) as? BookingTableViewCell
        else{
            return UITableViewCell()
        }
        let booking = bookingViewModal.bookigs1[indexPath.row]
        cell.booking12 = booking
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
