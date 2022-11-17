#!/bin/bash

login=`cat logpswd.txt | sed -n 1p`
password=`cat logpswd.txt | sed -n 2p`

page=`curl -o 2_test.txt 'https://seasonvar.one/' \
  -H 'authority: seasonvar.one' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'cookie: _ym_uid=1664172099198001069; _ym_d=1664172099; _ym_isad=2; PHPSESSID=77aquniqjtj39r7aa9eku4dhvh' \
  -H 'origin: https://seasonvar.one' \
  -H 'referer: https://seasonvar.one/' \
  -H 'sec-ch-ua: "Google Chrome";v="105", "Not)A;Brand";v="8", "Chromium";v="105"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36' \
  --data-raw "login_name=$login&login_password=$password&login=submit" \
  --compressed`
  
Enter=`cat 2_test.txt | sed -n '/.*modal-login">/s///p' | sed 's/<\/a>/ /' | tr '[:space:]' '[\n*]' | sed -n 1p`

Profile=`cat 2_test.txt | sed -n '/.*https:\/\/seasonvar.one\/user\//s///p' | sed 's/\/">/ /' | tr '[:space:]' '[\n*]' | sed -n 1p`

echo "Login ok $Enter  profile $Profile "

rm 2_test.txt
