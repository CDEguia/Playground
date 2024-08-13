import turtle as t

t.Screen().setup(800, 800, 1600, 400)
t.screensize(800,800)
#print(t.screensize())
#print(t.window_width()/2,t.window_height()/2)

t.color('cyan')
t.bgcolor('black')

t.hideturtle()
t.penup()
t.speed(0)
t.setx(t.window_width()/3)
t.pendown()

t.speed(0)
b = 200
while b > 0:
    t.left(b)
    t.forward( b * 3)
    b = b - 1

t.Screen().exitonclick()
