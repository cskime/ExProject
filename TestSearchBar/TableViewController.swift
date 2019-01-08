//
//  TableViewController.swift
//  TestSearchBar
//
//  Created by chamsol kim on 07/01/2019.
//  Copyright © 2019 chamsol kim. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var search: UISearchBar!
    let data1 = ["가나다", "12349758"]
    let data2 = ["라마바", "25274830"]
    let data3 = ["사아자", "25828923"]
    
    var dataset = [NSArray]()
    var searchedData: [NSArray]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        search.delegate = self
        search.placeholder = "검색"
        
        dataset.append(data1 as NSArray)
        dataset.append(data2 as NSArray)
        dataset.append(data3 as NSArray)
        searchedData = dataset
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchedData.count   // 검색하면서 테이블이 변경되므로 검색된 데이터의 개수만큼 만들어야한다. 처음에 원본 배열에서 복사되니까 문제없음
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = "\(searchedData[row][0]) / \(searchedData[row][1])"
        return cell
    }
}

extension TableViewController: UISearchBarDelegate {
    // 검색창 입력할 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedData = searchText.isEmpty ? dataset : dataset.filter({ (array) -> Bool in
            var isFind = [Bool]()
            for object in array {
                let data = object as! String
                isFind.append(data.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil)
            }
            
            let find = isFind.reduce(false, { (first, second) -> Bool in
                return first || second
            })
            return find
        })
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.search.showsCancelButton = true
    }
    
    // 취소버튼 누르면
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.search.showsCancelButton = false       // 취소버튼 없애기
        self.search.text = ""                       // 입력값 초기화
        self.search.resignFirstResponder()          // 키보드 내림
    }
}
