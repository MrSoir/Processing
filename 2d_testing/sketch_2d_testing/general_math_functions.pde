boolean checkForSimilarity(float I, float II, float max_diff){
  float diff = abs(I-II);
  return diff < max_diff;
}
