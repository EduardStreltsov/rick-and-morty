import UIKit

final class CharacterListView: UIView {
	
	private let viewModel = CharacterListViewModel()
	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.hidesWhenStopped = true
		spinner.translatesAutoresizingMaskIntoConstraints = false
		return spinner
	}()
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isHidden = true
		collectionView.alpha = 0
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(CharacterCollectionViewCell.self,
			forCellWithReuseIdentifier: CharacterCollectionViewCell.cellIdentifier)
		return collectionView
	}()
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		addSubviews(collectionView, spinner)
		addConstraints()
		
		spinner.startAnimating()
		viewModel.delegate = self
		viewModel.fetchCharacterList()
		setUpCollectionView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("Unsupported")
	}
	
	private func addConstraints() {
		NSLayoutConstraint.activate([
			spinner.widthAnchor.constraint(equalToConstant: 100),
			spinner.heightAnchor.constraint(equalToConstant: 100),
			spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
			
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			collectionView.leftAnchor.constraint(equalTo: leftAnchor),
			collectionView.rightAnchor.constraint(equalTo: rightAnchor)
		])
	}
	
	private func setUpCollectionView() {
		collectionView.dataSource = viewModel
		collectionView.delegate = viewModel
	}
}

extension CharacterListView: CharacterListViewModelDelegate {
	func didLoadInitialCharacters() {
		// this is for not to get situation when view is loaded before we went ahead and got the data
		
		//DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
		spinner.stopAnimating()
		collectionView.isHidden = false
		collectionView.reloadData()
		UIView.animate(withDuration: 0.4) {
			self.collectionView.alpha = 1
		}
		//})
	}
}