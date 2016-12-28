# DHConstraintBuilder 
![iOS Compatibility](https://img.shields.io/badge/iOS%20-8%2B-green.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Installation 

### Carthage
```
github "wh1pch81n/DHConstraintBuilder" "1.0.0"
```

# What does DHConstraintBuilder look like in action?

You can make constraints like this one:

![alt text](https://github.com/wh1pch81n/BoxyBoxy/blob/master/ViewExample.png)
<script src="https://gist.github.com/nisrulz/11c0d63428b108f10c83.js"></script>
Using code like this:
```swift
view_cb.addConstraints(() |-^ greenView_cb ^-^ 15.5 ^-^ redView_cb ^-| ()).H
view_cb.addConstraints(() |-^ blueView_cb ^-| ()).H
		
view_cb.addConstraints(() |-^ greenView_cb ^-^ blueView_cb ^-| ()).V
view_cb.addConstraints(() |-^ redView_cb ^-^ blueView_cb).V

view_cb.addConstraints(greenView_cb.lengthEqual(to: redView_cb)).H
view_cb.addConstraints(greenView_cb.lengthEqual(to: blueView_cb)).V
```

The equivalent using NSLayoutConstraint.constraintsWithVisualFormat(_ :options:metrics:views) would look like this:

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

view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[greenView]-15.5-[redView]-|"
                                                      , options: NSLayoutFormatOptions(rawValue: 0)
                                                      , metrics: nil, views: viewDict))
view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[blueView]-|"
                                                      , options: NSLayoutFormatOptions(rawValue: 0)
                                                      , metrics: nil, views: viewDict))
view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[greenView]-[blueView]-|"
                                                      , options: NSLayoutFormatOptions(rawValue: 0)
                                                      , metrics: nil, views: viewDict))
view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[redView]-[blueView]-|"
                                                      , options: NSLayoutFormatOptions(rawValue: 0)
                                                      , metrics: nil, views: viewDict))
greenView_vf.widthAnchor.constraint(equalTo: redView_vf.widthAnchor).isActive = true	
greenView_vf.heightAnchor.constraint(equalTo: blueView_vf.heightAnchor).isActive = true
```
