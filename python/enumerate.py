this_list= []
for x in range(1600):
    this_list.append((x,x+1))
for y in enumerate(this_list):
    print(y,end=",")