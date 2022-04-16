//
//  CombineTableViewController.swift
//  Combine Demo
//
//  Created by Ananthamoorthy Haniman on 2022-04-16.
//

import UIKit
import Combine

class CustomTableViewCell: UITableViewCell{
    
    
}

class CombineTableViewController: ViewController {
    
    private var observer: AnyCancellable?
    private var models = [String]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "CustomCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        
        observer = TableApiCaller.shared.fetchData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("done")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { data in
                print(data)
                self.models = data
                self.tableView.reloadData()
            })
        
    }
    
    
    
}



extension CombineTableViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? UITableViewCell else {
            fatalError()
        }
        cell.textLabel?.text = models[indexPath.row]
        
        return cell
    }
    
    
    
    
    
    
    
}
