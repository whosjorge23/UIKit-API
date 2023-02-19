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
    let buttonTitles = ["NSFW", "Religious", "Political", "Racist", "Sexist", "Clean"]
    var buttons = [UIButton]()
    var endpoint = "https://sv443.net/jokeapi/v2/joke/Any?blacklistFlags=nsfw,religious,political,racist,sexist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Press the button to have a Joke"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        for i in 0..<buttonTitles.count {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitles[i], for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            buttons.append(button)
        }
        
        button.setTitle("Press Here", for: .normal)
        button.addTarget(self, action: #selector(fetchJoke), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttons[0].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttons[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttons[1].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttons[1].leadingAnchor.constraint(equalTo: buttons[0].trailingAnchor, constant: 10),
            buttons[2].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttons[2].leadingAnchor.constraint(equalTo: buttons[1].trailingAnchor, constant: 10),
            buttons[3].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttons[3].leadingAnchor.constraint(equalTo: buttons[2].trailingAnchor, constant: 10),
            buttons[4].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttons[4].leadingAnchor.constraint(equalTo: buttons[3].trailingAnchor, constant: 10),
            buttons[5].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttons[5].leadingAnchor.constraint(equalTo: buttons[4].trailingAnchor, constant: 10),
                        
        ])
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else {
            return
        }
        
        // Controllo se il pulsante è già selezionato
            if sender.tintColor == .red {
                sender.tintColor = .systemBlue
                return
            }
            
            // Impostiamo il nuovo colore rosso
            sender.tintColor = .red
        
        switch index {
        case 0:
            endpoint = "https://sv443.net/jokeapi/v2/joke/Any?blacklistFlags=religious,political,racist,sexist"
        case 1:
            endpoint = "https://sv443.net/jokeapi/v2/joke/Any?blacklistFlags=nsfw,political,racist,sexist"
        case 2:
            endpoint =  "https://sv443.net/jokeapi/v2/joke/Any?blacklistFlags=religious,nsfw,racist,sexist"
        case 3:
            endpoint = "https://sv443.net/jokeapi/v2/joke/Any?blacklistFlags=religious,political,nsfw,sexist"
        case 4:
            endpoint = "https://sv443.net/jokeapi/v2/joke/Any?blacklistFlags=religious,political,racist,nsfw"
        case 5:
            endpoint = "https://sv443.net/jokeapi/v2/joke/Any?blacklistFlags=nsfw,religious,political,racist,sexist"
        default:
            break
        }
        print(index)
    }
    
    @objc func fetchJoke() {
        let url = URL(string: endpoint)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let joke = try decoder.decode(Joke.self, from: data)
                    DispatchQueue.main.async {
                        if joke.type == "single" {
                            self.label.text = (joke.joke ?? "")
                        }else{
                            self.label.text = (joke.setup ?? "") + "\n" + (joke.delivery ?? "")
                        }
                        
                    }
                    print(joke)
                } catch {
                    print("Error while decoding JSON: \(error)")
                }
            } else {
                print("No data was returned or an error occurred.")
            }
        }
        task.resume()
    }

}

