//
//  TaskWidgetListFlowLayout.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

final class TaskWidgetListFlowLayout:  UICollectionViewFlowLayout {

    // MARK: - Nested Types

    enum Element: String {
        case widget
    }

    // MARK: - Properties

    weak var delegate: TaskWidgetListFlowLayoutDelegate?
    var cachedAttributes: [Element: [TaskWidgetLayoutAttributes]] = [:]
    var contentHeight: CGFloat = 0.0
    var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return .zero
        }
        return collectionView.bounds.width - contentInset.horizontal
    }
    var contentInset: UIEdgeInsets {
        return collectionView?.contentInset ?? .zero
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    override class var layoutAttributesClass: AnyClass {
        return TaskWidgetLayoutAttributes.self
    }

    // MARK: - Private properties

    private var insertingIndexPaths: [IndexPath] = []
    private var deletingIndexPaths: [IndexPath] = []

    // MARK: - Initialization

    override init() {
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Deinitialization

    deinit {
        cachedAttributes.removeAll()
        insertingIndexPaths.removeAll()
        deletingIndexPaths.removeAll()
    }

    // MARK: - Lifecycle

    override func prepare() {
        guard
            cachedAttributes.isEmpty,
            let collectionView = collectionView
        else { return }
        prepareCash()

        contentHeight = contentInset.top
        for section in 0 ..< collectionView.numberOfSections {
            for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                prepareElement(
                    .widget,
                    at: IndexPath(item: item, section: section)
                )
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var resultLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for (_, layoutAttributes) in cachedAttributes {
            resultLayoutAttributes.append(
                contentsOf: layoutAttributes.filter { $0.frame.intersects(rect) }
            )
        }
        return resultLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[.widget]?.first(where: { indexPath == $0.indexPath })
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let kind = Element(rawValue: elementKind) else {
            return nil
        }
        return cachedAttributes[kind]?.first(where: { $0.indexPath == indexPath })
    }

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let kind = Element(rawValue: elementKind) else {
            return nil
        }
        return cachedAttributes[kind]?.first(where: { $0.indexPath == indexPath })
    }

    override func invalidateLayout() {
        cachedAttributes.removeAll(keepingCapacity: true)
        insertingIndexPaths.removeAll(keepingCapacity: true)
        deletingIndexPaths.removeAll(keepingCapacity: true)
        contentHeight = 0
        super.invalidateLayout()
    }

    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)

        for update in updateItems {
            switch update.updateAction {
            case .delete:
                if let indexPath = update.indexPathBeforeUpdate {
                    deletingIndexPaths.append(indexPath)
                }
            case .insert:
                if let indexPath = update.indexPathAfterUpdate {
                    insertingIndexPaths.append(indexPath)
                }
            default:
                break
            }
        }
    }

    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        insertingIndexPaths.removeAll()
        deletingIndexPaths.removeAll()
    }

    // MARK: - Private functions

    private func setup() {
        minimumInteritemSpacing = 8
        minimumLineSpacing = 8
    }

    private func prepareCash() {
        cachedAttributes[.widget] = []
    }

    private func prepareElement(
        _ element: Element,
        at indexPath: IndexPath
    ) {
        let layoutAttributes = TaskWidgetLayoutAttributes(
            element: element,
            with: indexPath
        )
        prepareLayoutAttributes(
            layoutAttributes,
            for: element
        )
        cachedAttributes[element]?.append(layoutAttributes)
        contentHeight = max(contentHeight, layoutAttributes.frame.maxY)
    }

    private func prepareLayoutAttributes(
        _ layoutAttributes: TaskWidgetLayoutAttributes,
        for element: Element
    ) {
        layoutAttributes.frame.origin = CGPoint(
            x: contentInset.left,
            y: contentHeight + minimumInteritemSpacing
        )
        layoutAttributes.textInsets = WidgetTextInsets(
            titleInsets: .init(top: 16, left: 16, bottom: .zero, right: 16),
            descriptionInsets: .init(top: 12, left: 16, bottom: 16, right: 16),
            timeIntervalInsets: .init(top: 16, left: 12, bottom: .zero, right: 16),
            doneButtonInsets: .init(top: 16, left: 12, bottom: 16, right: 16)
        )
        layoutAttributes.cornerRadius = 12
        layoutAttributes.roundedCorners = .allCorners
        layoutAttributes.frame.size = delegate?.flowLayout(
            self,
            sizeForWidgetAt: layoutAttributes.indexPath,
            with: layoutAttributes.textInsets
        ) ?? .zero
    }
}
