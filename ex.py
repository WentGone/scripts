#!/usr/bin/env python3
import xlrd

data = xlrd.open_workbook('grade.xls')
print(data)

tables = data.sheets()
print(tables)

for i in range(len(tables)):
    table = tables[i]
    nrows = table.nrows
    print('%s表有%s行' % (table.name, nrows))

for i in range(len(tables)):
    table = tables[i]
    nrows = table.nrows
    values = table.row_values
    print(nrows, values)
    if i == 0:
        print(values(0))
        for j in range(1, nrows):
            value = values(j)
            value[0] = int(value[0])
            print(value)
    if i == 1:
        print(values(0))
        for j in range(1, nrows):
            value = values(j)
            value[0] = int(value[0])
            value[2] = int(value[2])
            print(value)
            
#二表合一
table_student = tables[0]
table_grade = tables[1]
table_student_head = table_student.row_values(0)
table_grade_head = table_grade.row_values(0)
print(table_student_head)
print(table_grade_head)
#得到总表表头
table_total_head = table_student_head + table_grade_head[1:3]
print(table_total_head)

nrows_stu = table_student.nrows
nrows_gra = table_grade.nrows
#print(nrows_stu, nrows_gra)

values_stu = table_student.row_values
values_gra = table_grade.row_values

each = []
total_list = []
for i in range(1, nrows_stu):
    #print(values(i))
    each_stu = values_stu(i)
    for j in range(1, nrows_gra):
        each_gra = values_gra(j)
        #print(each_gra[1:])
        if each_stu[0] == each_gra[0]:
            each = each_stu + each_gra[1:]
            each[0] = int(each[0])
            each[4] = int(each[4])
            total_list.append(each)
            print(each)
#print(total_list)

#求每个学生的总分
table_student = tables[0]
table_grade = tables[1]

nrows_stu = table_student.nrows
nrows_gra = table_grade.nrows

values_stu = table_student.row_values
values_gra = table_grade.row_values

for i in range(1, nrows_stu):
    #print(values_stu(i))
    stu_id = int(values_stu(i)[0])
    stu_name = values_stu(i)[1]
    #print(stu_name)
    total_grade = 0
    for j in range(1, nrows_gra):
        if stu_id == int(values_gra(j)[0]):
            total_grade += int(values_gra(j)[2])
        else:
            continue
    print('%s的总分是%s' % (stu_name, total_grade))
    
#求总分并且按照分数排序
table_student = tables[0]
table_grade = tables[1]

nrows_stu = table_student.nrows
nrows_gra = table_grade.nrows

values_stu = table_student.row_values
values_gra = table_grade.row_values

total_dic = {}
for i in range(1, nrows_stu):
    stu_id = int(values_stu(i)[0])
    stu_name = values_stu(i)[1]
    total_grade = 0
    for j in range(1, nrows_gra):
        if stu_id == int(values_gra(j)[0]):
            total_grade += int(values_gra(j)[2])
        else:
            continue
    total_dic[stu_name] = total_grade
print(total_dic)
print(sorted(total_dic.items(), key=lambda x:x[1], reverse=True))

#找出不及格的学生

table_student = tables[0]
table_grade = tables[1]

nrows_stu = table_student.nrows
nrows_gra = table_grade.nrows

values_stu = table_student.row_values
values_gra = table_grade.row_values

for i in range(1, nrows_gra):
    if int(values_gra(i)[2]) < 60:
        #print(values_gra(i))
        stu_id =  int(values_gra(i)[0])
        #print(stu_id)
        stu_obj = values_gra(i)[1]
        stu_gra = int(values_gra(i)[2])
        for j in range(1, nrows_stu):
            if stu_id == int(values_stu(j)[0]):
                stu_name = values_stu(j)[1]
                #print(stu_name)
                print('%s的%s科目得%s分，不及格' % (stu_name, stu_obj, stu_gra))
