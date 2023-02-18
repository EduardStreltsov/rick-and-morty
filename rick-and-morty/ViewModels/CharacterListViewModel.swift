import UIKit

final class CharacterListViewModel: NSObject {
	func fetchCharacterList() {
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

extension CharacterListViewModel: UICollectionViewDelegate,
	UICollectionViewDelegateFlowLayout,
	UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		20
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		cell.backgroundColor = .systemGreen
		return cell
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (collectionView.bounds.width - 30) / 2
		return CGSize(width: width, height: width * 1.5)
	}
}
