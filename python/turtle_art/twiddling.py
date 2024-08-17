#########################################
#
# https://www.reddit.com/r/Python/comments/av1wft/turtle_twiddling_for_those_of_you_who_asked_d/
#
#
#########################################
import turtle as t
import math as m

screen_size=[900,900]
# Setup Viewport/Window Screen
t.screensize(*screen_size)

tur = t.Turtle()
sc = t.Screen()

sc.setup(*screen_size, 1600, 400)

#lengths=[25,50,100]
#lengths=[50,100,200]
#lengths=[100,200,300]
lengths=[200,300,400]

def setup():
# Setup colors
  tur.speed(0)
  sc.bgcolor('black')
  tur.color('cyan')
  tur.hideturtle()
  # Start position
  tur.penup()
  tur.goto(lengths[0]*m.sin(m.radians(0)),lengths[1]*m.cos(m.radians(0)))
  tur.pendown()

def draw(_x=None, _y=None):
  sc.resetscreen()
  setup()

  for i in range(365):
    tur.goto(lengths[0]*m.sin(m.radians(i)),lengths[1]*m.cos(m.radians(i)))
    tur.goto(lengths[1]*m.sin(m.radians(i)),lengths[2]*m.cos(m.radians(i)))
    tur.goto(lengths[2]*m.sin(m.radians(i)),lengths[0]*m.cos(m.radians(i)))

sc.onclick(draw)
#while True:
#  draw()
sc.mainloop()
