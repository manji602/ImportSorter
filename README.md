ImportSorter
====

## Description

This is a plugin of sorting import declarations for Xcode.

## Install

There are two ways for install this plugin.

### run build script

just paste this on terminal:

```
curl -fsSL http://github.com/manji602/ImportSorter/raw/master/Scripts/install.sh | sh
```

### Build Project On Xcode

First, clone this repository onto your computer and open xcodeproj.

```
$ git clone git@github.com:manji602/ImportSorter.git
$ cd ImportSorter
$ open ImportSorter.xcodeproj
```

Second, build this project and reboot Xcode.

Then, there will be "Import Sorter" option on Xcode "Edit" menu.

## Usage

1.Open source code which you want to sort import declarations on Xcode.

![](https://raw.githubusercontent.com/manji602/ImportSorter/master/Images/usage_figure001.png)

2.Press CTRL + S or select "Sort Import On Current File" option from "Import Sorter" menu.

![](https://raw.githubusercontent.com/manji602/ImportSorter/master/Images/usage_figure002.png)

3.Then, your import declarations will be sorted :)

![](https://raw.githubusercontent.com/manji602/ImportSorter/master/Images/usage_figure003.png)

## Customize

### Customize Import Role

To customize import role of Objective-C, please edit files listed below.

* (1) : `ObjCImportClassRole` in `ObjCClassRole.h`
    * It defines class role of objective-c.
* (2) : `getImportClassRole` in `ObjCClassRole.m`
    * This function categorizes class role.
* (3) : `labelForClassRole` in `ObjCClassRole.m`
    * This function defines a label for each role. This Label must begin with `kClassRoleLabelPrefix`.
* (4) : `lastImportClassRoleIndex` in `ObjCClassRole.m`
    * This function defines last objects of enum you defined in (1).

In case of customizing import role of Swift, please edit `SwiftClassRole.h` and `SwiftClassRole.m`.

## License

This plugin is released under the MIT License. See [LICENSE.txt](http://github.com/manji602/ImportSorter/raw/master/LICENSE.txt).

## Author

[Jun HASHIMOTO](http://github.com/manji602)
