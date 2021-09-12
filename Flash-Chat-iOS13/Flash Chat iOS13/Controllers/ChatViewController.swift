import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        title = K.appName
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier:  K.cellIdentifier)
        
        loadMessages()
        
    }
    
    func loadMessages() {
        
        self.db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (snapshot : QuerySnapshot?,error :  Error?) in
            
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let snapshotDocuments = snapshot?.documents {
                    self.messages = []
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String,
                           let body = data[K.FStore.bodyField] as? String {
                            self.messages.append(Message(sender: sender, body: body))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,
           let userEmail = Auth.auth().currentUser?.email {
            
            
            
            db.collection(K.FStore.collectionName).addDocument(
                data: [
                    K.FStore.senderField  : userEmail,
                    K.FStore.bodyField: messageBody,
                    K.FStore.dateField : Date().timeIntervalSince1970
                ]) {
                (error) in
                if let e = error {
                    print(e.localizedDescription)
                } else{
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    
                }
            }
        }
        
        
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}


extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message : Message = messages[indexPath.row]
        
        let cell : MessageCell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        if  message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
        }
        
        
        
        
        cell.label?.text = message.body
        return cell
    }
}
