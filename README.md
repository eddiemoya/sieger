sieger
======

Bash script that automates multiple siege tests from a JSON config file.

Needs a bunch of cleanup and documentation, and more context as to how to get it running. 

The json file needs to be in a folder in your home directory - or just change the path.
I have a version that lets you pass the file as a parameter, Ill update at a later point.

JSAWK uses JSONQuery to parse through the JSON object in the file. 
http://stackoverflow.com/questions/1955505/parsing-json-with-sed-and-awk

JSONQuery is not the simplest thing to use, heres some articles on that.
http://www.sitepen.com/blog/2008/07/16/jsonquery-data-querying-beyond-jsonpath/

I may consider using Backbone.js CLI instead, or even JSONLint.
https://github.com/zaach/jsonlint

Or underscore, or any of the other many things that might be eazier to use to parse json in bash.
