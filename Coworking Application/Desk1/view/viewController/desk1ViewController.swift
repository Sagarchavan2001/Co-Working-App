//
//  desk1ViewController.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import UIKit
import HorizontalCalendarView
class desk1ViewController: UIViewController{
    
    
    private var slotsViewModal = SlotsViewModal()

    @IBOutlet weak var timeCollectionView: UICollectionView!
    var BookWorkStationHomeViewController:String?
    var MeetingRoomHomeViewController:String?
    @IBOutlet weak var canlenderCollectionView: UICollectionView!
    
    var time1 : String?
    var date1 : String?
    var deskid : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Select Date & Time"
        configration2()
        let dd = String(BookWorkStationHomeViewController ?? "00")
        let ss = String(MeetingRoomHomeViewController ?? "00")
        print("\(dd) \(ss)")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        canlenderCollectionView.setCollectionViewLayout(layout, animated: true)

        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical
        layout1.minimumLineSpacing = 10
        layout1.minimumInteritemSpacing = 10
        timeCollectionView.setCollectionViewLayout(layout1, animated: true)
      
        regNib()
       
    }
    func regNib(){
        let nib1 = UINib(nibName:"calenderCollectionViewCell", bundle: nil)
       canlenderCollectionView.register(nib1, forCellWithReuseIdentifier: "calenderCollectionViewCell")
       let nibname1 = UINib(nibName: "timeCollectionViewCell", bundle: nil)
       timeCollectionView.register(nibname1, forCellWithReuseIdentifier: "timeCollectionViewCell")
   
    }
    
    @IBAction func NextButton(_ sender: Any) {
        let nav4 = storyboard?.instantiateViewController(withIdentifier: "AvailableDesksViewController")as! AvailableDesksViewController
       let dd = time1
        nav4.timeFromDeskViewConroller = dd
        nav4.datefromDeskViewcontroller = date1
        nav4.DeskIdFromDeskViewConroller = deskid
        nav4.BookWorkStationDeskViewController = BookWorkStationHomeViewController
        nav4.MeetingRoomDeskViewController = MeetingRoomHomeViewController
        
        navigationController?.pushViewController(nav4, animated: true)
    }
}
extension desk1ViewController{
    func configration2(){
        initViewModal2()
        observeEvent2()
    }
    func initViewModal2(){
        slotsViewModal.fetchSlots()
    }
//data binding
    func observeEvent2(){
        slotsViewModal.eventHandler = {[weak self] event in
            guard let self else{
                return
            }
            switch event {
            case .loading : print("slots  Loading....")
            case .stopLoading : print("slots Loaded....")
            case .dataLoaded :
             
                            DispatchQueue.main.async {
                                  self.timeCollectionView.reloadData()
                        }
            case .error(_error: let error) :
                print(error)
                
            }
            
        }
    }
}

extension desk1ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == canlenderCollectionView {
            return 31
        } else {
            return slotsViewModal.slots1.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == canlenderCollectionView {
            //Mark - cell for calender
            let cell = canlenderCollectionView.dequeueReusableCell(withReuseIdentifier: "calenderCollectionViewCell", for: indexPath) as! calenderCollectionViewCell
            if let flowLayout = canlenderCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
            
            // Mark - Date Formatter for Day
            let currentDate = Calendar.current.date(byAdding: .day, value: indexPath.item, to: Date())!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            cell.dateLabel.text = dateFormatter.string(from: currentDate)
            dateFormatter.dateStyle = .medium
            print(dateFormatter.string(from: currentDate))
            date1 = dateFormatter.string(from: currentDate)
            let currentDate1 = Calendar.current.date(byAdding:.day, value: indexPath.item, to: Date())!
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateStyle = .full
            
            print(dateFormatter1.string(from: currentDate1))
            let csvArray = dateFormatter1.string(from: currentDate1).components(separatedBy: ",")
            if indexPath.item == 0 {
                cell.backgroundColor = UIColor(red: 77/255, green: 98/255, blue: 224/255, alpha: 1.0)
            } else {
                
                cell.backgroundColor = UIColor.clear
            }
            
            //Mark - Month& Day
            var mon = csvArray[1]
            cell.monthLabel.text = String(mon.prefix(4))
            var day = csvArray[0]
            cell.dayLabel.text = String(day.prefix(3))
            
            return cell
        }else{
            //Mark - cell for timeCollectionView
            guard let  cell2 = timeCollectionView.dequeueReusableCell(withReuseIdentifier: "timeCollectionViewCell", for: indexPath) as? timeCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            let AvailableSlots = slotsViewModal.slots1[indexPath.row]
            cell2.AvailableSlots12 = AvailableSlots
            return cell2
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == canlenderCollectionView {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 6 - lay.minimumInteritemSpacing
            
            return CGSize(width:widthPerItem, height:collectionView.frame.height)
            
        }else{
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
            
            return CGSize(width:widthPerItem, height:50)
            
        }
        
    }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        time1 = slotsViewModal.slots1[indexPath.row].Sname
       deskid = String(slotsViewModal.slots1[indexPath.row].Sid)
        let collection = collectionView.cellForItem(at: indexPath) as! timeCollectionViewCell
       collection.view2.backgroundColor = UIColor(red: 77/255, green: 98/255, blue: 224/255, alpha: 1.0)
      print(time)
    }
}
