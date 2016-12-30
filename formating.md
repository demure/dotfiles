<!--
##### My (demuredemeanor) attempt to codify my formatting
# vim: set expandtab ts=4 sw=4: ## Since this is markdown
# Uses shiftwidth=4 for tabs; foldmarker={{{,}}} for folds;
# https://notabug.org/demure/dotfiles/
# legacy repo http://github.com/demure/dotfiles
-->

## My Formatting ##

### Table of Contents ###
* [File Start](#file-start)
* [Code Block](#code-block)
* [Comments](#comments)
    * [Own Line](#own-line)
    * [Same Line as Code](#same-line-as-code)
    * [Toggling Code](#toggling-code)
* [Indentation](#indentation)
    * [Overall Indents](#overall-indents)
    * ['If' Test Indents](#if-test-indents)
* [Line Spacing](#line-spacing)
    * [Spacing Neighboring Blocks](#spacing-neighboring-blocks)
    * [Spacing Comments](#spacing-comments)

### File Start: ###
* Shell, if shell script
* Info line
    * What this file is
* Settings used on file
* Source code link

    #!/bin/something    ## If relevant
    ##### My (demuredemeanor) attempt to codify my formatting
    # Uses shiftwidth=4 for tabs; foldmarker={{{,}}} for folds;
    # https://gitorious.org/demure/dotfiles/
    # legacy repo http://github.com/demure/dotfiles

### Code Block: ###

* Start
    * Three comment symbols
    * Cap first letters of title words
    * Three comment symbols
    * Vim fold symbol
* Contents
* End
    * Same as start, but add 'End' to title  * Can truncate block name
    * Can truncate block name

    ### Title Block ### {{{
    Contents
    ### End Title ### }}}

### Comments: ###

#### Own line ####
* Two comment symbols and a space
* Capitalize first word of sentence
* Additional lines will use single comment symbol
* Put line preceding of code it is for
* Use Cases:
    * Identity Code
    * Give long description and details
    * If 'short' description can not fit on same line

    ## Some comment...
    # ...and its second line
    some code

#### Same Line as Code ####
* Two comment symbol and a space
* Tab comments evenly inside of code block
    * Preferably matching highest block relevant

    some code           ## Some comment
    some more code      ## Another comment

#### Toggling Code ####
* Comment symbol directly preceding code, to toggle it out

    #echo "some text"       ## Toggled off
    other code              ## Still active

* Long sections can have comment symbol at beginning of line

    #       if
    #           blah
    #         else
    #           blah blah
    #       fi

* Temporary comments may use three, or more, comment symbols
    * May also be use to distinguish between example conf comments

    ###some code            ## disabled for troubleshooting
    other code
    #another line           ## disabled

### Indentation: ###

#### Overall Indents ####
* Child Blocks will be indented one further than parent
* Neighboring Blocks will be on the same indent level

    ### Some Block ### {{{
    content
    ### End Some ### }}}

    ### Another Block ### {{{
    other content
    ### End Another ### }}}

#### 'if' Test Indents ####
* Code will be indented one further than 'if'
* Half indent 'else's... because I like it.

    if
        first
      else
        second
    fi

### Line Spacing: ###

#### Spacing Neighboring Blocks ####
* Neighboring Blocks will be separated by a blank line
    * Nested blocks will not be

    ### Parent Block ### {{{
        ### Child Block ### {{{
        content
        ### End Child ### }}}

        ### Other Nested ### {{{
        other content
        ### End Nested ### }}}
    ### End Parent ### }}}

#### Spacing Comments ####
* Comment lines used to identify a Section will have blank line prior
    * Comment lines used for details/description need not

    if other_test
        echo "for demonstrating below"
    fi

    ## Test for something
    if something
        blah
    fi

* 'Short' descriptions need not have blank line

    some other code
    ## desc of following code
    echo "the really long code is located here"

######Last edit 30DEC2016
