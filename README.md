RxDelegateCells
===============

![Swift](https://img.shields.io/badge/Swift-2.2-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/RxDelegateCells.svg)](https://cocoapods.org/pods/RxDelegateCells)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

UITableView Cell Height and UICollectionView Cell Size for RxSwift.

Why
---

If you're using RxSwift with `UITableView` or `UICollectionView`, it is difficult to calculate the cell sizes with `Observable`s. Because `UITableView` requires cell height synchronously, but `Observable`s emit values asynchronously.

For example, assume that we are using MVVM pattern and we have a ViewModel which exposes a `message` with `Driver`. We need an actual message value as a `String` to calculate the cell height. However, since `message` emits values asynchronously, we cannot access the actual value synchronously.

```swift
struct MyCellModel {
    let message: Driver<String>
}

func tableView(tableView: UITableView, heightForRowAtIndexPath: NSIndexPath) -> CGFloat {
    let cellViewModel = self.dataSource.itemAtIndexPath(indexPath)

    cellModel.message // (1) This is `Driver<String>`
        .map { message -> CGFloat in
            let size = CGSize(width: tableView.width - 20, height: .max)
            let options: NSStringDrawingOptions = [.UsesLineFragmentOrigin, .UsesFontLeading]
            let attributes = [NSFontAttributeName: MyCell.Font.messageLabel]
            let rect = message.boundingRectWithSize(size, options: options, attributes: attributes, context: nil)
            return ceil(rect.height) + 20 // (2) We want return this value (async)
        }

    return 40 // (3) But we have to return actual value here, synchronously :(
}
```

At a Glance
-----------

RxDelegateCells makes it available to use `Driver<CGFloat>` as a UITableView cell height and `Driver<CGSize>` as a UICollectionView cell size.

This code makes the cell heights 40, 80 and 120.

```swift
Driver.just([[.just(40), .just(80), .just(120)]])
    .drive(self.tableView.rx_cellHeightWithDelegate(delegate))
    .addDisposableTo(self.disposeBag)
```

<img alt="rxdelegatecells" src="https://cloud.githubusercontent.com/assets/931655/16463094/3a2c2516-3e6f-11e6-94af-b4bb50ba263f.png" width="300">

You can find a real-world example at [here](https://github.com/devxoul/RxDelegateCells/tree/master/Example).


Installation
------------

- **For iOS 8+ projects** with [CocoaPods](https://cocoapods.org):

    ```ruby
    pod 'RxDelegateCells', '~> 0.1'
    ```

- **For iOS 8+ projects** with [Carthage](https://github.com/Carthage/Carthage):

    ```
    github "devxoul/RxDelegateCells" ~> 0.1
    ```

- **For iOS 7 projects** with [CocoaSeeds](https://github.com/devxoul/CocoaSeeds):

    ```ruby
    github 'devxoul/RxDelegateCells', '0.1.0', :files => 'Sources/**/*.swift'
    ```

- **Using [Swift Package Manager](https://swift.org/package-manager)**:

    ```swift
    import PackageDescription

    let package = Package(
        name: "MyAwesomeApp",
        dependencies: [
            .Package(url: "https://github.com/devxoul/RxDelegateCells", "0.1.0"),
        ]
    )
    ```


License
-------

**RxDelegateCells** is under MIT license. See the [LICENSE](LICENSE) file for more info.
