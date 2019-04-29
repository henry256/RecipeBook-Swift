//
//  RecipeDetailViewController.swift
//  RecipeBook
//
//  Created by Andy on 4/29/19.
//  Copyright © 2019 Henry Chen. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var servingsLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var ingredientsTV: UITextView!
    
    @IBOutlet weak var instructionsTV: UITextView!
    
   // var recipeInfo = RecipeDetail()
    var recipe = Recipes.recipeInfo(id: 0, title: "", readyInMinutes: 0, imageURL: "")
    var ingredientString = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var recipeInfo = RecipeDetail(recipeID: recipe.id)
        recipeInfo.getRecipeInfo{ success in
            if success{
                self.recipeName.text = recipeInfo.recipeName
                self.servingsLabel.text = "Servings:" + String(recipeInfo.servings)
                self.priceLabel.text = "Price Per Serving:" + String(recipeInfo.pricePerServing)
                for index in 0..<recipeInfo.ingredientArray.count{
                    self.ingredientString = self.ingredientString + " •"+(recipeInfo.ingredientArray[index])
                }
                self.ingredientsTV.text = self.ingredientString
                self.instructionsTV.text = recipeInfo.instructions
                
                
                
                let ImageURL = URL(string: recipeInfo.imageURL)!
                
                let session = URLSession(configuration: .default)
                self.recipeImage.image=UIImage(named: "food")
                
                
                let url = URL(string: recipeInfo.imageURL)
               
               self.recipeImage.kf.setImage(with: url)
                
                let downloadPicTask = session.dataTask(with: ImageURL) { (data, response, error) in
                    
                    if let e = error {
                        print("Error downloading food picture: \(e)")
                    } else {
                        
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded food picture with response code \(res.statusCode)")
                            if let imageData = data {
                               
                                let image = UIImage(data: imageData)
                                self.recipeImage.image=UIImage(named: "food")
                              
                            } else {
                                print("Couldn't get image: Image is nil")
                                self.recipeImage.image=UIImage(named: "food")
                            }
                        } else {
                            print("Couldn't get response code for some reason")
                        }
                    }
                }            }else{
                print("error")
            }
        }
        
        
        
        // Do any additional setup after loading the view.
        
    }
}
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

