//
//  ClientFormViewController.swift
//  PayUp
//
//  Created by Mateus Henrique Coelho de Paulo on 29/06/25.
//

import UIKit

final class ClientFormViewController: UIViewController {
    private let mode: ClientFormMode
    private var hasInitializedPosition = false
    private lazy var contentView = ClientFormView(mode: mode)
    
    init(mode: ClientFormMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !hasInitializedPosition else { return }
        
        hasInitializedPosition = true
        contentView.containerView.transform = CGAffineTransform(translationX: 0,
                                                                y: contentView.containerView.bounds.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.contentView.containerView.transform = .identity
        }
    }
    
}

extension ClientFormViewController: ClientFormViewDelegate {
    func didTapCancel() {
        dismiss(animated: true)
    }
    
    func didTapSave() {
        dismiss(animated: true)
        // TODO: Implementar logia de salvar
    }
    
    func didTapDelete() {
        let alert = UIAlertController(title: "Excluir cliente",
                                      message: "Tem certeza que deseja excluir este cliente?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive) { _ in
            // TODO: implementar logica de deletar
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
    
    func didTapDelete() {
        let alert = UIAlertController(title: "Excluir cliente", 
                                     message: "Tem certeza que deseja excluir este cliente?", 
                                     preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive) { _ in
            // TODO: Implement delete logic
            self.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
}
