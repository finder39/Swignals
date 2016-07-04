# Swignals

Swignals is an observable pattern system built entirely in Swift.

### Installing

Drag all the files from the Source folder into your project.

### Example

Lets say we wanted to add a swignal to an AudioPlayer class whenever shuffle is set. It could look something like this:

Note: A `typealias` is optional, but it definitely makes it more readable

```swift
/**
    arg1: Bool
*/
typealias OnShuffleChangedSwignal = Swignal1Arg

class AudioPlayer {
    static let sharedInstance = AudioPlayer()

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
        AudioPlayer.sharedInstance.onShuffleChangedSwignal.addObserver(self) { (listener, arg1) in
            Swignal.typeConfirmation(listener: (listener, TracksViewController.self),
                                     arg1: (arg1, Bool.self),
                                     callback: { (typedListener, typedArg1) in
                                     // note: you can rename the variables in the callback such as
                                     // callback: { (weakSelf, shuffle) in
                typedListener.updateViewBasedOnShuffle(typedArg1)
            })
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
