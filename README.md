# Swignals

Swignals is an observable pattern system built entirely in Swift.

### Installing

Drag all the files from the Source folder into your project.

### Example

Lets say we wanted to add a swignal to an AudioPlayer class whenever shuffle is set. It could look something like this:

```swift
typealias OnShuffleChangedSwignal = Swignal1Arg<Bool>

class AudioPlayer {
    static let sharedInstance = AudioPlayer()

    let onShuffleChangedSwignal = OnShuffleChangedSwignal()
    var shuffle: Bool = false {
        didSet {
            onShuffleChangedSwignal.fire(shuffle)
        }
    }
}
```

Then to subscribe to that signal you'd do the following:

```swift
class ControlsViewController: UIViewController {
    init() {
        AudioPlayer.sharedInstance.onShuffleChangedSwignal.addObserver(self) { (observer, arg1) in
        // note: you can rename the variables in the callback such as
        // callback: { (weakSelf, shuffle) in
            if let favoriteTracksDataSource = observer.tracksDataSource as? FavoriteTracksDataSource {
                favoriteTracksDataSource.shuffle = arg1
                favoriteTracksDataSource.refresh()
            }
        }
    }

    func updateViewBasedOnShuffle(shuffle: Bool) {
        // do important things
    }
}
```

## Versioning

Swignals uses [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **Joseph Neuman** - *Initial work*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
