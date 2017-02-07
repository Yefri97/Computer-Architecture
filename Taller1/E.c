#include <stdio.h>

int divide(int a, int b) {
  int target = 0;
  while (a >= b) {
    a -= b;
    target++;
  }
  return target;
}

int main() {
  int a, b;
  printf("Ingrese el dividendo\n");
  scanf("%d", &a);
  printf("Ingrese el divisor\n");
  scanf("%d", &b);
  int ans = divide(a, b);
  printf("%d / %d = %d\n", a, b, ans);
  return 0;
}