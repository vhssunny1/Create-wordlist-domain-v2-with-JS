# wordlist from waybackurls and github-endpoints, JS scan

mkdir $1 
cd $1 
echo $1 | waybackurls |grep -v "*" | grep -v "@" | grep -v "," | grep -v -e '^$' | tee -a $1-wordlist-master.txt
python3 github-endpoints.py -d $1 | grep -a -i $1 | tee -a $1.github.txt

#collecting subdomains - wayback , endpoints

cat $1.github.txt | unfurl domains | sort -u |  tee -a $1.subdomains.txt
cat $1-wordlist-master.txt | unfurl domains | sort -u |  tee -a $1.subdomains.txt
cat $1.subdomains.txt | sort -u | grep $1 |  tee -a $1.final-subdomains.txt

# end of collection

echo " collect js from wayback and endpoint"

cat $1-wordlist-master.txt | grep '.js$' | tee $1-js.txt
cat $1.final-subdomains.txt | httpx | getJS --input $1-js.txt --complete --resolve --insecure --output $1.jsfiles.txt
cat $1.jsfiles.txt | grep $1 | sort -u | tee -a $1.alljsfiles.txt

echo "end of js collection"

#creating wordlist

cat $1.final-subdomains.txt | waybackurls |grep -v "*" | grep -v "@" | grep -v "," | grep -v -e '^$' | tee -a $1-wordlist-master.txt
cat $1-wordlist-master.txt | sort -u | unfurl paths |  sed "s/\///1" | sort -u | grep -v '.jpg$' | grep -v '.jpeg$'| grep -v '.png$' | grep -v '.gif$'| grep -v -e '^$' | tee -a $1-wordlist.txt
cat $1-wordlist.txt | ./sprawl.py -s | tee -a $1-payloads.txt

#python3 github-endpoints.py -d $1 | grep -a -i $1 | tee -a $1.github.txt 
cat $1.github.txt | unfurl paths |  ./sprawl.py -s |  tee -a $1-payloads.txt 

cat $1-payloads.txt | cut -d "/" -f 2,3,4,5,6  | sort -u | tee -a $1-full-payloads.txt
cat $1-full-payloads.txt  |  cut -d "/" -f 2 | sort -u | tee -a $1-quick-payloads.txt 


rm $1.github.txt
rm $1-wordlist.txt
rm $1-payloads.txt
rm $1-wordlist-master.txt
rm $1.subdomains.txt
rm $1-js.txt
rm $1.jsfiles.txt

#end of creating word list 

