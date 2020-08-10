//
//  FooterView.swift
//  iMusic
//
//  Created by Пятин Дмитрий on 28.07.2020.
//  Copyright © 2020 Пятин Дмитрий. All rights reserved.
//

import UIKit


private var myLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    return label
    }()

private var loader: UIActivityIndicatorView = {
    let loader = UIActivityIndicatorView()
    loader.translatesAutoresizingMaskIntoConstraints = false
    loader.hidesWhenStopped = true
    return loader
    }()



class FooterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupElements()
    }
    
    
    func showLoading() {
        loader.startAnimating()
        myLabel.text = "LOADING"
    }
    
    func hideLoader() {
        loader.stopAnimating()
        myLabel.text = ""
    }
    
    
    private func setupElements() {
        addSubview(myLabel)
        addSubview(loader)
        
        
        loader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        loader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        loader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        myLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        myLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 8).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
