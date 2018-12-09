import math
import numpy as np

class Vec:
  def __init__(self, *vals):
    self.vals = np.array(list(vals)).flatten()

  def length(self):
    return math.sqrt( self.lengthSqrd() )

  def lengthSqrd(self):
    return np.sum(self.vals * self.vals)

  def normalize(self):
    lngth = self.length()
    vals = self.vals / lngth
    return Vec(vals)

  def add(self, vec):
    return Vec(self.vals + vec.vals)

  def sub(self, vec):
    return Vec(self.vals - vec.vals)
  
  def mul(self, vec):
    return Vec(self.vals * vec.vals)
  
  def div(self, vec):
    return Vec(self.vals / vec.vals)
  
  def dot(self, vec):
    return np.sum(self.vals * vec.vals)

  def dotNorm(self, vec):
    norm1 = self.normalize()
    norm2 = vec.normalize()
    return norm1.dot(norm2)
