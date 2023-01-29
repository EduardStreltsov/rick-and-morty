import Foundation

struct Character: Codable {
	let id: Int
	let name: String
	let status: Status
	let species: String
	let type: String
	let gender: Gender
	let origin: Origin
	let location: Origin
	let image: String
	let episode: [String]
	let url: String
	let created: String
}
