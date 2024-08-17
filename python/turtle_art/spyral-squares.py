####################################################
#
# Spiral drawing using "squares"
#
####################################################
import turtle as t

screen_size=[900,900]
# Setup Viewport/Window Screen
t.Screen().setup(*screen_size, 1600, 400)
t.screensize(*screen_size)
#print(t.screensize())
#print(t.window_width()/2,t.window_height()/2)

# Setup colors
t.color('cyan')
t.bgcolor('black')

# Set Starting Point
t.hideturtle()
t.penup()
t.speed(0)
t.setx(-t.window_width()/3)
t.sety(-t.window_width()/3)

# Draw!!!!
t.pendown()
b = 200
while b > 0:
  t.forward( b * 3)
  t.left(90) if b % 2 == 0 else t.left(85) 
  b = b - 1

# Close Window on click
t.Screen().exitonclick()
