//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking
import ZProgressHUD


class BusinessesViewController: UIViewController, FiltersViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business]?
    var queryString: String?
    var searchBar: UISearchBar!
    var searchCategories: [String]?
    var seartchFilters : [String : AnyObject] =
        [
            "method": Int(),
            "distance": Int(),
            "isDeal": Bool(),
        ]
    var searchMethod: YelpSortMode?
    var isDeal: Bool?
    var searchDistance: Int?

    weak var delegate: FilterCellDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        searchBar.delegate = self
        
        ZProgressHUD.show()
        if queryString != "" {
        
        Business.searchWithTerm(queryString ?? "", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            ZProgressHUD.dismiss()
            
        })
        }
    }
    
        func searchExecution(){
            
            Business.searchWithTerm(queryString ?? "", sort: searchMethod, categories: searchCategories, deals: isDeal, distance: searchDistance) { (businesses: [Business]!, error: NSError!) in
                self.businesses = businesses
                self.tableView.reloadData()
                ZProgressHUD.dismiss()
            }
        
 }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    let navigaVC = segue.destinationViewController as! UINavigationController
        let filterVC = navigaVC.topViewController as! FiltersViewController
        
        filterVC.delegate = self
  
     // Get the new view controller using segue.destinationViewController.
        
        
     // Pass the selected object to the new view controller.
     }
    func filtersViewController(filtersViewController: FiltersViewController, didUpdatedFilter filters: [String : AnyObject], didUpdatedCategories categories: [String]) {
    
        searchCategories = categories
        seartchFilters = filters
        isDeal = filters["isDeal"] as! Bool
        let distanceIndex = filters["distance"] as! Int
        let searchMethodIndex = filters["method"] as! Int
        if searchMethodIndex == 0 { searchMethod = YelpSortMode.BestMatched }
        else if searchMethodIndex == 1 { searchMethod = YelpSortMode.Distance }
        else { searchMethod = YelpSortMode.HighestRated }
        
        ZProgressHUD.show()
        //if let categoriesList = searchFilters["categories"] as? [String] {
        
        for string in searchCategories! { print("Search Filtes: " + string + "is Deal: \(isDeal) \n + Method: \(searchMethodIndex) \n Distance: \(distanceIndex)") }
        if distanceIndex == 0 { searchDistance = nil}
        else if distanceIndex == 1 { searchDistance = 483 } // 0.3(mile) * 1609(meter/mile) = 483(meter)
        else if distanceIndex == 2 { searchDistance = 1609 }// 1 mile
        else if distanceIndex == 3 { searchDistance = 8047 }// 5 mile
        else {searchDistance = 32187} // 20 mile
        self.searchExecution()
        
//        Business.searchWithTerm(queryString ?? "", sort: searchMethod, categories: searchCategories, deals: isDeal) { (businesses: [Business]!, error: NSError!) in
//            self.businesses = businesses
//            self.tableView.reloadData()
//            ZProgressHUD.dismiss()
//        
//        }
    }
    
    
}

extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as! BusinessCell
        
        cell.business = businesses![indexPath.row]
        return cell  
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        queryString = searchBar.text
        self.searchExecution()
        searchBar.endEditing(true)
    }
    
}

extension BusinessesViewController:  UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text != nil{
        self.queryString = searchBar.text
        }
        else {
            self.queryString = nil
        }
        ZProgressHUD.show()
        
        self.searchExecution()
        
//        Business.searchWithTerm(queryString ?? "", sort: searchMethod, categories: searchCategories, deals: isDeal) { (businesses: [Business]!, error: NSError!) in
//            self.businesses = businesses
//            self.tableView.reloadData()
//            ZProgressHUD.dismiss()
//        }
        
        //print("search Term " + (self.queryString ?? "")! + "with filter ")
        
        self.searchBar.endEditing(true)
    }
}