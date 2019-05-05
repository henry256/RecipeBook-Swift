//
//  Recipes.swift
//  RecipeBook
//
//  Created by Andy on 4/28/19.
//  Copyright © 2019 Henry Chen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Recipes{
    struct recipeInfo{
        var id: Int
        var title: String
        var readyInMinutes: Int
        var imageURL: String
        
    }
    var recipeArray: [recipeInfo]=[]
    var searchInput: String
    //var id: Int
    
    init(searchInput: String){
        self.searchInput = searchInput
    }
    let baseURL = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query="
    let headers: HTTPHeaders = ["X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                                "X-RapidAPI-Key": "67c16d0ef3msh751f723d2175025p1d44afjsn4e4283ff58ea"]
   // let infoURL = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(String(id))/information"
    func getRecipes(completed: @escaping ()->()){
        AF.request(baseURL+searchInput, headers:headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for index in 0...30{
                    let id = json["results"][index]["id"].intValue
                    let title = json["results"][index]["title"].stringValue
                    let imageURL = json["results"][index]["image"].stringValue
                    let readyInMinutes = json["results"][index]["readyInMinutes"].intValue
                    self.recipeArray.append(recipeInfo(id: id, title: title, readyInMinutes: readyInMinutes, imageURL:imageURL))
                }
            
            case .failure(let error):
                print ("***********FAILED TO GET DATATTTTTAAAAAAAAAAAAAAA\(error.localizedDescription)")
            
        }
            completed()
}
        
    }
}
