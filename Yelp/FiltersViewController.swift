//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Vu Nguyen on 7/15/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate{
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdatedFilter filters: [String : AnyObject], didUpdatedCategories categories: [String])
}


class FiltersViewController: UIViewController,FilterCellDelegate,SearchMethodCellDelegate,DealCellDelegate {
    let categories = [["name" : "Afghan", "code": "afghani"],
                      ["name" : "African", "code": "african"],
                      ["name" : "American, New", "code": "newamerican"],
                      ["name" : "American, Traditional", "code": "tradamerican"],
                      ["name" : "Arabian", "code": "arabian"],
                      ["name" : "Argentine", "code": "argentine"],
                      ["name" : "Armenian", "code": "armenian"],
                      ["name" : "Asian Fusion", "code": "asianfusion"],
                      ["name" : "Asturian", "code": "asturian"],
                      ["name" : "Australian", "code": "australian"],
                      ["name" : "Austrian", "code": "austrian"],
                      ["name" : "Baguettes", "code": "baguettes"],
                      ["name" : "Bangladeshi", "code": "bangladeshi"],
                      ["name" : "Barbeque", "code": "bbq"],
                      ["name" : "Basque", "code": "basque"],
                      ["name" : "Bavarian", "code": "bavarian"],
                      ["name" : "Beer Garden", "code": "beergarden"],
                      ["name" : "Beer Hall", "code": "beerhall"],
                      ["name" : "Beisl", "code": "beisl"],
                      ["name" : "Belgian", "code": "belgian"],
                      ["name" : "Bistros", "code": "bistros"],
                      ["name" : "Black Sea", "code": "blacksea"],
                      ["name" : "Brasseries", "code": "brasseries"],
                      ["name" : "Brazilian", "code": "brazilian"],
                      ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                      ["name" : "British", "code": "british"],
                      ["name" : "Buffets", "code": "buffets"],
                      ["name" : "Bulgarian", "code": "bulgarian"],
                      ["name" : "Burgers", "code": "burgers"],
                      ["name" : "Burmese", "code": "burmese"],
                      ["name" : "Cafes", "code": "cafes"],
                      ["name" : "Cafeteria", "code": "cafeteria"],
                      ["name" : "Cajun/Creole", "code": "cajun"],
                      ["name" : "Cambodian", "code": "cambodian"],
                      ["name" : "Canadian", "code": "New)"],
                      ["name" : "Canteen", "code": "canteen"],
                      ["name" : "Caribbean", "code": "caribbean"],
                      ["name" : "Catalan", "code": "catalan"],
                      ["name" : "Chech", "code": "chech"],
                      ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                      ["name" : "Chicken Shop", "code": "chickenshop"],
                      ["name" : "Chicken Wings", "code": "chicken_wings"],
                      ["name" : "Chilean", "code": "chilean"],
                      ["name" : "Chinese", "code": "chinese"],
                      ["name" : "Comfort Food", "code": "comfortfood"],
                      ["name" : "Corsican", "code": "corsican"],
                      ["name" : "Creperies", "code": "creperies"],
                      ["name" : "Cuban", "code": "cuban"],
                      ["name" : "Curry Sausage", "code": "currysausage"],
                      ["name" : "Cypriot", "code": "cypriot"],
                      ["name" : "Czech", "code": "czech"],
                      ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                      ["name" : "Danish", "code": "danish"],
                      ["name" : "Delis", "code": "delis"],
                      ["name" : "Diners", "code": "diners"],
                      ["name" : "Dumplings", "code": "dumplings"],
                      ["name" : "Eastern European", "code": "eastern_european"],
                      ["name" : "Ethiopian", "code": "ethiopian"],
                      ["name" : "Fast Food", "code": "hotdogs"],
                      ["name" : "Filipino", "code": "filipino"],
                      ["name" : "Fish & Chips", "code": "fishnchips"],
                      ["name" : "Fondue", "code": "fondue"],
                      ["name" : "Food Court", "code": "food_court"],
                      ["name" : "Food Stands", "code": "foodstands"],
                      ["name" : "French", "code": "french"],
                      ["name" : "French Southwest", "code": "sud_ouest"],
                      ["name" : "Galician", "code": "galician"],
                      ["name" : "Gastropubs", "code": "gastropubs"],
                      ["name" : "Georgian", "code": "georgian"],
                      ["name" : "German", "code": "german"],
                      ["name" : "Giblets", "code": "giblets"],
                      ["name" : "Gluten-Free", "code": "gluten_free"],
                      ["name" : "Greek", "code": "greek"],
                      ["name" : "Halal", "code": "halal"],
                      ["name" : "Hawaiian", "code": "hawaiian"],
                      ["name" : "Heuriger", "code": "heuriger"],
                      ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                      ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                      ["name" : "Hot Dogs", "code": "hotdog"],
                      ["name" : "Hot Pot", "code": "hotpot"],
                      ["name" : "Hungarian", "code": "hungarian"],
                      ["name" : "Iberian", "code": "iberian"],
                      ["name" : "Indian", "code": "indpak"],
                      ["name" : "Indonesian", "code": "indonesian"],
                      ["name" : "International", "code": "international"],
                      ["name" : "Irish", "code": "irish"],
                      ["name" : "Island Pub", "code": "island_pub"],
                      ["name" : "Israeli", "code": "israeli"],
                      ["name" : "Italian", "code": "italian"],
                      ["name" : "Japanese", "code": "japanese"],
                      ["name" : "Jewish", "code": "jewish"],
                      ["name" : "Kebab", "code": "kebab"],
                      ["name" : "Korean", "code": "korean"],
                      ["name" : "Kosher", "code": "kosher"],
                      ["name" : "Kurdish", "code": "kurdish"],
                      ["name" : "Laos", "code": "laos"],
                      ["name" : "Laotian", "code": "laotian"],
                      ["name" : "Latin American", "code": "latin"],
                      ["name" : "Live/Raw Food", "code": "raw_food"],
                      ["name" : "Lyonnais", "code": "lyonnais"],
                      ["name" : "Malaysian", "code": "malaysian"],
                      ["name" : "Meatballs", "code": "meatballs"],
                      ["name" : "Mediterranean", "code": "mediterranean"],
                      ["name" : "Mexican", "code": "mexican"],
                      ["name" : "Middle Eastern", "code": "mideastern"],
                      ["name" : "Milk Bars", "code": "milkbars"],
                      ["name" : "Modern Australian", "code": "modern_australian"],
                      ["name" : "Modern European", "code": "modern_european"],
                      ["name" : "Mongolian", "code": "mongolian"],
                      ["name" : "Moroccan", "code": "moroccan"],
                      ["name" : "New Zealand", "code": "newzealand"],
                      ["name" : "Night Food", "code": "nightfood"],
                      ["name" : "Norcinerie", "code": "norcinerie"],
                      ["name" : "Open Sandwiches", "code": "opensandwiches"],
                      ["name" : "Oriental", "code": "oriental"],
                      ["name" : "Pakistani", "code": "pakistani"],
                      ["name" : "Parent Cafes", "code": "eltern_cafes"],
                      ["name" : "Parma", "code": "parma"],
                      ["name" : "Persian/Iranian", "code": "persian"],
                      ["name" : "Peruvian", "code": "peruvian"],
                      ["name" : "Pita", "code": "pita"],
                      ["name" : "Pizza", "code": "pizza"],
                      ["name" : "Polish", "code": "polish"],
                      ["name" : "Portuguese", "code": "portuguese"],
                      ["name" : "Potatoes", "code": "potatoes"],
                      ["name" : "Poutineries", "code": "poutineries"],
                      ["name" : "Pub Food", "code": "pubfood"],
                      ["name" : "Rice", "code": "riceshop"],
                      ["name" : "Romanian", "code": "romanian"],
                      ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                      ["name" : "Rumanian", "code": "rumanian"],
                      ["name" : "Russian", "code": "russian"],
                      ["name" : "Salad", "code": "salad"],
                      ["name" : "Sandwiches", "code": "sandwiches"],
                      ["name" : "Scandinavian", "code": "scandinavian"],
                      ["name" : "Scottish", "code": "scottish"],
                      ["name" : "Seafood", "code": "seafood"],
                      ["name" : "Serbo Croatian", "code": "serbocroatian"],
                      ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                      ["name" : "Singaporean", "code": "singaporean"],
                      ["name" : "Slovakian", "code": "slovakian"],
                      ["name" : "Soul Food", "code": "soulfood"],
                      ["name" : "Soup", "code": "soup"],
                      ["name" : "Southern", "code": "southern"],
                      ["name" : "Spanish", "code": "spanish"],
                      ["name" : "Steakhouses", "code": "steak"],
                      ["name" : "Sushi Bars", "code": "sushi"],
                      ["name" : "Swabian", "code": "swabian"],
                      ["name" : "Swedish", "code": "swedish"],
                      ["name" : "Swiss Food", "code": "swissfood"],
                      ["name" : "Tabernas", "code": "tabernas"],
                      ["name" : "Taiwanese", "code": "taiwanese"],
                      ["name" : "Tapas Bars", "code": "tapas"],
                      ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                      ["name" : "Tex-Mex", "code": "tex-mex"],
                      ["name" : "Thai", "code": "thai"],
                      ["name" : "Traditional Norwegian", "code": "norwegian"],
                      ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                      ["name" : "Trattorie", "code": "trattorie"],
                      ["name" : "Turkish", "code": "turkish"],
                      ["name" : "Ukrainian", "code": "ukrainian"],
                      ["name" : "Uzbek", "code": "uzbek"],
                      ["name" : "Vegan", "code": "vegan"],
                      ["name" : "Vegetarian", "code": "vegetarian"],
                      ["name" : "Venison", "code": "venison"],
                      ["name" : "Vietnamese", "code": "vietnamese"],
                      ["name" : "Wok", "code": "wok"],
                      ["name" : "Wraps", "code": "wraps"],
                      ["name" : "Yugoslav", "code": "yugoslav"]]
    
    var switchStates = [Int: Bool]()
    var searchMethod: Int?
    let distanceTypes = ["Auto", "0.3 mile", "1 mile", "5 mile", "20 mile"]
    var distanceIndex: Int?
    var distanceNumTypes: Int?
    var isDeal: Bool?
    var filters : [String : AnyObject] =
        [
            "method": Int(),
            "distance": Int(),
            "isDeal": Bool(),
        ]
    @IBOutlet weak var filtersTableView: UITableView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var numOfVisibleCells: Int!
    
    weak var delegate: FiltersViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        numOfVisibleCells = 5
        distanceNumTypes = 1
        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        
    
        if let states = defaults.dictionaryForKey("default_selected_filters") {
            filters = states
            searchMethod = filters["method"] as! Int
            isDeal = filters["isDeal"] as! Bool
            distanceIndex = filters["distance"] as! Int
        }
        
        if let data = defaults.objectForKey("default_selected_categories"){
            switchStates = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData) as! [Int : Bool]
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterCell(filterCell: FilterCell, didChangedValue value: Bool) {
        let ip = filtersTableView.indexPathForCell(filterCell)
        switchStates[(ip?.row)!] = value
        print("switch \(ip?.row) is changed to \(value)")
    }
    
    func searchMethodCell(searchMethodCell: SearchMethodCell, onUpdatedSelectedSeg indexSeg: Int) {
        searchMethod = indexSeg
        print("Method number \(searchMethod) is selected")
    }
    
    func dealCell(dealCell: DealCell, didUpdatedDealState dealState: Bool) {
        isDeal = dealState
        print("searching all offer deal business is \(isDeal)")
    }

    @IBAction func onChanged(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSeach(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        
        var categoriesSelected = [String]()
        
        for (row, isSelected) in switchStates{
            if isSelected {
                categoriesSelected.append(categories[row]["code"]!)
            }
        }
        
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(switchStates)
        defaults.setObject(data, forKey: "default_selected_categories")
        
        filters["method"] = self.searchMethod
        filters["isDeal"] = self.isDeal
        filters["distance"] = self.distanceIndex
        print("search method with categories: \(filters["method"]) and \(filters["isDeal"]) deal is saved")
        
        defaults.setValue(filters, forKey: "default_selected_filters")
        defaults.synchronize()
        delegate?.filtersViewController!(self, didUpdatedFilter: filters, didUpdatedCategories: categoriesSelected)
        //delegate?.filtersViewController!(self, didUpdatedFilter: categoriesSelected)
            
        
    }
}



extension FiltersViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Categories section
        if indexPath.section == 3
        {
        let categoryCell = self.filtersTableView.dequeueReusableCellWithIdentifier("FilterCell") as! FilterCell
            categoryCell.layer.borderWidth = 1
            categoryCell.layer.cornerRadius = 3
            categoryCell.layer.borderColor = UIColor.lightGrayColor().CGColor
        categoryCell.categoryLabel.text = self.categories[indexPath.row]["name"]
        categoryCell.categorySwitch.on = self.switchStates[indexPath.row] ?? false
        categoryCell.delegate = self
            let seeAllCell  = self.filtersTableView.dequeueReusableCellWithIdentifier("SeeAllCell") as! SeeAllCell
            if numOfVisibleCells != 5
            {
                return categoryCell
            }
            else
            {
                if indexPath.row == (numOfVisibleCells - 1) { return seeAllCell}
                else { return categoryCell }
            }
            
        }
        //Search Method Section
        else if indexPath.section == 1 {
            let MethodCell = self.filtersTableView.dequeueReusableCellWithIdentifier("SearchMethodCell") as! SearchMethodCell
            
            MethodCell.layer.borderWidth = 1
            MethodCell.layer.cornerRadius = 3
            MethodCell.layer.borderColor = UIColor.lightGrayColor().CGColor

            MethodCell.methodSegment.selectedSegmentIndex = searchMethod ?? 0
            MethodCell.delegate = self
            return MethodCell
        }
        //Distance Section
        else if indexPath.section == 2 {
            let distanceCell = self.filtersTableView.dequeueReusableCellWithIdentifier("DistanceCell") as! DistanceCell
            
            distanceCell.layer.borderWidth = 1
            distanceCell.layer.cornerRadius = 3
            distanceCell.layer.borderColor = UIColor.lightGrayColor().CGColor
            
            if distanceNumTypes == 1 {
                distanceCell.distanceLabel.text = distanceTypes[distanceIndex ?? 0]
                distanceCell.statusButton.image = UIImage(named: "ExpandButton")
            }
            else {
                for index in 0...4 {
                    if indexPath.row == index { distanceCell.distanceLabel.text = distanceTypes[index]}
                    if indexPath.row == distanceIndex { distanceCell.statusButton.image = UIImage(named: "Selected") }
                    else {distanceCell.statusButton.image = UIImage(named: "Unselected")}
                        
                }
            }
            return distanceCell
        }
        //Deal Section
        else {
            let dealCell = self.filtersTableView.dequeueReusableCellWithIdentifier("DealCell") as!DealCell
            
            dealCell.layer.borderWidth = 1
            dealCell.layer.cornerRadius = 3
            dealCell.layer.borderColor = UIColor.lightGrayColor().CGColor
            
            dealCell.dealSwitch.on = isDeal ?? false
            dealCell.delegate = self
            return dealCell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return numOfVisibleCells
        }
        else if section == 2 {
            return distanceNumTypes ?? 1
        }
        else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        //if section == 0 { let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)) }
        //else {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: 50, height: 15))
        //label.font =  UIFont.fontWithSize(17.0)
        //label.font = UIFont.boldSystemFontOfSize(15.0)
        
        if section == 1  { label.text = "Method of Searching"}
        else if section == 2  { label.text = "Distance"}
        else if section == 3  { label.text = "Categories"}
        
        label.textColor = UIColor.darkGrayColor()
        label.sizeToFit()
        view.addSubview(label)
        //label.center = view.center
        label.textAlignment = NSTextAlignment.Center
        view.backgroundColor = UIColor.whiteColor()
            self.view.addSubview(view)
        //}
        if section == 0 { return view2 }
        else {return view}
    
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            
            if distanceNumTypes == 1 {
            distanceNumTypes = 5
                self.filtersTableView.reloadData() }
            else {
                self.distanceIndex = indexPath.row
                distanceNumTypes = 1
                self.filtersTableView.reloadData()
            }
        }
        if indexPath.section == 3 {
            if numOfVisibleCells == 5 {
            if indexPath.row == numOfVisibleCells - 1 {
                numOfVisibleCells = categories.count
                self.filtersTableView.reloadData()
                }
            }
        }
        
    }
}
