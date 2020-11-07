//
//  Nature+CoreDataProperties.swift
//  
//
//  Created by Abhi Makadiya on 07/11/20.
//
//

import Foundation
import CoreData

extension Nature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nature> {
        return NSFetchRequest<Nature>(entityName: "Nature")
    }

    @NSManaged public var address: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?

}
