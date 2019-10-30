//
//  ViewController.swift
//  CRUD
//
//  Created by Grace Njoroge on 30/10/2019.
//  Copyright © 2019 Grace. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
  //prepare the request of type NSFetchRequest for the entity
  let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  func createData() {
    
    //Refering to the container setup in AppDelegate
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    //creating a context from the container
    let managedContext = appDelegate.persistentContainer.viewContext
    
    //create an entity and new user records
    let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
    
    //adding data to the newly created record
    for i in 1...5 {
      let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
      user.setValue("TestUser \(i)", forKeyPath: "username")
      user.setValue("testuser\(i)@test.com", forKeyPath: "email")
      user.setValue("testuser\(i)", forKeyPath: "password")
    }
    
    //saving the values into Core Data
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  func retreiveData() {
    
    //Refering to the container setup in AppDelegate
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    //creating a context from the container
    let managedContext = appDelegate.persistentContainer.viewContext
    
    //if required use predicate to filter data
//    fetchRequest.fetchLimit = 1
//    fetchRequest.predicate = NSPredicate(format: "username = %@", "TestUser")
//    fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    
    do {
      let result = try managedContext.fetch(fetchRequest)
      for data in result as! [NSManagedObject] {
        print(data.value(forKey: "username") as! String )
      }
    } catch {
      print("Failed")
    }
  }
  
  func updateData() {

    //Refering to the container setup in AppDelegate
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    //creating a context from the container
    let managedContext = appDelegate.persistentContainer.viewContext
    
    fetchRequest.predicate = NSPredicate(format: "username = %@", "TestUser")
    
    do {
      let test = try managedContext.fetch(fetchRequest)
      
      let objectUpdate = test[0] as! NSManagedObject
      objectUpdate.setValue("newName", forKey: "username")
      objectUpdate.setValue("newEmail", forKey: "email")
      objectUpdate.setValue("newPassword", forKey: "password")
      
      do {
        try managedContext.save()
      } catch {
        print(error)
      }
    } catch  {
      print(error)
    }

  }
  
  func deleteData() {
    
    //Refering to the container setup in AppDelegate
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    //creating a context from the container
    let managedContext = appDelegate.persistentContainer.viewContext
    
    fetchRequest.predicate = NSPredicate(format: "username = %@", "TestUser")
    
    do {
      let test = try managedContext.fetch(fetchRequest)
      
      let objectToDelete = test[0] as! NSManagedObject
      managedContext.delete(objectToDelete)
      
      do {
        try managedContext.save()
      } catch {
        print(error)
      }
    } catch {
      print(error)
    }
    
  }
  


}

