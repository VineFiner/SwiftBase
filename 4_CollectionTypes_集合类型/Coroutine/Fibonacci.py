#!/usr/bin/env python3
#coding=utf-8

# 简单输出斐波那契数列前 N 个数

def fab(max):
	n, a, b = 0, 0, 1
	while n < max:
		print(b)
		a, b = b, a + b
		n = n + 1

fab(5)
# 输出如下
1
2
3
5

# 输出斐波那契數列前 N 个数第二版

def fab2(max): 
   n, a, b = 0, 0, 1 
   L = [] 
   while n < max: 
       L.append(b) 
       a, b = b, a + b 
       n = n + 1 
   return L

for n in fab2(5):
	print(n)


  