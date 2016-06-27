## Installation 

### Carthage
```
github "wh1pch81n/DHConstraintBuilder" "1.0.0"
```

# What does DHConstraintBuilder look like in action?

You can make constraints like this one:

![alt text](https://github.com/wh1pch81n/BoxyBoxy/blob/master/ViewExample.png)

Using code like this:
```swift
view_cb.addConstraints(.H, () |-^ greenView_cb ^-^ 15.5 ^-^ redView_cb ^-| ())
view_cb.addConstraints(.H, () |-^ blueView_cb ^-| ())

view_cb.addConstraints(.V, () |-^ greenView_cb ^-^ blueView_cb ^-| ())
view_cb.addConstraints(.V, () |-^ redView_cb ^-^ blueView_cb)

view_cb.addConstraints(.H, DHConstraintBuilder(greenView_cb, lengthRelativeToView: redView_cb))
view_cb.addConstraints(.V, DHConstraintBuilder(greenView_cb, lengthRelativeToView: blueView_cb))
```

The eqivalent using NSLayoutConstraint.constraintsWithVisualFormat(_ :options:metrics:views) would look like this:

```
let viewArray = [
	greenView_vf,
	redView_vf,
	blueView_vf
]
viewArray.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
viewArray.forEach(view_vf.addSubview)
let viewDict = [
	"greenView" : greenView_vf,
	"redView" : redView_vf,
	"blueView" : blueView_vf
]
view_vf.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[greenView]-15.5-[redView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
view_vf.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[blueView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))

view_vf.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[greenView]-[blueView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))

view_vf.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[redView]-[blueView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))

greenView_vf.widthAnchor.constraintEqualToAnchor(redView_vf.widthAnchor).active = true
greenView_vf.heightAnchor.constraintEqualToAnchor(blueView_vf.heightAnchor).active = true
```

As you can see from the example above, adding a view as a subview can be inferred and the translateAutoResizingMaskToConstraints property is automatically set to false
