void gradient(int *inVect, int *outVect, int vectSize) {
  for (int i = 1; i < vectSize; i++)
    outVect[i] = 3 * inVect[i] - 2 * inVect[i-1];
}

int main(int argc, char **argv) {
  int inVect[8] = {16, 16, 0, 0, 0, 16, 16, 16};
  int outVect[8] = {0};
  gradient(inVect, outVect, 8); // resultat : [0, 16, -32, 0, 0, 48, 16, 16]
  return 0;
}