#include <stdio.h>

int mult(int x, int y) {
  int target = 0;
  for (int i = 0; i < y; i++)
    target += x;
  return target;
}

int fact(int x) {
  int target = 1;
  for (int i = 1; i < x; i++)
    target = mult(target, i + 1);
  return target;
}

int main() {
  printf("Ingrese un valor:\n");
  int num;
  scanf("%d", &num);
  int ans = fact(num);
  printf("El factorial de %d es %d\n", num, ans);
  return 0;
}