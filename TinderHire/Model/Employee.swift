//
//  Employee.swift
//  TinderHire
//
//  Created by Mauricio Chirino on 4/12/17.
//  Copyright © 2017 Mauricio Chirino. All rights reserved.
//

import Foundation

struct EmployeeCV {
    let name: String
    let skill: String
    let sex: String
}

struct EmployeeFactory {
    static func getEntireNominee() -> [EmployeeCV] {
        return [
            EmployeeCV(name: "Clara Smith", skill: "Django", sex: "F"),
            EmployeeCV(name: "John Harper", skill: "Python", sex: "M"),
            EmployeeCV(name: "Sagar Shah", skill: "Django", sex: "M"),
            EmployeeCV(name: "Bob Thomas", skill: "React", sex: "M"),
            EmployeeCV(name: "Sophie Laura", skill: "React", sex: "F"),
            EmployeeCV(name: "Sammie Lopez", skill: "Django", sex: "F"),
            EmployeeCV(name: "Connie Jones", skill: "Django", sex: "F"),
            EmployeeCV(name: "Camille Rowe", skill: "Django", sex: "F"),
            EmployeeCV(name: "Joana Silver", skill: "Python", sex: "F"),
            EmployeeCV(name: "Sasha Doe", skill: "Django", sex: "F"),
            EmployeeCV(name: "Gaby Simone", skill: "React", sex: "F"),
            EmployeeCV(name: "Chloe Isabella", skill: "React", sex: "F"),
            EmployeeCV(name: "George Stanley", skill: "Django", sex: "M"),
            EmployeeCV(name: "Dominic Hope", skill: "Django", sex: "M"),
            EmployeeCV(name: "Sandra Bonhomme", skill: "Django", sex: "F"),
            EmployeeCV(name: "Sophie Gerbault", skill: "React", sex: "F"),
            EmployeeCV(name: "Sarah Seemore", skill: "React", sex: "F"),
            EmployeeCV(name: "Rachel Green", skill: "Django", sex: "F"),
            EmployeeCV(name: "Josephine Taylor", skill: "Django", sex: "F"),
            EmployeeCV(name: "Jay Jiang", skill: "Django", sex: "M"),
            EmployeeCV(name: "Hunter Dickson", skill: "React", sex: "M"),
            EmployeeCV(name: "Sam Gupta", skill: "React", sex: "M"),
            EmployeeCV(name: "Tom Brady", skill: "Django", sex: "M"),
            EmployeeCV(name: "Taylor Thompson", skill: "Django", sex: "F"),
            EmployeeCV(name: "Tatianna Marshall", skill: "Django", sex: "F"),
            EmployeeCV(name: "Eric Street", skill: "Python", sex: "M"),
            EmployeeCV(name: "Marine Simon", skill: "Python", sex: "F"),
            EmployeeCV(name: "Ronald Duck", skill: "Pytho", sex: "M"),
            EmployeeCV(name: "Jennifer Lopez", skill: "Python", sex: "F")
        ]
    }

    static func getRandom() -> EmployeeCV {
        let entireStaff = EmployeeFactory.getEntireNominee()
        return entireStaff[Int(arc4random_uniform(UInt32(entireStaff.count)))]
    }
}
