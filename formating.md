<!--
##### My (demuredemeanor) attempt to codify my formatting
# Uses shiftwidth=4 for tabs; foldmarker={{{,}}} for folds;
# https://gitorious.org/demure/dotfiles/
# legacy repo http://github.com/demure/dotfiles
-->
My Formatting
===

File Start:
---
1. Shell, if shell script
2. Info line
	A. What this file is
3. Settings used on file
4. Source code link

```
#!/bin/something	# If relevant
##### My (demuredemeanor) attempt to codify my formatting
# Uses shiftwidth=4 for tabs; foldmarker={{{,}}} for folds;
# http://github.com/demure/dotfiles
```


Code Block:
---
1. Start
	A. Three comment symbols
	B. Cap first letters of title's words
	C. Three comment symbols
	D. Vim fold symbol
2. Contents
3. End
	A. Same as start, but add 'End' to title
	B. Can truncate block name
	
```
### Title Block ### {{{
Contents
### End Title ### }}}
```


Comments
---
1. Own line
	A. Two comment symbols and a space
	B. Capitalize first word of sentence
	C. Additional lines will use single comment symbol
	D. Put line preceding of code it is for
	E. Use Cases:
		* Identity Code
		* Give long description and details
		* If 'short' description can't fit on same line

	```
	## Some comment...
	# ...and it's second line
	some code
	```

2. Same line as code
	A. One comment symbol and a space
	B. Tab comments evenly inside of code block
		* Preferably matching highest block relevant

	
	```
	some code			# Some comment
	some more code		# Another comment
	```

3. Toggling code
	A. Comment symbol directly preceding code, to toggle it out
	
		```
		#echo "some text"		# Toggled off
		other code				# Still active
		```
		
	B. Long sections can have comment symbol at beginning of line

		```
		#		if
		#			blah
		#		  else
		#			blah blah
		#		fi
		```


Indentation:
---
1. Overall indents
	A. Child Blocks will be indented one further than parent
	B. Neighboring Blocks will be on the same indent level

	```
	### Parent Block ### {{{
		### Child Block ### {{{
		content
		### End Child ### }}}

		### Other Nested ### {{{
		other content
		### End Nested ### }}}
	### End Parent ### }}}
	```

2. 'If' test indents
	A. Half indent 'else's... because I like it.

	```
	if
		first
	  else
		second
	fi
	```


Line Spacing:
---
1. Neighboring Blocks will be separated by a blank line
	A. Nested blocks will not be

	```		
	### Parent Block ### {{{
		### Child Block ### {{{
		content
		### End Child ### }}}

		### Other Nested ### {{{
		other content
		### End Nested ### }}}
	### End Parent ### }}}
	```

2. Comment lines used to identify a Section will have blank line prior
	A. Comment lines used for details/desc need not
	
		```
		if other_test
			echo "for demonstrating below"
		fi
	
		## Test for something
		if something
			blah
		fi
		```
		
	B. 'Short' descriptions need not have blank line
	
		```
		some other code
		## desc of following code
		echo "the really long code is located here"
		```
