//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Akash G Krishnan on 20/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
//    var categories = [Categor]()
    let realm = try! Realm()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadCategories()

    }
    
//    func loadCategories(with request : NSFetchRequest<Categor> = Categor.fetchRequest()) {
//        do {
//            categories = try self.context.fetch(request)
//
//        } catch {
//            print("Error in loading")
//        }
//        tableView.reloadData()
//    }
    
    func saveCategory()  {
        do {
            try self.context.save()
        } catch {
            print("Error in encoding")
        }
        tableView.reloadData()
    }
    
    
    func saveCategoryWithRealm(category: Category)  {
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("Error in encoding")
        }
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! TodoListViewController
        let indexPath = tableView.indexPathForSelectedRow
        destinationVc.selectedCategory = categories[indexPath?.row ?? 0]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryItemCell", for: indexPath)
        
        let category : Categor = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count;
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action : UIAlertAction) in
            if textField.text != "" {
                
//                let category = Categor(context: self.context)
//                category.name = textField.text
                
                let newCategory : Category = Category()
                newCategory.name = textField.text!
                  
                self.saveCategoryWithRealm(category: newCategory)
//                self.categories.append(category)
//                self.saveCategory()
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField : UITextField) in
            alertTextField.placeholder = "Add new category item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
