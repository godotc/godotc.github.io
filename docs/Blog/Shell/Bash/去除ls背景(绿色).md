1. Change .bashrc
```shell

# remove the background color to improve the reading experience.
eval "$(dircolors -p | \
    sed 's/ 4[0-9];/ 01;/; s/;4[0-9];/;01;/g; s/;4[0-9] /;01 /' | \
    dircolors /dev/stdin)"


```

2.

-   `bash`
-   `dircolors -p | sed 's/;42/;01/' > ~/.dircolors`
-   `source ~/.bashrc`