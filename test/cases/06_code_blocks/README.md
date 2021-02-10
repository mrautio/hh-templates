---
title: "Test case?"
author: "John Doe"
date: "20.01.1970"
course: "ICT1TA1337 test case"

---

# Code blocks

```
Intention of using code blocks
Is to be able to have some cool monospace
stuff in the text!



Just like this.
```

## Shell script

```sh
pandoc --from markdown --template hhtemplate.tex --filter pandoc-fignos --filter pandoc-citeproc --pdf-engine=xelatex --listings -o report.pdf report.md
```

## Javascript

```javascript
for (var i = 0; i < 10; i++) {
	console.log("Here we go: " + i);
}

alert("Check this out!"); // Comments are cool
```

## HTML

```html
<html>
<head>
<title>nothing special</title>
</head>
<body>
<h1>lol</h1>
Definitely not XHTML<br>
</body>
</html>
```

