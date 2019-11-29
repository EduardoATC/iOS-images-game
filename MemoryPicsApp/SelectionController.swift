//
//  SelectionController.swift
//  MemoryPicsApp
//
//  Created by Eduardo Antonio Terrero Cabrera on 28/10/2019.
//  Copyright © 2019 Eduardo Antonio Terrero Cabrera. All rights reserved.
//

import UIKit
//Variables
let memoryGame:MemoryGame = MemoryGame ()
let images:[UIImage] = memoryGame.images


class SelectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    //Variables
    var imagesInGame = [Int]()
    var cellsSelected = [Int]()
    var clicksDone = 0
    
    //Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selection_1: UIImageView!
    @IBOutlet weak var selection_2: UIImageView!
    @IBOutlet weak var selection_3: UIImageView!
    @IBOutlet weak var resultText: UILabel!
    
    
    @IBAction func resetButton(_ sender: Any) {
              
              dismiss(animated: true, completion: nil)
          }
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
         
         resultText.isHidden = true
         collectionView.delegate = self
         collectionView.dataSource = self
     }
    
   //Numbers of elements shown in the collectionView.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    //CollectionView's cell configuration.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.backgroundColor = .clear
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        //ClickListener added to cells.
              cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DoWhenACellIsClicked(_:))))
            
            cell.cellImageView.image = images[indexPath.row]
            return cell
    }
    
    
//This fuction is triggered when a cell is clicked. It appends the position of the cell clicked in the array cellsSelected. Also the fuctions showSelection and evaluateSlections are triggered.
    @objc func DoWhenACellIsClicked(_ sender: UITapGestureRecognizer) {

              let location = sender.location(in: self.collectionView)
              let indexPath = self.collectionView.indexPathForItem(at: location)

              if let index = indexPath {
                cellsSelected.append(index[1])
              }
       
            showSelection()
            evaluateSelections()
           }
    
   
 
    
    //Shows the images selected by the user when a cell is clicked.
    func showSelection() {
        
        switch clicksDone {
            case 0:
                selection_1.image = images[cellsSelected[clicksDone]]
                clicksDone += 1
                
            case 1:
                selection_2.image = images[cellsSelected[clicksDone]]
                clicksDone += 1
                
            case 2:
                selection_3.image = images[cellsSelected[clicksDone]]
                clicksDone += 1
               
            default:
                clicksDone += 1
            }
        }
    
    //When a user has selected the images this function checks if the answer is correct.
    func evaluateSelections () {
        if clicksDone == 3 {
            
            for i in 0...imagesInGame.count - 1{
                
                
                if imagesInGame[i] == cellsSelected [i]
                    {
                        resultText.isHidden = false
                        resultText.text = "Correct!"
                    }
                else {
                    
                    resultText.isHidden = false
                    resultText.text = "Wrong!"
                }
            }
        }
    }
    
    //Resets the view.
    override func viewDidDisappear(_ animated: Bool){
        imagesInGame = [Int]()
        cellsSelected = [Int]()
        
        
    }
}
