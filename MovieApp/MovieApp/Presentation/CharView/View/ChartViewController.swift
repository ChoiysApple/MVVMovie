//
//  ChartViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ChartViewController: UIViewController {
    
    let viewModel = ChartViewModel()
    let disposeBag = DisposeBag()
    
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor(named: Colors.background)
        $0.register(ChartTableViewCell.self, forCellReuseIdentifier: identifiers.chart_table_cell)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestData()
        self.title = "Charts"
        self.view.backgroundColor = UIColor(named: Colors.background)
        
        
        //MARK: Draw UI
        tableView.backgroundColor = UIColor(named: Colors.background)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }

        //MARK: Data Binding
        viewModel.movieFrontObservable
            .debug()
            .bind(to: tableView.rx.items(cellIdentifier: identifiers.chart_table_cell, cellType: ChartTableViewCell.self)) { index, movie, cell in
                cell.setData(rank: index, movie: movie)
            }
            .disposed(by: disposeBag)
        
    }
    
}

