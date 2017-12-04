//
//  ViewController.swift
//  TinderHire
//
//  Created by Mauricio Chirino on 4/12/17.
//  Copyright © 2017 Mauricio Chirino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var thumbsLabel: UILabel!
    
    var rotationRatio: CGFloat!
    let employees = [
        employeeCV(name: "Clara Smith", skill: "Django", sex: "F"),
        employeeCV(name: "John Harper", skill: "Python", sex: "M"),
        employeeCV(name: "Sagar Shah", skill: "Django", sex: "M"),
        employeeCV(name: "Bob Thomas", skill: "React", sex: "M"),
        employeeCV(name: "Sophie Laura", skill: "React", sex: "F"),
        employeeCV(name: "Sammie Lopez", skill: "Django", sex: "F"),
        employeeCV(name: "Connie Jones", skill: "Django", sex: "F"),
        employeeCV(name: "Camille Rowe", skill: "Django", sex: "F"),
        employeeCV(name: "Joana Silver", skill: "Python", sex: "F"),
        employeeCV(name: "Sasha Doe", skill: "Django", sex: "F"),
        employeeCV(name: "Gaby Simone", skill: "React", sex: "F"),
        employeeCV(name: "Chloe Isabella", skill: "React", sex: "F"),
        employeeCV(name: "George Stanley", skill: "Django", sex: "M"),
        employeeCV(name: "Dominic Hope", skill: "Django", sex: "M"),
        employeeCV(name: "Sandra Bonhomme", skill: "Django", sex: "F"),
        employeeCV(name: "Sophie Gerbault", skill: "React", sex: "F"),
        employeeCV(name: "Sarah Seemore", skill: "React", sex: "F"),
        employeeCV(name: "Rachel Green", skill: "Django", sex: "F"),
        employeeCV(name: "Josephine Taylor", skill: "Django", sex: "F"),
        employeeCV(name: "Jay Jiang", skill: "Django", sex: "M"),
        employeeCV(name: "Hunter Dickson", skill: "React", sex: "M"),
        employeeCV(name: "Sam Gupta", skill: "React", sex: "M"),
        employeeCV(name: "Tom Brady", skill: "Django", sex: "M"),
        employeeCV(name: "Taylor Thompson", skill: "Django", sex: "F"),
        employeeCV(name: "Tatianna Marshall", skill: "Django", sex: "F"),
        employeeCV(name: "Eric Street", skill: "Python", sex: "M"),
        employeeCV(name: "Marine Simon", skill: "Python", sex: "F"),
        employeeCV(name: "Ronald Duck", skill: "Pytho", sex: "M"),
        employeeCV(name: "Jennifer Lopez", skill: "Python", sex: "F")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomEmployee()
        rotationRatio = (view.frame.width / 2) / 0.3925
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else {
            return print("Something went wrong with the gesture")
        }
        let pointsMoved = sender.translation(in: view)
        let scale = min(100/abs(pointsMoved.x), 1)
        card.center = CGPoint(x: view.center.x + pointsMoved.x, y: view.center.y + pointsMoved.y)
        card.transform = CGAffineTransform(rotationAngle: pointsMoved.x / rotationRatio).scaledBy(x: scale, y: scale)
        thumbsLabel.text = pointsMoved.x > 0 ? "👍🏽" : "👎🏽"
        thumbsLabel.alpha = abs(pointsMoved.x) / view.center.x

        if sender.state == .ended {
            
            if card.center.x < 60 {
                removeCardFromScreen(pickedCard: false, card: card)
                return
            } else if card.center.x > view.frame.width - 60 {
                removeCardFromScreen(pickedCard: true, card: card)
                return
            }
            animateCardReposition()
        }
    }
    
    private func removeCardFromScreen(pickedCard: Bool, card: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            card.center = CGPoint(x: pickedCard ? card.center.x + 200 : card.center.x - 200, y: card.center.y + 50)
            card.alpha = 0
        }, completion: { _ in
            self.removeCard()
            self.getRandomEmployee()
            UIView.animate(withDuration: 0.15, animations: {
                self.cardView.alpha = 1
            })
        })
    }
    
    private func animateCardReposition() {
        UIView.animate(withDuration: 0.3, animations: {
            self.removeCard()
        })
    }
    
    private func removeCard() {
        cardView.center = self.view.center
        cardView.transform = .identity
        thumbsLabel.alpha = 0
    }
    
    private func getRandomEmployee() {
        let currentEmployee = employees[Int(arc4random_uniform(UInt32(employees.count)))]
        nameLabel.text = currentEmployee.name
        skillLabel.text = currentEmployee.skill
        genderLabel.text = currentEmployee.sex
        picImageView.image = currentEmployee.sex == "M" ? #imageLiteral(resourceName: "Male") : #imageLiteral(resourceName: "Female")
    }
}
