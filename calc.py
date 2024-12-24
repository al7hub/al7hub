a = int(input('a: '))
x = input(': ')
b = int(input('b: '))
if x == "+" :
  print(a+b)
elif x =="-" :
  print(a-b)
elif x =="*" :
  print(a*b)
elif x =="**" :
  print(a**b)
elif x =="pow" :
  print(a**b)
elif x =="" :
  print(a**b)
elif x =="/":
  if b:
    print(a/b)
  else:
    print("Деление на 0!")