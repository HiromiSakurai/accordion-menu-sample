//
//  ViewController.swift
//  accordion-menu-sample
//
//  Created by 櫻井寛海 on 2018/07/25.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!

    private var sections: [Section] = [Section(title: "Gender",
                                               values: [("MEN", false),
                                                        ("WOMEN", false),
                                                        ("KIDS", false)],
                                               expanded: true),
                                       Section(title: "Size",
                                               values: [("X", false),
                                                        ("M", false),
                                                        ("L", false)],
                                               expanded: true),
                                       Section(title: "Clothes",
                                               values: [("T-Shirt", false),
                                                        ("Bottom", false),
                                                        ("Shoes", false)],
                                               expanded: true)]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    private func setupTableView() {
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension MenuViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell

        cell.titleLabel.text = sections[indexPath.section].values[indexPath.row].title

        if self.sections[indexPath.section].values[indexPath.row].checked {
            cell.checkBoxButton.setImage(checkedBoxImage, for: .normal)
        } else {
            cell.checkBoxButton.setImage(unCheckedBoxImage, for: .normal)
        }

        cell.tappedHandler = { [unowned self] in
            if self.sections[indexPath.section].values[indexPath.row].checked {
                cell.checkBoxButton.setImage(unCheckedBoxImage, for: .normal)
            } else {
                cell.checkBoxButton.setImage(checkedBoxImage, for: .normal)
            }
            self.sections[indexPath.section].values[indexPath.row].checked = !self.sections[indexPath.section].values[indexPath.row].checked
        }
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded {
            return 60
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView()
        headerView.config(title: sections[section].title, section: section) { [unowned self] section in
            self.sections[section].expanded = !self.sections[section].expanded
            self.menuTableView.beginUpdates()
            for i in 0 ..< self.sections[section].values.count {
                self.menuTableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
            }
            self.menuTableView.endUpdates()
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
