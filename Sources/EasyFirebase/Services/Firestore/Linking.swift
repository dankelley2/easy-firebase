//
//  Linking.swift
//  
//
//  Created by Ben Myers on 11/2/21.
//

import Foundation

extension EasyFirestore {
  
  public struct Linking {
    
    // MARK: - Public Static Methods
    
    public static func assign<T, U>(_ child: T, to field: FieldName, in parent: U, completion: @escaping (Error?) -> Void = { _ in }) where T: Document, U: Document {
      append(child.id, to: field, in: parent, completion: completion)
    }
    
    public static func unassign<T, U>(_ child: T, from field: FieldName, in parent: U, completion: @escaping (Error?) -> Void = { _ in }) where T: Document, U: Document {
      unappend(child.id, from: field, in: parent, completion: completion)
    }
    
    // MARK: - Private Static Methods
    
    private static func append<T>(_ id: DocumentID, to field: FieldName, in parent: T, completion: @escaping (Error?) -> Void) where T: Document {
      getArray(from: id, ofType: T.self, field: field) { array in
        guard var array = array else {
          completion(LinkingError.noArray)
          return
        }
        array <= id
        Storage.set(array, to: field, in: parent, completion: completion)
      }
    }
    
    private static func unappend<T>(_ id: DocumentID, from field: FieldName, in parent: T, completion: @escaping (Error?) -> Void) where T: Document {
      getArray(from: id, ofType: T.self, field: field) { array in
        guard var array = array else {
          completion(LinkingError.noArray)
          return
        }
        array -= id
        Storage.set(array, to: field, in: parent, completion: completion)
      }
    }
    
    // MARK: - Enumerations
    
    enum LinkingError: Error {
      case noArray
    }
  }
}