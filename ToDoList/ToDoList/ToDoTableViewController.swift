//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by BP-36-201-18 on 12/02/2026.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var toDos: [ToDo] = []
    var filteredToDos: [ToDo] = []
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        if let savedToDos = ToDo.loadToDos() {
            toDos = savedToDos
        }
        else {
            toDos = ToDo.loadSampleToDos()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        navigationItem.leftBarButtonItem = editButtonItem
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filteredToDos = toDos.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
        }
    }

    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            let category = ToDoCategory.allCases[indexPath.section]
            var categoryItems = toDos.filter { $0.category == category }
            var toDo = categoryItems[indexPath.row]

            // Toggle completion
            toDo.isComplete.toggle()

            // Update in master list
            if let index = toDos.firstIndex(where: { $0.id == toDo.id }) {
                toDos[index] = toDo
            }

            ToDo.saveToDos(toDos)
            tableView.reloadData()   // reload whole table to avoid section mismatch
        }
    }
    
    @IBSegueAction func editToDo_sender(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        let detailController = ToDoDetailTableViewController(coder: coder)

        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return detailController
        }

        tableView.deselectRow(at: indexPath, animated: true)

        let category = ToDoCategory.allCases[indexPath.section]
        let items = isSearching ? filteredToDos : toDos
        let categoryItems = items.filter { $0.category == category }
        let toDo = categoryItems[indexPath.row]

        detailController?.toDo = toDo
        return detailController
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ToDoCategory.allCases.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ToDoCategory.allCases[section].rawValue
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = ToDoCategory.allCases[section]
        let items = isSearching ? filteredToDos : toDos
        return items.filter { $0.category == category }.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath) as! ToDoCell
        cell.delegate = self

        let category = ToDoCategory.allCases[indexPath.section]
        let items = isSearching ? filteredToDos : toDos
        let categoryItems = items.filter { $0.category == category }
        let toDo = categoryItems[indexPath.row]

        cell.titleOfTodo?.text = toDo.title
        cell.isCompletedButton.isSelected = toDo.isComplete

        // Highlight overdue/upcoming
        let now = Date()
        if !toDo.isComplete {
            if toDo.dueDate < now {
                // Overdue → red text
                cell.titleOfTodo?.textColor = .systemRed
            } else if Calendar.current.isDateInToday(toDo.dueDate) {
                // Due today → orange text
                cell.titleOfTodo?.textColor = .systemOrange
            } else {
                // Upcoming → default
                cell.titleOfTodo?.textColor = .label
            }
        } else {
            // Completed → gray text
            cell.titleOfTodo?.textColor = .systemGray
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = ToDoCategory.allCases[indexPath.section]
            let categoryItems = toDos.filter { $0.category == category }
            let toDo = categoryItems[indexPath.row]

            if let index = toDos.firstIndex(where: { $0.id == toDo.id }) {
                toDos.remove(at: index)
            }

            ToDo.saveToDos(toDos)
            tableView.reloadData()   // reload whole table
        }
    }

    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! ToDoDetailTableViewController

        if let toDo = sourceViewController.toDo {
            if let indexOfExistingToDo = toDos.firstIndex(of: toDo) {
                toDos[indexOfExistingToDo] = toDo
            } else {
                toDos.append(toDo)
            }
        }
        ToDo.saveToDos(toDos)
        tableView.reloadData()   // reload whole table
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
