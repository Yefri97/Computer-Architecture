#include <stdio.h>

int mult(int x, int y) {
  int target = 0;
  for (int i = 0; i < y; i++)
    target += x;
  return target;
}

int power(int b, int e) {
  int target = 1;
  for (int i = 0; i < e; i++)
    target = mult(target, b);
  return target;
}

int main() {
  int base, exp;
  printf("Ingrese la base:\n");
  scanf("%d", &base);
  printf("Ingrese el exponente:\n");
  scanf("%d", &exp);
  int ans = power(base, exp);
  printf("%d elevado a la %d es %d\n", base, exp, ans);
  return 0;
}