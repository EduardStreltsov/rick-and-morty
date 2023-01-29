import UIKit

final class CharacterViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		title = "Characters"
		
		//let request = Request(endpoint: .character,
		//	queryParameters: [
		//		URLQueryItem(name: "name", value: "rick"),
		//		URLQueryItem(name: "status", value: "alive")
		//	])
		//
		//print(request.url)
		//
		//Service.shared.execute(request, expecting: Character.self) { result in
		//	switch result {
		//	case .success:
		//		break
		//	case .failure(let error):
		//		print(String(describing: error))
		//	}
		//}
		
		Service.shared.execute(.listCharactersRequests, expecting: GetAllCharactersResponse.self) { result in
			switch result {
			case .success(let model):
				print(String(describing: model))
			case .failure(let error):
				print(String(describing: error))
			}
		}
	}
	
}
