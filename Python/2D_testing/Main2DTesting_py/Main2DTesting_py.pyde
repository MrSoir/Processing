import vec

def setup():
    size(480, 120)
    vec = vec.Vec(1,0,0)

def draw():
    print(vec.vals)
    ellipse(mouseX, mouseY, 80, 80)
