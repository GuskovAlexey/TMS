#!/bin/bash
link=$(curl -s https://myfin.by/bank/kursy_valjut_nbrb)

data(){
  echo $link |  grep 'a href="/bank/kursy_valjut_nbrb/' | sed 's:<a href="/bank/kursy_valjut_nbrb/:\n(&):g' | sed '1d' | sed 's:data-key="[0-9]*"><td>:(&)\n:g' | sed '$d' | sed '/^$/d' | grep -i $1 | awk -F"</td><td>" '{print $2}'
}

menu(){
  select currency
  do
    case $currency in
      Exit)
        exit_state=1
        ;;
      *)
        echo "Exchange rate $currency: " $(data $currency)
        ;;
      *)
        echo "ERROR"
        ;;
    esac
  done
}

PS3="Select currency: "
exit_state=0
while [ $exit_state -eq 0 ]
do
  clear
  menu USD EUR RUB UAH PLN Exit
  sleep 5
done
