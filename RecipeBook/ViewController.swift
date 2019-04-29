//
//  ViewController.swift
//  RecipeBook
//
//  Created by user150412 on 4/28/19.
//  Copyright © 2019 Henry Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var userInput: UITextField!
    
    
    var recipes = Recipes(searchInput: "european")
    var inputString = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        recipes.getRecipes {
            self.tableView.reloadData()
        }
    }
    
    func searchUserInput(){
        self.inputString = userInput.text!
        
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        inputString = userInput.text ?? "anything"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pop" {
            let destination = segue.destination as! RecipeDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow!
            print("%%%%%%%%%%%%%\(recipes.recipeArray[selectedIndex.row])")
            destination.recipe = recipes.recipeArray[selectedIndex.row]
            
        }
        if segue.identifier == "searchPressed"{
            let destination = segue.destination as! RecipeSearchResultsViewController
            destination.userInputString = inputString
    
    

}
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.recipeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        cell.textLabel?.text = recipes.recipeArray[indexPath.row].title
        return cell
    }
}
        
    
    




