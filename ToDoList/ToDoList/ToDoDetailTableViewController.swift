//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by BP-36-201-18 on 12/02/2026.
//

import MessageUI
import UIKit

class ToDoDetailTableViewController: UITableViewController,MFMailComposeViewControllerDelegate {
    
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    var toDo: ToDo?

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var isCompleteButton: UIButton!

    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var dueDateDatePicker: UIDatePicker!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var reminderSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDueDate: Date

        if let toDo = toDo {
            navigationItem.title = "To-Do"
            titleTextField.text = toDo.title
            isCompleteButton.isSelected = toDo.isComplete
            currentDueDate = toDo.dueDate
            notesTextView.text = toDo.notes

            // ✅ set category segmented control
            if let index = ToDoCategory.allCases.firstIndex(of: toDo.category) {
                categorySegmentedControl.selectedSegmentIndex = index
            }
        } else {
            navigationItem.title = "New To-Do"
            currentDueDate = Date().addingTimeInterval(24 * 60 * 60)
            categorySegmentedControl.selectedSegmentIndex = 0 // default to Work
        }

        dueDateDatePicker.date = currentDueDate
        updateDueDateLabel(date: dueDateDatePicker.date)
        updateSaveButtonState()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func updateSaveButtonState() {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateDueDateLabel(date: dueDateDatePicker.date)
        updateSaveButtonState()
    }
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func isCompletedButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard segue.identifier == "saveUnwind" else { return }
        let wantsReminder = reminderSwitch.isOn
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDateDatePicker.date
        let notes = notesTextView.text
        let selectedCategoryIndex = categorySegmentedControl.selectedSegmentIndex
        let category = ToDoCategory.allCases[selectedCategoryIndex]

        if toDo != nil {
            toDo?.title = title
            toDo?.isComplete = isComplete
            toDo?.dueDate = dueDate
            toDo?.notes = notes
            toDo?.category = category
        } else {
            toDo = ToDo(title: title,
                        isComplete: isComplete,
                        dueDate: dueDate,
                        notes: notes,
                        category: category)
        }
        if reminderSwitch.isOn {
            scheduleNotification(for: toDo!)
        }
    }

    func scheduleNotification(for toDo: ToDo) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Your to-do '\(toDo.title)' is due now!"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
                                                          from: toDo.dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: toDo.id.uuidString,
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Notification error: \(error)")
            }
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true)
    }

    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        guard MFMailComposeViewController.canSendMail() else {
            // Optional: show alert if Mail isn’t set up
            let alert = UIAlertController(title: "Mail Not Available",
                                          message: "Please configure Mail to send emails.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self

        if let toDo = toDo {
            mailComposer.setSubject("Sharing To-Do: \(toDo.title)")
            let body = """
            Title: \(toDo.title)
            Due Date: \(toDo.dueDate)
            Notes: \(toDo.notes ?? "None")
            Completed: \(toDo.isComplete ? "Yes" : "No")
            """
            mailComposer.setMessageBody(body, isHTML: false)
        }

        present(mailComposer, animated: true)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView,
                            estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return 216
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath == dateLabelIndexPath {
            isDatePickerHidden.toggle()
            updateDueDateLabel(date: dueDateDatePicker.date)

            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
