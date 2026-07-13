# Unix Utility `wc` Rewrite


## Features
- Total line count
- Total word count
- Total character count
- Length of longest line


## CLI Usage
`wc [options] [filename]`

```bash
# total line count
wc -l, --lines [filename]

# total word count
wc -w, --words [filename]

# total character count
wc -m, --chars [filename]

# total bytes
wc -c, --bytes [filename]

# longest line
wc -L, --max-line-length [filename]
```


## Example output
```bash
wc notes.txt
  12   45  312 notes.txt

# Order
(lines) (words) (bytes) filename
```
