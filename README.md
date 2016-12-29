# DHConstraintBuilder 
![iOS Compatibility](https://img.shields.io/badge/iOS%20-8%2B-green.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

DHConstraintBuilder is a light-weight layout framework which wraps AutoLayout with a nicer, semi-WYSIWYG syntax.  This API provides a chainable way of describing your NSLayoutConstraints which results in layout code that is more concise and readable.

## Installation 

### Carthage
```
github "wh1pch81n/DHConstraintBuilder" "1.0.0"
```

# What is wrong with NSLayoutConstraints?

Auto-Layout is a powerful and flexible way of organizaing and laying out your views.  However, it is much to verbose.  While the Visual Formatting API helps, it isn't always the best.  Thanks to swift we can reduce boiler-plate code and only write what is necessary.

Suppose you have your views set up like the picture below. (I have annotated the image with magenta icons to visually show where we need to add constraints.)

![alt text](https://github.com/wh1pch81n/DHConstraintBuilder/blob/master/ViewExample.png)

DHConstraintBuilder can express the layout like this:
```swift
view_cb.addConstraints(() |-^ greenView_cb ^-^ 15.5 ^-^ redView_cb ^-| ()).H
view_cb.addConstraints(() |-^ blueView_cb ^-| ()).H
		
view_cb.addConstraints(() |-^ greenView_cb ^-^ blueView_cb ^-| ()).V
view_cb.addConstraints(() |-^ redView_cb ^-^ blueView_cb).V

view_cb.addConstraints(greenView_cb.lengthEqual(to: redView_cb)).H
view_cb.addConstraints(greenView_cb.lengthEqual(to: blueView_cb)).V
```

The equivalent using NSLayoutConstraint.constraints(withVisualFormat:options:metrics:views:) would look like this:

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

Notice how NSLayoutConstraint is very long.  DHConstraintBuilder automatically sets translatesAutoresizingMaskIntoConstraints to NO and automatically adds the view to its parent view.
