import Foundation

final class CharacterCollectionViewCellViewModel {
	
	public let name: String
	private let characterStatus: CharacterStatus
	public var characterStatusText: String {
		characterStatus.rawValue
	}
	private let imageURL: URL?
	
	// MARK: - Init
	
	init(name: String, characterStatus: CharacterStatus, imageURL: URL?) {
		self.name = name
		self.characterStatus = characterStatus
		self.imageURL = imageURL
	}
	
	// MARK: - Public
	public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
		// Todo abstract to image manager
		guard let url = imageURL else {
			completion(.failure(URLError(.badURL)))
			return
		}
		let request = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, error == nil else {
				completion(.failure(error ?? URLError(.dataNotAllowed)))
				return
			}
			completion(.success(data))
		}
		task.resume()
	}
}
