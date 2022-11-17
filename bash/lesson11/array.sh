
#!/bin/bash
x=${1:-3}
echo -e " ${1:-3}x${2:-3} \n "
while [ $x -gt 0 ]; do
y=${2:-3}
while [ $y -gt 0 ]; do
echo -n "$(( RANDOM % 9 + 1)) "
(( y-- ))
done
(( x-- ))
echo -e "\n"
done
echo -e "\n"
