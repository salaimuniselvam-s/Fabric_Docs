# Shell Scripts

- $1 -> means command line arguments first and so on
- -z -> Checks if the size of the argument checked again is zero.
  eg: if [-z $1] -> only true if no args are provided

```
Exit code 0    ->    Success
Exit code 1    ->    General errors, Miscellaneous errors, such as "divide by zero" and other impermissible operations
Exit code 2    ->    Misuse of shell builtins (according to Bash documentation)
```

[2>/dev/null](https://askubuntu.com/questions/350208/what-does-2-dev-null-mean)

```
> file redirects stdout to file
1> file redirects stdout to file

2> file redirects stderr to file

&> file redirects stdout and stderr to file
> file 2>&1 redirects stdout and stderr to file
```

- -y, --yes, --assume-yes -> Automatic yes to prompts; assume "yes" as answer to all prompts and run non-interactively.
- tar -xvzf ./kafka.tgz --strip 1 -> extrct and strip(1) means skip ./
