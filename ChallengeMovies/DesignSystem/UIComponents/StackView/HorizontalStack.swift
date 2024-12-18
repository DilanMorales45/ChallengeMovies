//
//  HorizontalStack.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import UIKit

class HorizontalStack: UIStackView {
    
    init(subViews: [UIView],
         distribution: UIStackView.Distribution = .fillEqually,
         spacing: CGFloat = 20,
         margins: UIEdgeInsets = .zero) {
        
        super.init(frame: .zero)
        subViews.forEach({ self.addArrangedSubview($0) })
        self.axis = .horizontal
        self.spacing = spacing
        self.alignment = .top
        self.distribution = distribution
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = margins
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

