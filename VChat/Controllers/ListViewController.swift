//
//  ListViewController.swift
//  VChat
//
//  Created by Влад Барченков on 08.10.2020.
//

import UIKit
import FirebaseFirestore

class ListViewController: UIViewController {
    
    var activeChats = [MChat]()
    private var activeChatsListener: ListenerRegistration?
    
    enum Section: Int, CaseIterable {
        case  activeChats
        
        func description() -> String {
            switch self {
            case .activeChats:
                return "Active chats"
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MChat>?
    var collectionView: UICollectionView!
    
    private let currentUser: MUser
       
       init(currentUser: MUser) {
           self.currentUser = currentUser
           super.init(nibName: nil, bundle: nil)
           title = currentUser.username
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        activeChatsListener?.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData()
        
        activeChatsListener = ListenerService.shared.activeChatsObserve(chats: activeChats, completion: { (result) in
            switch result {
            case .success(let chats):
                self.activeChats = chats
                self.reloadData()
            case .failure(let error):
                self.showAlert(with: "Ошибка!", and: error.localizedDescription)
            }
        })
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        
        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reuseId)
        collectionView.delegate = self
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MChat>()
        
        snapshot.appendSections([.activeChats])

        snapshot.appendItems(activeChats, toSection: .activeChats)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Data Source
extension ListViewController {
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .activeChats:
                return self.configure(collectionView: collectionView, cellType: ActiveChatCell.self, with: chat, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header") }
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            sectionHeader.configure(text: section.description(),
                                    font: .systemFont(ofSize: 17, weight: .semibold),
                                    textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            return sectionHeader
        }
    }
}

// MARK: - Setup layout
extension ListViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }
        
            switch section {
            case .activeChats:
                return self.createActiveChats()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 32
        layout.configuration = config
        return layout
    }
    
    private func createActiveChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(56))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 16, bottom: 0, trailing: 16)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
}

// MARK: - UICollectionViewDelegate
extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let chat = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .activeChats:
            print(indexPath)
            let chatsVC = ChatsViewController(user: currentUser, chat: chat)
            navigationController?.pushViewController(chatsVC, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

// MARK: - SwiftUI
import SwiftUI

struct ListVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: ListVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) {
            
        }
    }
}
