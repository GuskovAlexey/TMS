import sys
sys.stdout.encoding
'utf-8'


host = input('Enter your Hostname  ')
username = input('Enter your Username  ')
paswd = input('Enter your Password  ')
try:
    with open('file.txt', 'a+') as file:
        file.seek(0, 2)
        file.write(f"\n Host {host} Username {username} Password {paswd}")
except:
        print("Bad enter, try again ")       
        
find_word = input('Enter hostname which you find  ')
file=open('file.txt','r')
text=file.read()
if find_word in text:
        print(text)
file.close()