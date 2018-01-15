import XCTest
@testable import SwiftStreams

// xcode kbd : https://developer.apple.com/library/content/documentation/IDEs/Conceptual/xcode_help-command_shortcuts/MenuCommands/MenuCommands014.html

class SwiftDictionnaryTests: XCTestCase {
    
    class Food : Equatable {
        
        let name: String
        let glutenFree: Bool
        let price: Double
        
        init(name: String, glutenFree: Bool, price: Double) {
            self.name = name
            self.glutenFree = glutenFree
            self.price = price
        }
        
        static func ==(f1: SwiftDictionnaryTests.Food, f2: SwiftDictionnaryTests.Food) -> Bool {
            return f1.name == f2.name && f1.glutenFree == f2.glutenFree && f1.price == f2.price
        }
    }
    
    func test_filter_map_entries() {
        // given
        let pancake = Food(name: "pancake", glutenFree: true, price: 1.0)
        let fish = Food(name: "fish", glutenFree: true, price: 2.0)
        let map = [
            pancake.name: pancake,
            fish.name: fish,
        ]
        
        // when
        let fifish: [String: Food] = map.filter({$0.key == "fish"})
        
        // then
        XCTAssertEqual(fifish, ["fish": fish])
    }
    
    func test_get_values_Array() {
        // given
        let pancake = Food(name: "pancake", glutenFree: true, price: 1.0)
        let fish = Food(name: "fish", glutenFree: true, price: 2.0)
        let dic = [
            pancake.name: pancake,
            fish.name: fish,
            ]
        
        // when
        let values: Dictionary<String, Food>.Values = dic.values
        let names = values
                    .map({$0.name})
                    .joined(separator: ", ")
        
        // then
        XCTAssertEqual(names, "fish, pancake")
    }
    
    func test_map_values() {
        // given
        let pancake = Food(name: "pancake", glutenFree: true, price: 1.0)
        let fish = Food(name: "fish", glutenFree: true, price: 2.0)
        let dic = [
            pancake.name: pancake,
            fish.name: fish,
            ]
        
        // when
        let mapWithPrices: Dictionary<String, Double> = dic.mapValues({$0.price})
        
        // then
        XCTAssertEqual(mapWithPrices["fish"], 2)
    }
    
    func test_map_dictionary() {
        // given
        let pancake = Food(name: "pancake", glutenFree: true, price: 1.0)
        let fish = Food(name: "fish", glutenFree: true, price: 2.0)
        let dic = [
            pancake.name: pancake,
            fish.name: fish,
            ]
        
        // when
        let names = dic
                    .map({$0.value.name})
                    .joined(separator: ", ")
        
        // then
        XCTAssertEqual(names, "fish, pancake")
    }
}
