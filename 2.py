#coding:utf8

#写一个string.strip（）的替代函数，要右三个功能，去掉一个字符串两边的空白或者只去掉字符串左侧的空白，或者只去掉字符串右边的空白



whitespace = '\t\n\r\v\f'#空白

#接受一个字符串

def myStrip(chs):

   pass

   #去掉左边空白的

def myLstrip(chs):

   if len(chs) == 0:

       return chs

   strlen=len(chs)

   for i in range(strlen):

       if chs[i]  not in whitespace:

           break

       else:

           return chs[i:]

                                            #去掉右边空白的

def myRstrip(chs):

    if len(chs) == 0:

        return chs

     strlen = le(chs)

     for i in range(-1, -(strlen+1), -1):

         if chs[i] not in whitespace:
             break              
         else:

             return ''

         return chs[:i + 1]


if __name__== '__main__':

    mystr = '  hello   '

    print '|' +mystr+ '|'

    print '|' + myLstrip(mystr) + '|'

    print '|' +myRstrip(mystr)+ '|'

