import sys
sys.stdout.encoding
'utf-8'


def write():
        host = input('Enter your Hostname  ')
        username = input('Enter your Username  ')
        paswd = input('Enter your Password  ')
        try:
           with open('file.txt', 'a+') as file:
                file.seek(0, 2)
                file.write(f"\n Host {host} Username {username} Password {paswd}")
        except:
                print("Bad enter, try again ")       
        menu()

def read():
        find_word = input('Enter what you find  ')
        file = open('file.txt','r')
        text = file.read()
        if find_word in text:
                print(text)
        file.close()
        menu()

def menu():
        question = input ("1.Read or 2. Write 3.Exit?  ")
        if question == "1":
                read()
        if question == "2":
                write()
        else:
                print("Exit")

menu()

