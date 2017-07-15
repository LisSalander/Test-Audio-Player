//
//  TableViewCell.swift
//  test
//
//  Created by vika on 7/10/17.
//  Copyright © 2017 vika. All rights reserved.
//

import UIKit
import CoreData


class TableViewCell: UITableViewCell {
   
    @IBOutlet weak var soundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
     @IBOutlet weak var likeNameLabel: UILabel!
     @IBOutlet weak var likeSoundImage: UIImageView!
    
    let tableView = TableViewController()
    let viewController = ViewController()
    let likeView = LikeViewController()
    var index = Int()
    
    @IBOutlet weak var likeOutlet: UIButton!
    
    @IBAction func likeButton(_ sender: Any) {
        index = (sender as AnyObject).tag
        actionLike(isLike)
    }
    
    var isLike: Bool = false {
        didSet {
            changeButtonLike(isLike)
        }
    }
    
       
    func changeButtonLike(_ like: Bool) {
        if like {
            let origImage =  #imageLiteral(resourceName: "like")
            let tintedImage = origImage.withRenderingMode(.alwaysTemplate)
            likeOutlet.setImage(tintedImage, for: .normal)
            likeOutlet.tintColor = .orange
        } else {
            let origImage =  #imageLiteral(resourceName: "like")
            let tintedImage = origImage.withRenderingMode(.alwaysTemplate)
            likeOutlet.setImage(tintedImage, for: .normal)
            likeOutlet.tintColor = .black
        }
    }
    
    func actionLike(_ like: Bool) {
        
        let context = DatabaseController.getContext()
        
        if like {
            likeView.fetchData()
            var sound = Int16()
            for i in 0..<likeView.likeSound.count {
                sound = likeView.likeSound[i].id
                print(index)
                print(sound)
                if Int(sound) == index {
                    context.delete(likeView.likeSound[i])
                    DatabaseController.saveContext()

                    do{
                        likeView.likeSound = try context.fetch(Entity.fetchRequest())
                    }
                    catch{
                        print(error)
                    }
                   break
                }

            }
            
           
            isLike = false
            
        }else {
   
            let soundClassName:String = String(describing: Entity.self)
            
            let sound:Entity = NSEntityDescription.insertNewObject(forEntityName: soundClassName, into: DatabaseController.getContext()) as! Entity
            sound.soundName = tableView.arrayNameSound[index]
            sound.sound  = viewController.arraySound[index]
            sound.soundImage = tableView.arrayPicture[index]
            sound.id = Int16(index)
            
            DatabaseController.saveContext()
            
            isLike = true
        }
    }

    

}
