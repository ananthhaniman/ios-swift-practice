//
//  TableApiCaller.swift
//  Combine Demo
//
//  Created by Ananthamoorthy Haniman on 2022-04-16.
//

import Foundation
import Combine


class TableApiCaller{
    
    static let shared = TableApiCaller()
    
    
    func fetchData() -> Future<[String],Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                promise(.success(["hello world","test"]))
            }
        }
        
    }
    
    
}
