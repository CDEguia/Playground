####################################################
#
# - drawing shall be blue
# - Make any shape
# - Shall shrink into a single point
# - Shall explode at end
# - Explosion shall be lines shooting out in all directions
#    - Short lines that move outward
#
# Extra credit:
#
# - Smoke and red more like a real explosion
#
####################################################

import turtle as t
import time
import random
from astroid_explode import Explosion

# Setup the screen
screen = t.Screen()
screen.bgcolor("black")
#screen.tracer(600,1000)
# Create a turtle object
pen = t.Turtle()
pen.hideturtle()
pen.speed(0)
pen.color("cyan")

# Function to draw a square
def draw_square(size):
    for _ in range(10):
        pen.forward(size)
        pen.right(90)

# Draw a square and shrink it
def shrink_shape():
    for size in range(100, 0, -10):
        pen.clear()
        draw_square(size)
        pen.penup()
        pen.goto(pen.xcor() + 5, pen.ycor() - 5)
        pen.pendown()

# Function to create an explosion effect
def explode():
  pen.clear()
  pen.penup()
  pen.goto(0, 0)
  pen.pendown()
  explode_size=100
  set_points=[(0,0)]
  explosion_length=10

  for i in range(0, explode_size, 10):
    explosion_length += 10
    pen.clear()
    for x in range(36):
        if i == 0:
            pen.teleport(0,0)
        else:
          pen.teleport(set_points[x][0], set_points[x][1])
        pen.forward(explosion_length)
        if i == 0:
          set_points.append(pen.pos())
        else:
           set_points[x] = pen.pos()
        pen.right(10)      

def explode_one_big():
    pen.clear()
    for _ in  range(100):
        pen.teleport(0,0)
        angle = random.randint(0,45)
        distance = random.randint(0,550)
        pen.right(angle)
        pen.forward(distance)
        

# Main execution
shrink_shape()
#time.sleep(0.5)
#explode_one_big()
screen.tracer(0, 0)

exp = Explosion(0,0, screen)
exp.explode()
# Hide the turtle and display the screen
pen.hideturtle()
t.done()