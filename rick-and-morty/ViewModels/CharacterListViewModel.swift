import UIKit

protocol CharacterListViewModelDelegate: AnyObject {
	func didLoadInitialCharacters()
}

final class CharacterListViewModel: NSObject {
	
	public weak var delegate: CharacterListViewModelDelegate?
	
	private var characters: [Character] = [] {
		didSet {
			for character in characters {
				let viewModel = CharacterCollectionViewCellViewModel(name: character.name,
					characterStatus: character.status,
					imageURL: URL(string: character.image))
			cellViewModels.append(viewModel)
			}
		}
	}
	private var cellViewModels: [CharacterCollectionViewCellViewModel] = []
	
	
	
	public func fetchCharacterList() {
		Service.shared.execute(.listCharactersRequests,
			expecting: GetAllCharactersResponse.self) { [weak self] result in
			switch result {
			case .success(let model):
				let results = model.results
				self?.characters = results
				DispatchQueue.main.async {
					self?.delegate?.didLoadInitialCharacters()
				}
				print("Example image url: " + String(model.results.first?.image ?? "no image"))
				print("Got \(model.results.count) results")
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
		cellViewModels.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier,
			for: indexPath) as? CharacterCollectionViewCell
		else {
			fatalError("Unsupported cell")
		}
		cell.configure(with: cellViewModels[indexPath.row])
		//cell.backgroundColor = .systemGr een
		return cell
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (collectionView.bounds.width - 30) / 2
		return CGSize(width: width, height: width * 1.5)
	}
}
