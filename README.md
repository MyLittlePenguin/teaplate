# Teaplate

Teaplate is a Neovim plugin that allows to specify a directory containing template files
(teaplates) and using them via a shortcut.

## Requirements

This should work with Neovim 0.9.5 and above.
Earlier versions might work as well but have not been tested.

If you use Windows you are probably out of luck. 
If any Windows-User wants to add support, feel free to create a pull request.

## Installation

Just use your favorite plugin manager. If you use Packer, you can do the following:

```
use {"MyLittlePenguin/teaplate"}
```

## Configuration

In your Neovim config you have to call:

```
require("teaplate").setup({
  templateDir = "path/to/your/templates",
  mappingPrefix = ",",
  windowWidth = 30
})
```

The parameters mappingPrefix and windowWidth are optional and must only be specified
if the should differ from the default.

## Usage

To use any of the teaplates you only have to type in normal mode the mappingPrefix
followed by the name of the template file.
```
,template.name
```

The content of the template will then be inserted at the current line.

The following Commands have been specified for more interactive use:

```
// reloads the specified template-dirs contents
:TeaHarvest

// display the currently loaded templates inside a floating window
:TeaAssortment

// closes the display of currently loaded templates
:HideTeaAssortment
```

If you open the TeaAssortment you can just navigate the teaplates the normal way
and select any by pressing Enter. The window will be closed and the content
of the template will be inserted at the current line.
