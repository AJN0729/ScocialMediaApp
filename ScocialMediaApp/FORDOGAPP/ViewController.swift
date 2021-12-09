//
//  ViewController.swift
//  ScocialMediaApp
//
//  Created by AMStudent on 12/7/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    @Published var DogBreed = [DogBreedData]()
    let apiURL =  "https://firebasestorage.googleapis.com/v0/b/dogapp-cd081.appspot.com/o/dogapp-cd081-default-rtdb-export.json?alt=media&token=51d201fd-50b0-420b-a4e6-fe040cd9b39f"
    
    init() {
        fetchDogBreedData()
    }
    
  
    
    
    
  
    func fetchDogBreedData() {
        guard let url = URL(string: apiURL) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let cleanData = data?.parseData(removeString: "null,") else { return }
            
            DispatchQueue.main.async {
                do{
                    let Breed = try
                JSONDecoder().decode([DogBreedData].self, from:
                        cleanData)
                    self.DogBreed = Breed
                } catch {
            
                    print("error msg:", error)
                }
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    
    @IBAction func onShareTapped() {
        let activityController = UIActivityViewController(activityItems: [textField.text!, #imageLiteral(resourceName: "Cosmos07")],
                                                          applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func searchBar() {
        ViewController2().fetchDogBreedData()
    }
    
    
}
    
extension Data {
    func parseData(removeString string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?
            .replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8)
        else { return nil }
        return data
        }
    }

