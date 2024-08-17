import turtle
import math
import random


class Explosion:
  def __init__(self, x, y, screen2):
    self.x = x
    self.y = y
    self.p= []
    self.dir = []
    self.s = []
    self.screen = screen2
    self.t = 2 # Seconds on screen
    self.turtle = turtle.Turtle()
    self.turtle.color("cyan")
  
    self.turtle.hideturtle()
    self.turtle.up()
    for _ in range(360): # Number of dots
      self.p.append([x, y]) # Starting point
      self.dir.append(random.uniform(0, math.pi * 2)) # Direction?
      self.s.append(random.uniform(200, 3000)) # Distance to travel

  def draw(self):
    self.turtle.clear()
    if self.t > 0:
      for i in range(len(self.p)):
        self.turtle.goto(self.p[i])
        #self.turtle.dot(5)
        self.turtle.pendown()
        self.turtle.degrees(self.turtle.towards(0,0))
        self.turtle.forward(50)
        self.turtle.penup()

  def move(self, t):
    self.t -= t
    for i in range(len(self.p)):
      self.p[i][0] += self.s[i] * t * math.cos(self.dir[i]) # Set x cord
      self.p[i][1] += self.s[i] * t * math.sin(self.dir[i]) # Set y cord
      self.s[i] *= 0.9 # increases travel distance

  def explode(self):
    self.move(1/20)
    self.draw()
    if self.t > 0:
      self.screen.ontimer(self.explode, 50)

def clicker(x,y):
  screen = turtle.Screen()
  screen.tracer(0, 0)
  screen.bgcolor('black')
  exp = Explosion(x, y, screen)
  exp.explode()

if __name__ == '__main__':
  screen_size=[900,900]
  # Setup Viewport/Window Screen
  turtle.screensize(*screen_size)
  screen = turtle.Screen()
  screen.setup(*screen_size, 1600, 400)
  screen.tracer(0, 0)
  screen.bgcolor('black')
  exp = Explosion(0, 0, screen)
  #exp.explode()
  #while True:
  #  speed = 100
  #  for x in range(0,speed-2,3):
  #    pause = random.randint(1,speed-x)
  #      screen.ontimer(clicker(random.uniform(-500,500), random.uniform(-500,500)),pause)
  screen.onclick(clicker)
  screen.mainloop()