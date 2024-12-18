//
//  VerticalStack.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//
import UIKit

class VerticalStack: UIStackView {
    
    init(subViews: [UIView],
         spacing: CGFloat = 20,
         distribution: UIStackView.Distribution = .fill,
         alignment: UIStackView.Alignment = .fill,
         margins: UIEdgeInsets = .zero) {
        
        super.init(frame: .zero)
        subViews.forEach({ self.addArrangedSubview($0) })
        self.axis = .vertical
        self.spacing = spacing
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = margins
        self.backgroundColor = .clear
        self.alignment = alignment
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
