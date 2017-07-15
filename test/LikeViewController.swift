//
//  LikeViewController.swift
//  test
//
//  Created by vika on 7/11/17.
//  Copyright © 2017 vika. All rights reserved.
//

import UIKit
import CoreData

class LikeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var likeTable: UITableView!
    
    var likeSound:[Entity] = []
   
    
    @IBOutlet weak var lable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeTable.delegate = self
        likeTable.dataSource = self
        
        self.fetchData()
       // self.likeTable.reloadData()
       
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeSound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likeCell", for: indexPath) as! TableViewCell
        let sound = likeSound[indexPath.row]
        cell.likeNameLabel.text = sound.soundName
        cell.likeSoundImage.image = UIImage(named: sound.soundImage!)
        
        return cell
    }
    
    func fetchData(){
        do{
            likeSound = try DatabaseController.getContext().fetch(Entity.fetchRequest())
        }
        catch{
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell,
            let indexPath = self.likeTable.indexPath(for: cell) {
            let sound = likeSound[indexPath.row]
            let detail = segue.destination as! ViewController
            detail.indexSound = Int(sound.id)
            
            
        }
    }
   
}
