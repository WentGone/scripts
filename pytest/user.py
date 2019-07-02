#!/usr/bin/env python3
def user(ulist='/etc/passwd'):
    users = []
    with open(ulist,'r') as fobj:
        data = fobj.readlines()
        for line in data:
            user=line.split(":")[0]
            users.append(user)

    return users



if __name__ == '__main__':
    username = input('Entry:')
    users = user()
    if username in users:
        print('exist')
    else:
        print('not exist')
    
