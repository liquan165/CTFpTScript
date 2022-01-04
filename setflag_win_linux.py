#!/usr/bin/env python
# -*- coding:UTF-8 -*-
import sys
import random
import string
 
num="1234567890"
list=string.ascii_lowercase+num
#print (random.choice(list))
 
#生成无序flag,英文小写&数字
flag_num =int(input("flag num"))
for i in range(flag_num):
	def flag_generate():
		g = ''
		for n in range(20):
			for i in random.choice(list):
				g = g+str(i)
				if len(g)>19:
					global flag
					flag=g
		flag_file(flag)
 
	def flag_file(flag):
		name=''
		for long in range(10):
			for i in random.choice(list):
				name=name+str(i)
	#            name_list=name_list.append(str(name))
				if len(name)>9:
					global file_name
					file_name='李泉%s.txt'%name
					print(file_name)
		with open(file_name,'w')as f:
			f.write(flag)
 
	flag_generate()