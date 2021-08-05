# Create-wordlist-domain-v2-with-JS

BB - tools

Very raw development but works for need of hour.

process -
collect domains from wayback and github-endpoints

collect endpoints from wayback and github-endpoints

create wordlist using sprawl

create wordlist folder level.

Tools required -

https://github.com/tehryanx/sprawl

https://github.com/gwen001/github-search/blob/master/github-endpoints.py

https://github.com/tomnomnom/unfurl

https://github.com/003random/getJS

Set the paths https://github.com/vhssunny1/Tools-BB/blob/main/Make_payloads.sh if needed.


Usage - bash Make_payloads.sh target.com

outputs -

domain-full-payloads.txt - when you have decent time.

domain-quick-payloads.txt - folder level fuzz -quick one  # use ffuf with recursion for better results.

domain-alljsfiles.txt - all js files text
 

Note - please use domain name as target.com instead of http/https:target.com



To do -

collect endpoints and folders from JS files.
