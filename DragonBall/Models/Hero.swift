import Foundation



struct Hero: Codable, Equatable,Hashable{
    let id: String
    let favorite: Bool
    let name: String
    let description: String
    let photo: String
    
}

typealias Heroe = [Hero]

