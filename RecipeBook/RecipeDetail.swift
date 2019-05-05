//
//  RecipeDetail.swift
//  RecipeBook
//
//  Created by user150412 on 4/28/19.
//  Copyright © 2019 Henry Chen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RecipeDetail {
    
  
    var imageURL: String = ""
    var recipeURL: String = ""
    var recipeName: String = ""
    var servings: Int = 0
    var pricePerServing: Double = 0.0
    var ingredientArray = [String]()
    var instructions: String = ""
    
    var recipeID: Int
    
    let headers: HTTPHeaders = ["X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                                "X-RapidAPI-Key": "67c16d0ef3msh751f723d2175025p1d44afjsn4e4283ff58ea"]
    
    init(recipeID: Int){
        self.recipeID = recipeID
    }
    func getRecipeInfo(completed: @escaping (Bool)->()){
        let infoURL = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(recipeID)/information"
        print("#############\(recipeID)")
        AF.request(infoURL, headers:headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let imageURL = json["image"].stringValue
                self.imageURL = imageURL
                let recipeURL = json["sourceURL"].stringValue
                self.recipeURL = recipeURL
                let recipeName = json["title"].stringValue
                self.recipeName = recipeName
                let servings = json["servings"].intValue
                self.servings = servings
                let pricePerServing = (json["pricePerServing"].doubleValue)/100
                self.pricePerServing = pricePerServing
                let numIngredients = json["extendedIngredients"].count
                for index in 0..<numIngredients{
                    let name = json["extendedIngredients"][index]["originalString"].stringValue
                    self.ingredientArray.append(name)
                                }
                let instructions = json["instructions"].stringValue
                self.instructions = instructions
                
                
                
            case .failure(let error):
                print("WAARNING WARRRNING WARRNING")
            }
             completed(true)
    
   
    
    
    
   
    
}
}
}
