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
                                                        ("MEN", false),
                                                        ("MEN", false)],
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
        headerView.config(title: sections[section].title,
                          section: section,
                          delegate: self)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension MenuViewController: SectionHeaderViewDelegate {

    func toggleSection(header: SectionHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        menuTableView.beginUpdates()
        for i in 0 ..< sections[section].values.count {
            menuTableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        menuTableView.endUpdates()
    }
}

