//
//  ViewController.swift
//  UIKit API
//
//  Created by Giorgio Giannotta on 07/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Press the button to have a Joke"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        button.setTitle("Press Here", for: .normal)
        button.addTarget(self, action: #selector(fetchJoke), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func fetchJoke() {
            let url = URL(string: "https://sv443.net/jokeapi/v2/joke/Any?blacklistFlags=nsfw,religious,political,racist,sexist")!
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let joke = json["joke"] as? String ?? ""
                        DispatchQueue.main.async {
                            self.label.text = joke
                        }
                    } catch {
                        print("Error while decoding JSON: \(error)")
                    }
                } else {
                    print("No data was returned or an error occured.")
                }
            }
            task.resume()
        }
}

