# Chapter 4

## Introduction to Symbolics

Thus far, everything we've done has been "traditional" programming. We define variables and assign them values, then write some equations. But MATLAB also has a tool called the `Symbolic Toolbox`. This allows you to define equations symbolically.

In class, we have been discussing the calculation of centroids by integration. Rather than performing these by hand, you can use the `int()` function to do them symbolically.

For example, let's explore the following integral:

$$
\int x^2 dx = \frac{x^3}{3}
$$

```MATLAB
syms x

expr = x^2;
integratedExpr = int(expr,x)
```

`output: integratedExpr = x^3/3`

Let's add some limits to this integration now

$$
\int_{0}^{5} x^2 dx =
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

These are fairly simple examples. This is a really powerful tool. We can use it to centroid calculations, like we've been covering in class!

## Center of Area

As a reminder, here is the governing form for the y-location of a body's center of area:

$$
\bar{y} =
\frac{\int ydA}{\int dA}
$$

This equation may look intimidating, so I want to quickly break down each part to better understand what is physically happening here. Effectively, this equation slices the shape into a bunch of tiny pieces and then averages the centroids of all the those pieces.

The numerator $\int ydA$ is performing a weighted sum of y-locations for every piece's centroid $\Rightarrow y$ reprents the y-location for the centroid of every little $dA$ element. If the idea of a weighted sum is uncomfortable, consider the following scenario.

Six of your friends each pick a number ($1$-$10$) out of a hat (there can be repeats). I ask, what is the average of the numbers drawn. You *could* simply add the numbers drawn by each person and then divide by $6$. But you can also get the same result with a weighted sum. I'll show you!

The 6 numbers drawn are: $2,\,5,\,6,\,5,\,8,\,1$. Then the average is as follows:

$$
\bar{n} = \frac{2 + 5 + 6 + 5 + 8 + 1}{6} = \frac{27}{6} = 4.5
$$

A weighted sum in this case follows this general form:

$$
\bar{n} = \frac{\Sigma \left(number\right)\left(\#\,of\,appearances\right)}{\#\,of\,draws} = \frac{(2)(1) + (5)(2) + (6)(1) + (8)(1) + (1)(1)}{6} = \frac{27}{6} = 4.5
$$

I bring this up because we're doing the exact same thing! $\Rightarrow y$ is analogous to $\left(number\right)$ and $dA$ is analogous to $\left(\#\,of\,appearances\right)$. And notice that the sum of all the $\left(\#\,of\,appearances\right)$ gives $\left(\#\,of\,draws\right)$. Then $\int dA$ is analogous to $\left(\#\,of\,draws\right)$.

So, let's bring it back to our centroid calculation with an example. Calculate the centroid

## Extra Resources

If you want a deep dive, here is a [link](https://www.mathworks.com/products/symbolic.html) to the Mathworks page on the `Symbolic Toolbox`. You will find tons of documentation on everything it can do!
