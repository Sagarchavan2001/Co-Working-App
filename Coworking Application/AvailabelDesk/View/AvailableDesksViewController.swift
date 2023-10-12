//
//  AvailableDesksViewController.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import UIKit
import UserNotifications
class AvailableDesksViewController: UIViewController,UNUserNotificationCenterDelegate {

    @IBOutlet weak var AvailableDeskCollectionView: UICollectionView!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    var desk11 : String?
    private var availableViewmodal = AvailableViewModal()
    
  //  Mark - Data Form Desk View Controller....
    let userNotificationCentre = UNUserNotificationCenter.current()
    var timeFromDeskViewConroller: String?
    var DeskIdFromDeskViewConroller: String?
    var datefromDeskViewcontroller : String?
    var BookWorkStationDeskViewController: String?
    var MeetingRoomDeskViewController : String?
    
//Mark - viewDidLoad..
    override func viewDidLoad() {
        super.viewDidLoad()
        delegatedatasource()
        configration1()
        registerNib()
    }
    func delegatedatasource(){
        self.navigationItem.title = "Available Desks"
        var st = String(datefromDeskViewcontroller ?? "no")
        var t = String(timeFromDeskViewConroller ?? "no")
        var s = String(BookWorkStationDeskViewController ?? "no")
        var r = String(MeetingRoomDeskViewController ?? "no")
        if s == "1"{
            self.navigationItem.title = "Available Desks"
        }else{
            self.navigationItem.title = "Available Rooms"
        }
        self.dateAndTimeLabel.text = " \(st) \(t)"
        
        userNotificationCentre.delegate = self
        userNotificationCentre.requestAuthorization(options: [.alert,.badge,.sound])
        {(success,error) in
            
        }
        //Mark - Available Collection View
        AvailableDeskCollectionView.dataSource = self
        AvailableDeskCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        AvailableDeskCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    //Mark - Register Nib
    func registerNib(){
        let nibname = UINib(nibName: "AvailabilityCollectionViewCell", bundle: nil)
        AvailableDeskCollectionView.register(nibname, forCellWithReuseIdentifier: "AvailabilityCollectionViewCell")
    }
    
    @IBAction func BookedDeskBtn(_ sender: Any) {
//Mark- Confirm Booking Alert
        let alert = UIAlertController(title: "Confirm Booking", message: "Desk Id = \(DeskIdFromDeskViewConroller!) Desk :\(desk11!),  Slot : \(datefromDeskViewcontroller!) \(timeFromDeskViewConroller!)", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [self]_ in
            let nav5 = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
            var sd = String(self.datefromDeskViewcontroller ?? "no")
            var ti = String(self.timeFromDeskViewConroller ?? "no")
            var me = String(self.BookWorkStationDeskViewController ??  self.MeetingRoomDeskViewController ?? "no")
           
            //Mark - Notification configure
            let content = UNMutableNotificationContent()
            content.categoryIdentifier = "this is category indetifire"
            content.title = "Co-Working Application"
            content.body = "You have successfully booked your Workspace"
            content.badge = 1
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 2, repeats: false)
            let identifire = "main identifire"
            let request = UNNotificationRequest.init(identifier: identifire, content: content, trigger: trigger)
            userNotificationCentre.add(request){
                (error) in
                print("\(error?.localizedDescription)")
            }

            DeskApiManager.shared.BookingConfirmApiManager(date:sd , slotsId: ti, workspaceId: desk11!, type: me)
            self.navigationController?.pushViewController(nav5, animated: true)
            
        } ))
//Mark - present Alert Message..
        alert.addAction(UIAlertAction(title: "Cancel", style:.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

//mark - Notification Function
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
    }
        
  

}

//Mark - Extension
extension AvailableDesksViewController{
    func configration1(){
        
//Mark - Function Calling ..
        initViewModal1()
        observeEvent1()
    }
    
    func initViewModal1(){
        availableViewmodal.fetchAvailable()
    }
    //Mark - Api data binding
    func observeEvent1(){
        availableViewmodal.eventHandler = {[weak self] event in
            guard let self else{
                return
               }
            switch event {
            case .loading : print("Availibity  Loading....")
            case .stopLoading : print("Availibity Loaded....")
            case .dataLoaded :
             DispatchQueue.main.async {
                    self.AvailableDeskCollectionView.reloadData()
                                     }
            case .error(_error: let error) :
                print(error)
                
              }
           }
       }
}

//Mark - Delegate Datasource of Collection View
extension AvailableDesksViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableViewmodal.Available1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let CollectionCell = AvailableDeskCollectionView.dequeueReusableCell(withReuseIdentifier: "AvailabilityCollectionViewCell", for: indexPath) as? AvailabilityCollectionViewCell
        else{
            return UICollectionViewCell()
        }
        let AvailableDesks = availableViewmodal.Available1[indexPath.row]
        CollectionCell.AvailableDesks12 = AvailableDesks
        return CollectionCell
    }
//mark - size collection view cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 6 - lay.minimumInteritemSpacing
            
            return CGSize(width:widthPerItem, height:50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        desk11 = availableViewmodal.Available1[indexPath.row].name
        let collection1 = collectionView.cellForItem(at: indexPath) as! AvailabilityCollectionViewCell
        collection1.view1.backgroundColor = UIColor(red: 77/255, green: 98/255, blue: 224/255, alpha: 1.0)
        print(desk11)
    }
    
}
