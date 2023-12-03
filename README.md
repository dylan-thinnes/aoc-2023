Advent of Code, 2023

# aoc-2023
Advent of Code, 2023

These are my advent of code solutions. SPOILERS BEWARE!
In the same way as [last year](https://github.com/dylan-thinnes/aoc-2022),
[the year before that](https://github.com/dylan-thinnes/aoc-2021), and
[the year before that](https://github.com/dylan-thinnes/aoc-2020), I do every
day in a different language.

## Rules

1. Must do all days in different languages, except those days which continue
   from other days' solutions (e.g. IntCode computer, 2019)
2. If I do a day in multiple different languages, I can "pick" the language for
   that day, as long as the resulting picks adhere to rule 1.
3. If I wish to use a language that I have already used, I can go back and redo
   the day that language was previously used for (in a different language),
   thus freeing it up for the new day.
4. Languages cannot be too similar, keeping in spirit of the rules (e.g.
   bash/zsh, typescript/javascript, haskell/purescript [controversial, I know])
5. I may write preprocessors to transform the input into something palatable to
   the language, but generally this is discouraged.

## Summary (spoilers!)

Languages and solutions so far can be got by running `./summarize`.

```
           
    |1|2|3|
awk | |█| |
j   | | |█|
sed |█| | |
```

In my summaries, I will go over the solutions I find more interesting, rather
than detailing each language for each day.

### Day 1: Sed

GNU `sed` is pretty nice. For part 2 I thought of a simple trick so that I only
had to make 10 lines of changes to the Part 1 solution.
