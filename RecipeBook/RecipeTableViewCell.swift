//
//  RecipeTableViewCell.swift
//  RecipeBook
//
//  Created by Andy on 4/29/19.
//  Copyright © 2019 Henry Chen. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    var recipe: RecipeDetail!
    
    func configureCell(recipe:RecipeDetail){
        recipeTitle.text = recipe.recipeName
    }
}
