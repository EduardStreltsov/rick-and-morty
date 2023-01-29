import Foundation

struct Episode: Codable {
	let id: String
	let name: String
	let airDate: String
	let characters: [String]
	let url: String
	let created: String
}