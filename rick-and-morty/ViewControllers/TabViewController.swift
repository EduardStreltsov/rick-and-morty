//
//  ViewController.swift
//  rick-and-morty
//
//  Created by Eduard Streltsov on 02.01.2023.
//

import UIKit

final class TabViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		view.backgroundColor = .systemBackground
		
		setUpTabs()
	}
	
	private func setUpTabs() {
		let characterVC = CharacterViewController()
		let locationVC = LocationController()
		let episodeVC = EpisodeViewController()
		let settingsVC = SettingsViewController()
		
		let vcs = [characterVC, locationVC, episodeVC, settingsVC]
		for vc in vcs {
			vc.navigationItem.largeTitleDisplayMode = .automatic
		}
		
		let navigation1 = UINavigationController(rootViewController: characterVC)
		let navigation2 = UINavigationController(rootViewController: locationVC)
		let navigation3 = UINavigationController(rootViewController: episodeVC)
		let navigation4 = UINavigationController(rootViewController: settingsVC)
		
		navigation1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
		navigation2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
		navigation3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
		navigation4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
		
		let navs = [navigation1, navigation2, navigation3, navigation4]
		
		for nav in navs {
			nav.navigationBar.prefersLargeTitles = true
		}
		
		setViewControllers(navs, animated: true)
	}


}

