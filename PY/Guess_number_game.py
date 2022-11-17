import random
import time
 
player_name = input('Привет, укажи свое имя? ').capitalize()
print(f'Давай сыграем в игру, {player_name}, я загадываю число от 1 до 30, а ты попробуй угадать.')
score = {'ИИ': 0, player_name: 0}
time.sleep(2)
 
 
def game_function(score_npc, score_player):
    random_number = random.randint(1, 30)
 
    for cycle in range(1, 5):
        player_number = input('Давай начнем, введи число: ')
        time.sleep(random.randint(1, 3))
        if player_number == 'x':
            break
        try:
            player_number = int(player_number)
        except ValueError:
            print('Нужно ввести целое число!')
            break
        if player_number == random_number:
            score_player += 1
            print(f'Отлично, {player_name}! Ты победил с {str(cycle)} попытки ')
            break
        elif cycle == 5 and player_number != random_number:
            score_npc += 1
            print(f' {player_name} ты не справился за 5 попыток... я выбирал число {random_number}')
            break
        elif player_number > random_number:
            print("Введенное число больше.\n")
        elif player_number < random_number:
            print("Введенное число меньше.\n")
 
    def menu_function():
        quest = input('Сыграем ещё? y/n ')
        if quest == 'y':
            print(f'Отлично, {player_name}, я загадал новое число от 1 до 30.\n')
            game_function(score_npc, score_player)
        elif quest == 'n':
            print(f'Твой счёт: {player_name}: {score_player},  ИИ: {score_npc}')
            if score_npc > score_player:
                print(f'Судя по очкам, {player_name}, я выиграл =)')
            if score_npc < score_player:
                print(f'Судя по почкам, {player_name}, ты выиграл o_0')
            if score_npc == score_player:
                print(f' Судя по очкам, {player_name}, у нас ничья! =)')                
        else:
            menu_function()
 
    menu_function()
 
 
game_function(score['ИИ'], score[player_name])
print(f'Спасибо за игру, {player_name}')
