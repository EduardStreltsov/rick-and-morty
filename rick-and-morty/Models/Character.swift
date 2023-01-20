//
//  Character.swift
//  rick-and-morty
//
//  Created by Eduard Streltsov on 02.01.2023.
//

import Foundation

enum Status: String {
	case alive = "Alive"
	case dead = "Dead"
	case unknown = "Unknown"
}

enum Gender {
	case male, female, genderless, unknown
}

struct Character: Codable {
	let id: Int
	let name: String
	let status: Status
	let species: String
	let type: String
	let gender: Gender
	let origin: String
	let location: Location
	let image: String
	let episode: [String]
	let url: String
	let created: String
	
	init(from decoder: Decoder) throws {
	
	}
	
	func encode(to encoder: Encoder) throws {
	}
}