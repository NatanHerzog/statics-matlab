# Chapter 4

## Introduction to Symbolics

Thus far, everything we've done has been "traditional" programming. We define variables and assign them values, then write some equations. But MATLAB also has a tool called the `Symbolic Toolbox`. This allows you to define equations symbolically.

In class, we have been discussing the calculation of centroids by integration. Rather than performing these by hand, you can use the `int()` function to do them symbolically.

For example, let's explore the following integral:

$$
\int x^2 \mathrm{d}x = \frac{x^3}{3}
$$

```MATLAB
syms x

expr = x^2;
integratedExpr = int(expr,x)
```

`output: integratedExpr = x^3/3`

Let's add some limits to this integration now

$$
\int_{0}^{5} x^2 \mathrm{d}x =
\frac{1}{3}
\left(
    \left.x^3\right\rvert_{x=5} - \left.x^3\right\rvert_{x=0}
\right) =
\frac{1}{3}
\left(
    5^3 - 0
\right) =
\frac{125}{3}
$$

```MATLAB
syms x

expr = x^2;
integratedExpr = int(expr,x,0,5)
```

`output: integratedExpr = 125/3`

## Center of Area



## Extra Resources

If you want a deep dive, here is a [link](https://www.mathworks.com/products/symbolic.html) to the Mathworks page on the `Symbolic Toolbox`. You will find tons of documentation on everything it can do!
