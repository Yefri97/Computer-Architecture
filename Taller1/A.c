#include <stdio.h>

int mult(int x, int y) {
  int target = 0;
  for (int i = 0; i < y; i++)
    target += x;
  return target;
}

int main() {
  int x, y;
  printf("Ingrese dos numeros para multiplicarlos:\n");
  scanf("%d %d", &x, &y);
  int ans = mult(x, y);
  printf("La multiplicacion de %d * %d es %d\n", x, y, ans);
  return 0;
}