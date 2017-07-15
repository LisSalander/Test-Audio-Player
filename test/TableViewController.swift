//
//  TableViewController.swift
//  test
//
//  Created by vika on 7/10/17.
//  Copyright © 2017 vika. All rights reserved.
//

import UIKit
import UserNotifications


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let arrayNameSound = ["Шум дощу","Птахи в лісі","Квакання жаб","Дельфіни","Ричання тигра","Струмок","Костер","Гроза","Шум моря", "Метелиця"]
    let arrayPicture = ["one.jpg", "two.jpg", "three.jpg","four.jpg","five.jpg","six.jpg","seven.jpeg","eight.jpg","nine.jpg","ten.jpg"]
    
    

   let likeView = LikeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        
        let content = UNMutableNotificationContent()
        
        content.body = "В нас зявились нові звуки!"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)


    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNameSound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        likeView.fetchData()
        for i in 0..<likeView.likeSound.count{
        var ind = indexPath.row
        if ind == Int(likeView.likeSound[i].id) {
        let origImage =  #imageLiteral(resourceName: "like")
        let tintedImage = origImage.withRenderingMode(.alwaysTemplate)
        cell.likeOutlet.setImage(tintedImage, for: .normal)
                cell.likeOutlet.tintColor = .orange
             cell.isLike = true
            }
        cell.soundImage.layer.cornerRadius = cell.soundImage.frame.size.width/15
        cell.soundImage.clipsToBounds = true
        cell.nameLabel.text = arrayNameSound[indexPath.row]
        cell.soundImage.image = UIImage(named: arrayPicture[indexPath.row])
        cell.likeOutlet.tag = indexPath.row
       
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell,
            let indexPath = self.tableView.indexPath(for: cell) {
            
            let detail = segue.destination as! ViewController
            detail.indexSound = indexPath.row
            
            
        }
    }

   
}
