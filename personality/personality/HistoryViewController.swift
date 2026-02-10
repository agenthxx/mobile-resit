//
//  HistoryViewController.swift
//  personality
//
//  Created by BP-36-201-18 on 10/02/2026.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        history.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)

        let item = history[indexPath.row]

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        cell.textLabel?.text = "\(item.quizTitle) – \(item.result)"
        cell.detailTextLabel?.text = formatter.string(from: item.date)

        return cell
    }


    @IBOutlet weak var tableView: UITableView!

        var history: [QuizHistoryItem] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Quiz History"

            tableView.dataSource = self
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            history = QuizHistoryStore.load()
            tableView.reloadData()
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
