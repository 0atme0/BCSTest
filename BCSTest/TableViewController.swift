//
//  TableViewController.swift
//  BCSTest
//
//  Created by Andrey Ildyakov on 16.07.17.
//  Copyright © 2017 Andrey Ildyakov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {

    let load = loadData()
    var newsDataSourceDefault: [News] = []
    var newsDataSource: [News] = []

    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect.init(x: 0, y: 0, width: 440, height: 40))
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    @IBAction func cancelAction(_ sender: Any) {
       self.navigationItem.titleView = nil
        cancelButton.isEnabled = false
        self.newsDataSource = self.newsDataSourceDefault
        tableView.reloadData()
    }
    
    @IBAction func searchAction(_ sender: Any) {
        self.cancelButton.isEnabled = true
        self.searchBar.placeholder = "Search for Places"
        self.navigationItem.titleView = searchBar // or use self.navigationcontroller.topItem?.titleView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        cancelButton.isEnabled = false
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")

        
        load.getList(
            completion: {newsArray in
                self.newsDataSourceDefault = newsArray
                self.newsDataSource = self.newsDataSourceDefault

                self.tableView.reloadData()
        })
        

//        print(array)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsDataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        cell.configCell(news: newsDataSource[indexPath.row])

        return cell
    }

 
//MARK: SearchBar delegate
    func searchBar(_ searchBar: UISearchBar,
                            textDidChange searchText: String){
        if !searchText.isEmpty {
            newsDataSource = []
            tableView.reloadData()
        }
        if searchText.characters.count > 2 {
            load.search(text: searchText, completion: { newsArray in
                    self.newsDataSource = newsArray
                    self.tableView.reloadData()
            })
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
