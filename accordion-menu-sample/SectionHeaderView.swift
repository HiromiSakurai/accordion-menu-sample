//
//  SectionHeaderView.swift
//  accordion-menu-sample
//
//  Created by 櫻井寛海 on 2018/07/25.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import UIKit

protocol SectionHeaderViewDelegate {
    func toggleSection(header: SectionHeaderView, section: Int)
}

class SectionHeaderView: UITableViewHeaderFooterView {

    var delegate: SectionHeaderViewDelegate?
    var section: Int?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelected)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(title: String, section: Int, delegate: SectionHeaderViewDelegate) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }

    @objc private func handleSelected(gestureRecognizer: UITapGestureRecognizer) {
        if let header = gestureRecognizer.view as? SectionHeaderView, let section = header.section {
            delegate?.toggleSection(header: self, section: section)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.textColor = .white
        contentView.backgroundColor = .orange
    }
}
