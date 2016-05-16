## Installation 

### Carthage
```
github "wh1pch81n/DHConstraintBuilder" "1.0.0"
```

## Coding examples

```swift
// old way
let view = UIView()
let button = UIButton()
let textfield = UITextField()

view.addSubview(button)
view.addSubview(textfield)
button.translateAutoResizingMaskToConstraints = false
textfield.translateAutoResizingMaskToConstraints = false

view.addConstraints(NSLayoutConstraints.constraintsWithVisualFormat("V:[button]-[textfield]", options: NSLayoutFormatOption(rawValue: 0), metrics: nil, views: [ "button" : button, "textfield" : textfield ]))

// DHConstraintsBuilder way
let view2 = UIView()
let button2 = UIButton()
let textfield2 = UITextField()

view2.addConstraints_V(button2 ^-^ textfield2)
```

As you can see from the example above, adding a view as a subview can be inferred and the translateAutoResizingMaskToConstraints property is automatically set to false
