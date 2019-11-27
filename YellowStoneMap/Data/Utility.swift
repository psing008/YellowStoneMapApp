//
//  Utility.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/26/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation

class Utility {
    // Need to make this generic
    static func convertToJSON(items:[YSCampSiteDataModel]?) -> String? {
    
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(items)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonString

        } catch { print(error) }
        
        return nil
    }
}


