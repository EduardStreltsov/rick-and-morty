import Foundation

private enum ServiceError: Error {
	case failedToCreateRequest, failedToGetData
}

final class Service {
	static let shared = Service()
	private init() {}
	
	public func execute<T: Codable>(_ request: Request,
	                                expecting type: T.Type,
	                                completion: @escaping (Result<T, Error>) -> Void) {
		guard let urlRequest = self.request(from: request) else {
			completion(.failure(ServiceError.failedToCreateRequest ))
			return
		}
		
		let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
			guard let data = data, error == nil else {
				completion(.failure(error ?? ServiceError.failedToGetData))
				return
			}
			
			// decode the response
			do {
				let json = try JSONSerialization.jsonObject(with: data)
				//print(String(describing: json))
				let result = try JSONDecoder().decode(type.self, from: data)
				completion(.success(result))
			}
			catch {
				completion(.failure(error))
			}
		}
		task.resume()
	}
	
	private func request(from request: Request) -> URLRequest? {
		guard let url = request.url else { return nil }
		
		var request = URLRequest(url: url)
		request.httpMethod = request.httpMethod
		return request
	}
}
