import UIKit

final class CharacterViewController: UIViewController {
	
	private let characterListView = CharacterListView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		title = "Characters"
		view.addSubview(characterListView)
		NSLayoutConstraint.activate([
			characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
		])
		
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
	}
	
}
