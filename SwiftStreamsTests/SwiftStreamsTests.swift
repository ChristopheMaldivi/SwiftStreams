import XCTest
@testable import SwiftStreams

class SwiftStreamsTests: XCTestCase {
    
    class Food {
        let name: String
        let glutenFree: Bool
        let price: Double
        
        init(name: String, glutenFree: Bool, price: Double) {
            self.name = name
            self.glutenFree = glutenFree
            self.price = price
        }
    }
    
    func test_filtering_range() {
        // given
        let integers: CountableRange<Int> = 0..<10
        
        // when
        let even: [Int] = integers.filter({$0 % 2 == 0})
        
        // then
        XCTAssertEqual(even, [0, 2, 4, 6, 8])
    }
    
    func test_filter_gluten_free_then_sum_items_price() {
        // given
        let foods = [ Food(name: "pancakes", glutenFree: false, price: 2.0),
                      Food(name: "buckwheat pancakes", glutenFree: true, price: 3.0),
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
}
