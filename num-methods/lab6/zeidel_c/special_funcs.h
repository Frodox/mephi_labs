#ifndef SPECIAL_FUNCS_H
#define SPECIAL_FUNCS_H

#include <matrix.h>

void initialize_A (Matrix &A);

void initialize_b (Matrix &B);

void initialize_x0 (Matrix &x0);

Matrix zeidel_multiply (const Matrix &B, const Matrix &x_old, const Matrix &C);

#endif // SPECIAL_FUNCS_H
