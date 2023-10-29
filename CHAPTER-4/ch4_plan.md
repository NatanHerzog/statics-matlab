# Chapter 4

## Introduction to Symbolics

Thus far, everything we've done has been "traditional" programming. We define variables and assign them values, then write some equations. But MATLAB also has a tool called the `Symbolic Toolbox`. This is a really powerful tool with many capabilities, but we will focus on the aspects that are directly relevant for Statics.

In class, we have discussed the calculation of centroids by integration. Rather than performing these by hand, you can use the `int()` function to do them symbolically.

For example, let's explore the following integral:

$$
\displaystyle
\int \left(x^2\right) dx = \frac{x^3}{3}
$$

We can replicate this in MATLAB as follows:

```MATLAB
syms x

expr = x^2;
integratedExpr = int(expr,x)
```

`output: integratedExpr = x^3/3`

We can also include limits of integration.

$$
\displaystyle
\int_{0}^{5} \left(x^2\right) dx =
\frac{1}{3}
\left(
    \left.x^3\right|_{x=5} - \left.x^3\right|_{x=0}
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

These are fairly simple examples, but it can be used for everything we need for class. Let's see how to use it to centroid calculations, like we've been covering in class!

## Center of Area

As a reminder, here are the governing equations for the $(\bar{x},\bar{y})$ coordinates of a body's center of area:

$$
\bar{x} = \frac{\displaystyle\int \left(x\right) dA}{\displaystyle\int dA}
$$

$$
\bar{y} = \frac{\displaystyle\int \left(y\right) dA}{\displaystyle\int dA}
$$

Let's find the center of area for the curve $y = x^2$ on the interval $\left[1,6\right]$.

To find $\bar{x}$ as we did in class, let's define our $dA$ as a vertical rectangle with width $dx$ and height $y=x^2$, to get an integral in terms of $x$.

$$
\displaystyle
dA = (width)(height) = (dx)(x^2)
$$

$$
\bar{x} =
\frac{\displaystyle
    \int_1^6 \left(x\right) dA}{\displaystyle
    \int_1^6 dA} =
\frac{\displaystyle
    \int_1^6 \left((x)(x^2)\right) dx}{\displaystyle
    \int_1^6 \left(x^2\right) dx}
\Rightarrow \left[\bar{x} =
\frac{\displaystyle
    \int_1^6 \left(x^3\right) dx}{\displaystyle
    \int_1^6 \left(x^2\right) dx}\right]
$$

This is very simple in MATLAB:

```MATLAB
syms x                                              % define symbolic x
numerator = int(x^3, x, 1, 6);                      % integrate numerator
denominator = int(x^2, x, 1, 6);                    % integrate denominator
x_bar = double(simplify(numerator / denominator))   % solve x_bar
```

`output x_bar = 4.5174`

To find $\bar{y}$ as we did in class, let's define our $dA$ as a horizontal rectangle with width $\left(6 - \sqrt{y}\right)$ and height $dy$, to get the integral in terms of $y$.

$$
\displaystyle
dA = (width)(height) = \left(6 - \sqrt{y}\right)(dy)
$$

$$
\bar{y} =
\frac{\displaystyle
    \int_{y=1^2}^{y=6^2} \left(y\right) dA}{\displaystyle
    \int_{y=1^2}^{y=6^2} dA} =
\frac{\displaystyle
    \int_{1}^{36} \left((y)(6 - \sqrt{y})\right) dy}{\displaystyle
    \int_{1}^{36} \left(6 - \sqrt{y}\right) dy}
\Rightarrow \left[\bar{y} =
\frac{\displaystyle
    \int_{1}^{36} \left(6y - y^{\frac{3}{2}}\right) dy}{\displaystyle
    \int_{1}^{36} \left(6 - \sqrt{y}\right) dy}\right]
$$

Again, this is very simple in MATLAB:

```MATLAB
syms y                                              % define symbolic y
numerator = int(6*y-y^(3/2), y, 1, 36);             % integrate numerator
denominator = int(6-sqrt(y), y, 1, 36);             % integrate denominator
y_bar = double(simplify(numerator / denominator))   % solve y_bar
```

`output: y_bar = 11.6250`

Now, to justify that these answers are correct:

For $\bar{x}$

$$
\bar{x} =
\frac{\displaystyle\int_1^6 \left(x^3\right) dx}{\displaystyle\int_1^6 \left(x^2\right) dx}
$$

$$
\bar{x} =
\frac{\displaystyle
    \frac{1}{4}\left.x^4\right|_1^6}{\displaystyle
    \frac{1}{3}\left.x^3\right|_1^6} =
\frac{\displaystyle
    \frac{1}{4}\left[6^4 - 1\right]}{\displaystyle
    \frac{1}{3}\left[6^3 - 1\right]} =
\frac{\displaystyle
    \frac{1295}{4}}{\displaystyle
    \frac{215}{3}} =
\frac{(1295)(3)}{(215)(4)}
$$

$$
\bar{x} =
4.5174
$$

And for $\bar{y}$:

$$
\bar{y} =
\frac{\displaystyle
    \int_{1}^{36} \left(6y - y^{\frac{3}{2}}\right) dy}{\displaystyle
        \int_{1}^{36} \left(6 - \sqrt{y}\right) dy}
$$

$$
\bar{y} =
\frac{\displaystyle
    \left. \frac{6}{2} y^{2} - \frac{2}{5} y^{\frac{5}{2}} \right|_{1}^{36}}{\displaystyle
        \left. 6y - \frac{2}{3} y^{\frac{3}{2}} \right|_{1}^{36}} =
\frac{\displaystyle
    \frac{6}{2}\left[36^2-1\right] - \frac{2}{5}\left[36^{\frac{5}{2}}-1\right]}{\displaystyle
        6\left[36-1\right] - \frac{2}{3}\left[36^{\frac{3}{2}}-1\right]} =
\frac{\displaystyle
    \frac{6}{2}(1295) - \frac{2}{5}(7775)}{\displaystyle
        (6)(35) - \frac{2}{3}(215)}
$$

$$
\bar{y} =
11.6250
$$

$$
\displaystyle
\left(\bar{x},\bar{y}\right) = \left(4.5174,11.6250\right)
$$

Hopefully it is clear to see that MATLAB makes these calculations significantly simpler!

## Other Centroid Calculations

Any other centroid calculation is exactly the same as what we've just done. The only difference is how you set up the problem, which is outside the scope of this MATLAB content.

I assure you, if you are comfortable with writing the integrals in MATLAB for this exercise, you can do centroids of lines, volume, mass, or anything else!

## Extra Resources

If you want a deep dive, here is a [link](https://www.mathworks.com/products/symbolic.html) to the Mathworks page on the `Symbolic Toolbox`. You will find tons of documentation on everything it can do!
