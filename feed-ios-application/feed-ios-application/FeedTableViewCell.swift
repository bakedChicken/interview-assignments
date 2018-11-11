//
// Created by Artur Luppov on 11/9/18.
// Copyright (c) 2018 Artur Luppov. All rights reserved.
//

import UIKit

protocol FeedTableViewCellShowMoreButtonDelegate: class {
    func onButtonPressed()
}

private struct SizeConstants {
    static let scrollViewHeight = CGFloat(250)
    static let socialLabelWidth = CGFloat(50)
    static let smallMargin = CGFloat(4)
    static let defaultMargin = CGFloat(12)
    static let assetSize = CGFloat(18)
    static let defaultSpacing = CGFloat(8)
    static let avatarSize = CGFloat(36)
}

class FeedTableViewCell: UITableViewCell {
    weak var delegate: FeedTableViewCellShowMoreButtonDelegate?

    var images = [UIImage]() {
        didSet {
            let index = stackView.arrangedSubviews.firstIndex(of: anchorView)!

            if images.count == 0 {
                stackView.removeArrangedSubview(scrollView)
                scrollView.removeFromSuperview()
            } else if images.count >= 1 {
                scrollView.heightAnchor.constraint(equalToConstant: SizeConstants.scrollViewHeight).isActive = true
                stackView.insertArrangedSubview(scrollView, at: index + 1)
            }

            if images.count <= 1 {
                stackView.removeArrangedSubview(pageControl)
                pageControl.removeFromSuperview()
            } else if images.count > 1 {
                pageControl.numberOfPages = images.count
                stackView.insertArrangedSubview(pageControl, at: index + 2)
            }
        }
    }

    let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = SizeConstants.avatarSize / 2
        return view
    }()

    let nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let postLabel: UILabel = {
        let view = PaddingLabel()
        view.insets = UIEdgeInsets(
            top: 0,
            left: SizeConstants.defaultMargin,
            bottom: 0,
            right: SizeConstants.defaultMargin
        )
        view.numberOfLines = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let likesCountLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()

    let commentsCountLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()

    let sharesCountLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()

    let viewsCountLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()

    private let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.pageIndicatorTintColor = UIColor.blue.withAlphaComponent(0.5)
        view.currentPageIndicatorTintColor = .blue
        return view
    }()

    private let showFullPostButton: UIButton = {
        let view = UIButton(type: .system)
        view.contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: SizeConstants.defaultMargin,
            bottom: 0,
            right: SizeConstants.defaultMargin
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Показать полностью...", for: .normal)
        view.contentHorizontalAlignment = .left
        view.heightAnchor.constraint(equalToConstant: SizeConstants.assetSize).isActive = true
        return view
    }()

    private lazy var headerView: UIView = { [unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.avatarImageView)
        view.addSubview(self.nameLabel)
        view.addSubview(self.dateLabel)

        let margins = view.layoutMarginsGuide

        self.avatarImageView.widthAnchor.constraint(equalToConstant: SizeConstants.avatarSize).isActive = true
        self.avatarImageView.heightAnchor.constraint(equalToConstant: SizeConstants.avatarSize).isActive = true
        self.avatarImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        self.avatarImageView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        self.avatarImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        self.nameLabel.topAnchor.constraint(equalTo: self.avatarImageView.topAnchor).isActive = true
        self.nameLabel.leftAnchor.constraint(
            equalTo: self.avatarImageView.rightAnchor,
            constant: SizeConstants.defaultMargin
        ).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: SizeConstants.assetSize).isActive = true

        self.dateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        self.dateLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
        self.dateLabel.rightAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
        self.dateLabel.bottomAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor).isActive = true

        return view
    }()

    private lazy var socialView: UIView = { [unowned self] in
        let view = UIView()
        view.layoutMargins = UIEdgeInsets(
            top: 0,
            left: SizeConstants.defaultMargin,
            bottom: SizeConstants.defaultMargin,
            right: SizeConstants.defaultMargin
        )
        view.translatesAutoresizingMaskIntoConstraints = false

        let margins = view.layoutMarginsGuide

        let likeImageView = UIImageView(image: UIImage(named: "like"))
        likeImageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(likeImageView)
        view.addSubview(self.likesCountLabel)

        likeImageView.widthAnchor.constraint(equalToConstant: SizeConstants.assetSize).isActive = true
        likeImageView.heightAnchor.constraint(equalToConstant: SizeConstants.assetSize).isActive = true
        likeImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        likeImageView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        likeImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        self.likesCountLabel.widthAnchor.constraint(equalToConstant: SizeConstants.socialLabelWidth).isActive = true
        self.likesCountLabel.heightAnchor.constraint(equalTo: likeImageView.heightAnchor).isActive = true
        self.likesCountLabel.topAnchor.constraint(equalTo: likeImageView.topAnchor).isActive = true
        self.likesCountLabel.leftAnchor.constraint(
            equalTo: likeImageView.rightAnchor,
            constant: SizeConstants.smallMargin
        ).isActive = true

        let commentImageView = UIImageView(image: UIImage(named: "comment"))
        commentImageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(commentImageView)
        view.addSubview(self.commentsCountLabel)

        commentImageView.widthAnchor.constraint(equalTo: likeImageView.widthAnchor).isActive = true
        commentImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        commentImageView.leftAnchor.constraint(
            equalTo: self.likesCountLabel.rightAnchor,
            constant: SizeConstants.defaultMargin
        ).isActive = true
        commentImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        self.commentsCountLabel.widthAnchor.constraint(equalToConstant: SizeConstants.socialLabelWidth).isActive = true
        self.commentsCountLabel.heightAnchor.constraint(equalTo: commentImageView.heightAnchor).isActive = true
        self.commentsCountLabel.topAnchor.constraint(equalTo: commentImageView.topAnchor).isActive = true
        self.commentsCountLabel.leftAnchor.constraint(
            equalTo: commentImageView.rightAnchor,
            constant: SizeConstants.smallMargin
        ).isActive = true

        let shareImageView = UIImageView(image: UIImage(named: "share"))
        shareImageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(shareImageView)
        view.addSubview(self.sharesCountLabel)

        shareImageView.widthAnchor.constraint(equalTo: likeImageView.widthAnchor).isActive = true
        shareImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        shareImageView.leftAnchor.constraint(
            equalTo: self.commentsCountLabel.rightAnchor,
            constant: SizeConstants.defaultMargin
        ).isActive = true
        shareImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        self.sharesCountLabel.widthAnchor.constraint(equalToConstant: SizeConstants.socialLabelWidth).isActive = true
        self.sharesCountLabel.heightAnchor.constraint(equalTo: shareImageView.heightAnchor).isActive = true
        self.sharesCountLabel.topAnchor.constraint(equalTo: shareImageView.topAnchor).isActive = true
        self.sharesCountLabel.leftAnchor.constraint(
            equalTo: shareImageView.rightAnchor,
            constant: SizeConstants.smallMargin
        ).isActive = true

        let viewsImageView = UIImageView(image: UIImage(named: "view"))
        viewsImageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(viewsImageView)
        view.addSubview(self.viewsCountLabel)

        self.viewsCountLabel.widthAnchor.constraint(equalToConstant: SizeConstants.socialLabelWidth).isActive = true
        self.viewsCountLabel.heightAnchor.constraint(equalTo: commentImageView.heightAnchor).isActive = true
        self.viewsCountLabel.topAnchor.constraint(equalTo: commentImageView.topAnchor).isActive = true
        self.viewsCountLabel.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        viewsImageView.widthAnchor.constraint(equalTo: likeImageView.widthAnchor).isActive = true
        viewsImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        viewsImageView.rightAnchor.constraint(
            equalTo: self.viewsCountLabel.leftAnchor,
            constant: -SizeConstants.smallMargin
        ).isActive = true
        viewsImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        return view
    }()

    private let anchorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [self.headerView, self.postLabel, self.anchorView, self.socialView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = SizeConstants.defaultSpacing
        return view
    }()

    private var shrunk = true

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    @objc func onButtonPressed() {
        postLabel.numberOfLines = 0
        stackView.removeArrangedSubview(showFullPostButton)
        showFullPostButton.removeFromSuperview()
        delegate?.onButtonPressed()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.insetBy(dx: SizeConstants.defaultSpacing, dy: SizeConstants.defaultSpacing)

        if shrunk && postLabel.lines > 8 {
            postLabel.numberOfLines = 6
            if let postViewIndex = stackView.arrangedSubviews.firstIndex(of: postLabel) {
                stackView.insertArrangedSubview(showFullPostButton, at: postViewIndex + 1)
            }
            shrunk = false
        }

        let imageViews = images.map { UIImageView(image: $0) }
        imageViews.enumerated().forEach {
            $0.element.contentMode = .scaleAspectFill
            $0.element.frame = CGRect(
                x: CGFloat($0.offset) * contentView.bounds.width,
                y: 0,
                width: contentView.bounds.width,
                height: SizeConstants.scrollViewHeight
            )
            scrollView.contentSize.width += $0.element.bounds.width
            scrollView.addSubview($0.element)
        }
        scrollView.contentSize.height = SizeConstants.scrollViewHeight
    }

    func initialize() {
        setupContentView()
        backgroundColor = .clear

        let margins = contentView
        contentView.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        showFullPostButton.addTarget(self, action: #selector(onButtonPressed), for: .touchUpInside)

        scrollView.delegate = self
    }

    func setupContentView() {
        contentView.backgroundColor = .white
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowRadius = 10
        contentView.layer.cornerRadius = 10
    }
}

extension FeedTableViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
}

class PaddingLabel: UILabel {
    var insets = UIEdgeInsets.zero

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
}

extension UILabel {
    var lines: Int {
        guard let text = text else { return 0 }
        let textSize = NSString(string: text).boundingRect(
            with: CGSize(width: intrinsicContentSize.width, height: 0),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return Int(textSize.height / font.lineHeight)
    }
}
