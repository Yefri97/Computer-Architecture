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

int pol(int x, int k[], int n) {
  int target = 0;
  for (int i = 0; i < n + 1; i++)
    target += mult(k[i], power(x, i));
  return target;
}

int main() {
  
  printf("Ingrese el grado del polinomio:\n");
  int degree;
  scanf("%d", &degree);
  
  printf("Ingrese los coeficientes del polinomio:\n");
  int coef[degree + 10];
  for (int i = 0; i < degree + 1; i++)
    scanf("%d", &coef[i]);
  
  printf("Ingrese el punto donde quiere evaluar el polinomio:\n");
  int x;
  scanf("%d", &x);

  printf("El polinomio ingresado fue:\nf(%d) = ", x);
  for (int i = 0; i < degree + 1; i++) {
    if (i) printf(" + ");
    printf("%d*(%d)^%d", coef[i], x, i);
  }
  printf("\n");

  int y = pol(x, coef, degree);
  printf("f(%d) = %d\n", x, y);

  return 0;
}