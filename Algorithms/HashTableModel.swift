//
//  HashTableModel.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 01/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation

// Selve noden

public struct HashTable<Key: Hashable, Value> {
    // når vi lager et HashTable, kan vi nå spesifisere to generics
    // myTable = HashTable<String, Int> for eksempel. Typen til andre delen der

    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    
    private var buckets: [Bucket]
    var count = 0
    var isEmpy: Bool { return count == 0 }
    
    // init
    
    init(capacity: Int) {
        buckets = Array<Bucket>(repeatElement([], count: capacity))
        // lager et array med CAPACITY antall elementer. Hver av disse elementene er av en et tomt array av BUCKET...
        // så totalt, en rad med arrays av buckets som en matrise
    }
    
    // index
    
    private func index(forKey key: Key) -> Int {
        print("\(key) hashed to \(abs(key.hashValue) % buckets.count)")
        return abs(key.hashValue) % buckets.count
    }
    
    // Subscript for easy access
    
    public subscript(key: Key) -> Value? {
        // Subscriptet er som en funksjon, og returnerer enten nil eller ingenting ved get
        // dealer her med det som blir sendt inn i myHashTable[x]
        // Swift skjønner selv om du henter ut eller setter inn og velger get/set deretter
        // hvor x er hashable
        
        get {
            return value(forKey: key)
        }
        
        set {
            // unwrapper siden vi jobber med optionals (kan sende inn nil)
            
            if let input = newValue {
                // vi har da en faktisk verdi
                updateValue(input, forKey: key)
            } else {
                print("removing")
                removeValue(forKey: key)
            }
            }
        }
    
    // Helper function getIndex used in several functions
    
    private func getIndex(forKey key: Key) -> Int {
        
        return abs(key.hashValue  % buckets.count)
        // Vi vet at key er av en type som er hashable ut fra generic declaration i toppen.
        // må være et positiv sted i arrayet
    }
    
    // value funksjonen
    
    private func value(forKey key: Key) -> Value?{
        
        // denne funksjonen skal finne index nr via en egen index funksjon som brukes igjen,
        // og så sjekke elementet og evt dens chain etter riktig verdi
        let index = getIndex(forKey: key)
        
        for element in buckets[index] {
            if element.key == key {
                print("returning element.value: \(element.value)")
                return element.value
            }
        }
        return nil
    }
    
    // updateValue function
    
    mutating private func updateValue(_ newValue: Value, forKey key: Key){
        print("You have requested updating \(key) to \(newValue)")
        let index = getIndex(forKey: key)
        //let oldValue = newValue
        
        for (i, element) in buckets[index].enumerated() {
            
            if element.key == key {
                print("checking index: ", i)
                print("key \(key) matchet elementets key \(element.key)")
                buckets[index][i].value = newValue
                print("updated \(buckets[index][i].value) to \(newValue)")
                return
            }
        }
        
        // if i get here, theres no value in the bucket so I add it
        print("Value \(key) with \(newValue) did not exist. Appending it now")
        self.buckets[index].append((key, newValue))
        
        self.count += 1
    }
    
    // removeValue function
    
    mutating private func removeValue(forKey key: Key){
        let index = getIndex(forKey: key)
        print("removing \(key)... index says it is at: \(index)")
        
        for (i,element) in buckets[index].enumerated() {
            print("(i, element) = (\(i), \(element))")
            if element.key == key {
                print("- Match -")
                print("\(element.key) is equal to \(key)")
                print("Calling buckets[index].remove(at: i) where i is \(i)")
                print("removing key: \(key) which had value\(self.value(forKey: key))")
                buckets[index].remove(at: i)
                count -= 1
                print("removed \(key)")
                return
            }
        }
    }
} // End of HashTable
