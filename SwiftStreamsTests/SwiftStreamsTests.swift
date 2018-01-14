import XCTest
@testable import SwiftStreams

// xcode kbd : https://developer.apple.com/library/content/documentation/IDEs/Conceptual/xcode_help-command_shortcuts/MenuCommands/MenuCommands014.html
// java koan: https://github.com/benbaxter/java8-koans/blob/master/src/test/java/LessonD_Streams.java

class SwiftStreamsTests: XCTestCase {
    
    class Food : Equatable {
        
        let name: String
        let glutenFree: Bool
        let price: Double
        
        init(name: String, glutenFree: Bool, price: Double) {
            self.name = name
            self.glutenFree = glutenFree
            self.price = price
        }
        
        static func ==(f1: SwiftStreamsTests.Food, f2: SwiftStreamsTests.Food) -> Bool {
            return f1.name == f2.name && f1.glutenFree == f2.glutenFree && f1.price == f2.price
        }
    }
    
    func test_food_equatable() {
        // given
        let f1 = Food(name: "pancakes", glutenFree: false, price: 2.0)
        let f2 = Food(name: "pancakes", glutenFree: false, price: 2.0)
        
        let f3 = Food(name: "banana", glutenFree: false, price: 2.0)
        let f4 = Food(name: "pancakes", glutenFree: true, price: 2.0)
        let f5 = Food(name: "pancakes", glutenFree: false, price: 1.0)
        
        // then
        XCTAssertEqual(f1, f2)
        XCTAssertEqual([f1], [f2])
        XCTAssertNotEqual(f1, f3)
        XCTAssertNotEqual(f1, f4)
        XCTAssertNotEqual(f1, f5)
    }
    
    func test_filtering_range() {
        // given
        let integers: CountableRange<Int> = 0..<10
        
        // when
        let even: [Int] = integers.filter({$0 % 2 == 0})
        
        // then
        XCTAssertEqual(even, [0, 2, 4, 6, 8])
    }
    
    func test_filtering_returns_option() {
        // given
        let integers: CountableRange<Int> = 0..<10
        
        // when
        let firstNotFound = integers.filter({$0 == 11}).first
        let firstFound = integers.filter({$0 == 0}).first
        
        // then
        XCTAssertNil(firstNotFound)
        XCTAssertEqual(firstFound, 0)
    }
    
    func test_filter_gluten_free_then_sum_items_price() {
        // given
        let foods = [ Food(name: "pancakes", glutenFree: false, price: 2.0),
                      Food(name: "buckwheat", glutenFree: true, price: 3.0),
                      Food(name: "eggs", glutenFree: true, price: 1.0),
                      Food(name: "toast", glutenFree: false, price: 1.0),
                      Food(name: "muffins", glutenFree: false, price: 3.0) ]
        
        // when
        let sum = foods.filter({$0.glutenFree})
                       .map({$0.price})
                       .reduce(0, +)
        
        // then
        XCTAssertEqual(sum, 4)
    }
    
    func test_list_items() {
        // given
        let foods = [ Food(name: "pancakes", glutenFree: false, price: 2.0),
                      Food(name: "buckwheat", glutenFree: true, price: 3.0),
                      Food(name: "eggs", glutenFree: true, price: 1.0),
                      Food(name: "toast", glutenFree: false, price: 1.0),
                      Food(name: "muffins", glutenFree: false, price: 3.0) ]
        
        // when
        let names: [String] = foods.map({$0.name})

        let joined: String = names.joined(separator: ",")
        
        // then
        XCTAssertEqual(names.count, 5)
        XCTAssertEqual(names.contains("pancakes"), true)
        XCTAssertEqual(joined, "pancakes,buckwheat,eggs,toast,muffins")
    }
    
    func test_flatten() {
        // given
        let teams = [ ["Ben", "Ludo"], ["Carole", "Fred"] ]
        
        // when
        let mergedTeam: [String] = teams.flatMap({$0})
        
        // then
        XCTAssertEqual(mergedTeam, ["Ben", "Ludo", "Carole", "Fred"])
    }
    
    func test_sort_by_price() {
        // given
        let foods = [ Food(name: "pancakes", glutenFree: false, price: 2.0),
                      Food(name: "buckwheat", glutenFree: true, price: 3.0),
                      Food(name: "eggs", glutenFree: true, price: 1.0),
                      Food(name: "toast", glutenFree: false, price: 1.1),
                      Food(name: "muffins", glutenFree: false, price: 3.1) ]
        
        // when
        let sortedByPrice: [Food] = foods.sorted(by: {$0.price < $1.price})
        
        // then
        XCTAssertEqual(sortedByPrice, [
            Food(name: "eggs", glutenFree: true, price: 1.0),
            Food(name: "toast", glutenFree: false, price: 1.1),
            Food(name: "pancakes", glutenFree: false, price: 2.0),
            Food(name: "buckwheat", glutenFree: true, price: 3.0),
            Food(name: "muffins", glutenFree: false, price: 3.1)
        ])
    }
}
