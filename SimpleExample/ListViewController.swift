//
//  ListViewController.swift
//  SimpleExample
//
//  Created by Kam Hei Siu on 1/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let disposeBag = DisposeBag()
    
    let cellIdentifier = "CellIdentifier"
    var data = Observable.just(names)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCells()
        setupCellTapping()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor.Custom.orange
    }
    
    private func setupCells() {
        data.bind(to: tableView
            .rx
            .items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)) {
            row, name, cell in
            cell.textLabel?.text = name
        }.addDisposableTo(disposeBag)
    }
    
    private func setupCellTapping() {
        tableView
            .rx
            .modelSelected(String.self)
            .subscribe(onNext: {
                [unowned self] name in
                
                if let indexPath = self.tableView.indexPathForSelectedRow, let selectedCell = self.tableView.cellForRow(at: indexPath) {
                    selectedCell.contentView.backgroundColor = .orange
                    self.tableView.deselectRow(at: indexPath, animated: true)
                }
                
            })
            .addDisposableTo(disposeBag)
    }

}
