//
//  ViewController.swift
//  MemoryPicsApp
//
//  Created by Eduardo Antonio Terrero Cabrera on 28/10/2019.
//  Copyright © 2019 Eduardo Antonio Terrero Cabrera. All rights reserved.
//


//                      COMENTARIOS AL FINAL


import UIKit

class ViewController: UIViewController {
    
    //Variables
    var memoryGame:MemoryGame = MemoryGame ()
    var imageHasChanged:Int = 0
    var timer = Timer()
    var lastRandomNumber:Int = -1
    var randomNumber = -1

    
    //Outlets
    
    @IBOutlet weak var TimedPicturedImageView: UIImageView!
   
    
    
    override func viewDidAppear(_ animated: Bool) {
    
        //The timer trigger the function showRandomImages() every 2 seconds.
     timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showRandomImages), userInfo: nil, repeats: true)
    }

    //This function chages the imageView's images. Get a random number then
    // use this number to select an image from the array of images in the
    //class MemoryGame using the number as an index. Trigger the segue.
    @objc func showRandomImages () {
       
        let randomNumberInGame:Int = getRandomNumber()
        memoryGame.imagesInGame.append(randomNumberInGame)
        TimedPicturedImageView.image = memoryGame.images[randomNumberInGame]
        imageHasChanged+=1
    
    //When the function has changed the image 3 times it perfoms a segue.
        if imageHasChanged >= 3 {
                timer.invalidate()
                imageHasChanged = 0
            
    // a 1 second delay between the last picture showed and the segue start.
            let seconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    
                    self.performSegue(withIdentifier: "startSegue", sender: self)
                }
            }
    }
        //it returns a random number not equal than the previous one
    func getRandomNumber () ->Int {
       
        repeat {
            randomNumber = Int.random(in: 0 ..< 9)
            
        } while lastRandomNumber == randomNumber
       
        lastRandomNumber = randomNumber
        return randomNumber
    }
    
    
    
  //Prepare the data to be send before the segue is performed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startSegue" {
        
            if let selectionController = segue.destination as? SelectionController {
                selectionController.imagesInGame = memoryGame.imagesInGame
            }
        }
    }
    //Reset the view when it disappears.
    override func viewDidDisappear(_ animated: Bool){
        TimedPicturedImageView.image = UIImage(named: "go")
        memoryGame = MemoryGame ()
    }

}

/*Para el desarollo se esta aplicación se ha utilizado en lenguaje de programación SWIFT
desarollado por la empresa Apple, inc. Swift es un lenguaje multiparadigma enfocado en el
desarollo de aplicaciones para dispositivios iOS y macOS. Junto a SWIFT se ha utilizado
 también, el entorno de desarollo Xcode, este contiene un conjunto de herramientas específicas, para el desarollo de aplicaciones para iOS, macOS, watchOS y tvOS.
 
 Aunque esta aplicación se podria haber desarollado utilizando el lenguaje pregramación
 objective C, se ha optado por SWIFT por su simplicidad y porque apple aconseja la utilización de este software para las nuevas aplicaciones, dado que objective C está destinado a ser sustituido por SWIFT.
 Xcode es un entorno de desarollo cuyo propósito es el desarollo de aplicaciones para profuctos de Apple, cuenta con muchas herramientas que facilitan el trabajo, como emulador, conexión directa a repositorios, creación de archivos/clases con código útil ya escrito (ahorrandonos de esta forma tiempo), en  definitiva utilizar otro entorno de desarollo: VScode,Android Studio, procesador de texto, sería una tontería y una pérdida de tiempo dado que no cuentan con ninguna de estas características.
 
 
 */

