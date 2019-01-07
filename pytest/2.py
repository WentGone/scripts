#!/usr/bin/env python3
fl1 = []
fl2 = []
with open('a.txt','r') as f1:
    data1 = f1.readlines()
    for item1 in data1:
        fl1.append(item1.strip('\n').split("  "))
    print(fl1)
with open('b.txt','r') as f2:
    data2 = f2.readlines()
    for item in data2:
        fl2.append(item.strip('\n').split("  "))
    print(fl2)

for i in range(len(fl1)):
    for j in range(len(fl2)):
        if fl2[j][0] == fl1[i][0]:
            fl1[i].append(fl2[j][1])
print(fl1)
