#include <stdio.h>

float py2float(float a) {
    // printf("a: %f\n", a);
    return a;
}

double py2double(float a) {
    // printf("a: %f, da: %lf\n", a, (double) a);
    return a;
}

float add_floats(float a, float b) {
    // printf("%f + %f = %f\n", a, b, a + b);
    return a + b;
}

double add_doubles(double a, double b) {
    // printf("%lf + %lf = %lf\n", a, b, a + b);
    return py2double(a) + py2double(b);
}

double add_true_doubles(double a, double b) {
    return a + b;
}

float mult_floats(float a, float b) {
    return a * b;
}

double mult_doubles(double a, double b) {
    return py2double(a) * py2double(b);
}

double mult_true_doubles(double a, double b) {
    return a * b;
}
