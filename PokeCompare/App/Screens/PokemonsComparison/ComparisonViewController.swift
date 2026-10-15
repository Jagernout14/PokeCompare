//
//  ComparisonViewController.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 12.10.2026.
//

import UIKit

final class ComparisonViewController: UIViewController {
    
    // MARK: - Private Properties
    private let comparisonView = ComparisonView()
    private let viewModel: ComparisonViewModel
    
    // MARK: - Initializers
    init(viewModel: ComparisonViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Overrides Methods
    override func loadView() {
        view = comparisonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }
    
    // MARK: - Private Methods
    private func bind() {
        viewModel.onResult = { [weak self]  left, right in
            self?.comparisonView.configure(left: left, right: right)
        }
        viewModel.onError = { [weak self] message in
            self?.showError(message)
        }
        //TODO: - viewModel.onLoading
    }
    
    private func showError(_ error: String) {
        let controller = UIAlertController(title: "Ошибка", message: "\(error)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        controller.addAction(action)
        present(controller, animated: true)
    }
}
