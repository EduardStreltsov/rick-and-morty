//
//  CharacterCollectionViewCell.swift
//  rick-and-morty
//
//  Created by Eduard Streltsov on 25.02.2023.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
	static let cellIdentifier = "CharacterCollectionViewCell"
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .label
		label.font = .systemFont(ofSize: 18, weight: .medium)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	private let statusLabel: UILabel = {
		let label = UILabel()
		label.textColor = .secondaryLabel
		label.font = .systemFont(ofSize: 16, weight: .regular)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	// MARK: - Init
	required init?(coder: NSCoder) {
		fatalError("Unsupported")
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.backgroundColor = .secondarySystemBackground
		contentView.addSubviews(imageView, nameLabel, statusLabel)
		addConstrains()
		setupLayer()
		
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
		nameLabel.text = nil
		statusLabel.text = nil
	}
	
	private func addConstrains() {
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5),
			
			nameLabel.heightAnchor.constraint(equalToConstant: 30),
			nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
			nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
			nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
			
			statusLabel.heightAnchor.constraint(equalToConstant: 30),
			statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
			statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
			statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
		])
		
		imageView.backgroundColor = .systemCyan
		nameLabel.backgroundColor = .orange
		statusLabel.backgroundColor = .yellow
	}
	
	private func setupLayer() {
		contentView.layer.cornerRadius = 8
		contentView.layer.shadowColor = UIColor.label.cgColor
		contentView.layer.cornerRadius = 4
		contentView.layer.shadowOffset = CGSize(width: -4, height: -4)
		contentView.layer.shadowOpacity = 0.3
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		setupLayer()
	}
	
	// MARK: - Public
	
	public func configure(with viewModel: CharacterCollectionViewCellViewModel) {
		nameLabel.text = viewModel.name
		statusLabel.text = viewModel.characterStatusText
		viewModel.fetchImage { [weak self] result in
			switch result {
			case .success(let data):
				DispatchQueue.main.async {
					let image = UIImage(data: data)
					self?.imageView.image = image
				}
			case .failure(let error):
				print(String(describing: error))
				break
			}
			
		}
		
	}
}
