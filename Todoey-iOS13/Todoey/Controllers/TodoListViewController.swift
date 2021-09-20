import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray : [Item] = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let dataFilePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
//        for fething from user defaults
//        if let items = defaults.array(forKey: "ToDoListItemArray") as? [Item] {
//            itemArray = items
//        }
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }

    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add Todo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Todo", style: .default) { (action : UIAlertAction) in
            if textField.text != "" {
//                self.itemArray.append(Item(title: textField.text!))
                
                let newItem = Item(context: self.context)
                newItem.title = textField.text
                newItem.isComplete = false
                
                self.itemArray.append(newItem)
                self.saveItems()
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField : UITextField) in
            alertTextField.placeholder = "Add new todo item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
//    func loadItems()  {
//          Load items with Info.plist
//        do {
//            if let data = try? Data(contentsOf: dataFilePath!){
//                let decoder = PropertyListDecoder()
//                itemArray = try decoder.decode([Item].self, from: data)
//            }
//        } catch {
//            print("Error while decoding")
//        }
//    }
    
    func loadItems()  {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            self.itemArray = try self.context.fetch(request)
        }
        catch {
            print("error fetching data from db")
        }
    }
    

    
    func saveItems()  {
//        let encoder = PropertyListEncoder()
        do {
//            let data = try encoder.encode(self.itemArray)
//            try data.write(to: self.dataFilePath!)
            try self.context.save()
        } catch {
            print("Error in encoding")
        }
    }
    
    // MARK: - data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isComplete ? .checkmark : .none

        return cell
    }
    
    // MARK: -  rows selected by the user
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isComplete =  !itemArray[indexPath.row].isComplete
        self.saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


