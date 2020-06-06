//
//  JobTableViewCell.swift
//  shimmer-animation
//
//  Created by Admin on 6/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import ShimmerBlocks

class JobTableViewCell: UITableViewCell {
    @IBOutlet weak var jobPhoto: UIImageView!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobCompany: UILabel!
    @IBOutlet weak var jobLocation: UILabel!
    @IBOutlet weak var jobType: UILabel!
    
    private lazy var shimmerContainer = ShimmerContainer(parentView: self)
    
    
    private lazy var shimmerData: [ShimmerData] = {
        let titleSections = ShimmerSection.generate(minWidth: 50, height: 21, totalWidth: 150, maxNumberOfSections: 3)
        return [ShimmerData(jobTitle, sectionSpacing: 6, sections: titleSections),
                ShimmerData(jobPhoto, matchViewDimensions: true),
                ShimmerData(jobCompany, matchViewDimensions: true),
                ShimmerData(jobLocation, matchViewDimensions: true),
                ShimmerData(jobType, matchViewDimensions: true)]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func isLoading(_ loading: Bool) {
        shimmerContainer.applyShimmer(enable: loading, with: shimmerData)
    }
}
