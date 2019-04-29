//
//  RecipeSearchResultsViewController.swift
//  RecipeBook
//
//  Created by Andy on 4/29/19.
//  Copyright © 2019 Henry Chen. All rights reserved.
//

import UIKit

class RecipeSearchResultsViewController: UIViewController {
    
   
    @IBOutlet weak var tableView: UITableView!
    var userInputString = ""
    var recipes = Recipes(searchInput: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipes.searchInput = userInputString
        tableView.dataSource = self
        tableView.delegate = self
        recipes.getRecipes {
            self.tableView.reloadData()
        }
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchResultClicked" {
            let destination = segue.destination as! RecipeDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow!
            print("%%%%%%%%%%%%%\(recipes.recipeArray[selectedIndex.row])")
            destination.recipe = recipes.recipeArray[selectedIndex.row]}
    }
}

    
extension RecipeSearchResultsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.recipeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.textLabel?.text = recipes.recipeArray[indexPath.row].title
        return cell
}
}

