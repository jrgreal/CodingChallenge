//
//  StateController.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation
import UIKit

class StateController {
    var persistenceController: FileSystemPersistenceController?
    var media: [Medium]?
    var medium: Medium?
    var lastVisitDate: Date?
}
