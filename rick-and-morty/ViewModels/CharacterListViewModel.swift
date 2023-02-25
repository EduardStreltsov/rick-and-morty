import UIKit

final class CharacterListViewModel: NSObject {
	func fetchCharacterList() {
		Service.shared.execute(.listCharactersRequests, expecting: GetAllCharactersResponse.self) { result in
			switch result {
			case .success(let model):
				//print(String(describing: model))
				print("Example image url: " + String(model.results.first?.image ?? "no image"))
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
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier,
			for: indexPath) as? CharacterCollectionViewCell
		else {
			fatalError("Unsupported cell")
		}
		let viewModel = CharacterCollectionViewCellViewModel(name: "name",
			characterStatus: .alive,
			imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
		cell.configure(with: viewModel)
		//cell.backgroundColor = .systemGr een
		return cell
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (collectionView.bounds.width - 30) / 2
		return CGSize(width: width, height: width * 1.5)
	}
}
