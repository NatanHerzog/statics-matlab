# Chapter 4

## Introduction to Symbolics

Thus far, everything we've done has been "traditional" programming. We define variables and assign them values, then write some equations. But MATLAB also has a tool called the `Symbolic Toolbox`. This allows you to define equations symbolically.

In class, we have been discussing the calculation of centroids by integration. Rather than performing these by hand, you can use the `int()` function to do them symbolically.

For example, let's explore the following integral:

$$
\displaystyle
\int x^2 \,dx = \frac{x^3}{3}
$$

```MATLAB
syms x

expr = x^2;
integratedExpr = int(expr,x)
```

`output: integratedExpr = x^3/3`

Let's add some limits to this integration now

$$
\displaystyle
\int_{0}^{5} x^2 \,dx =
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

As a reminder, here are the governing equations for the $(\bar{x},\bar{y})$ coordinates of a body's center of area:

$$
\displaystyle
\bar{x} = \frac{\int x \,dA}{\int dA},\,
\bar{y} = \frac{\int y \,dA}{\int dA}
$$

Let's find the center of area for the curve $y = x^2$ on the interval $\left[1,6\right]$.

To find $\bar{x}$ as we did in class, let's define our $dA$ as a vertical rectangle with width $dx$ and height $y=x^2$, to get an integral in terms of $x$.

$$
\displaystyle
dA = (width)(height) = (dx)(x^2)
$$

$$
\displaystyle
\bar{x} = \frac{\int_1^6 x \,dA}{\int_1^6 dA} = \frac{\int_1^6 (x)(x^2)\,dx}{\int_1^6 x^2 \,dx} \Rightarrow \left[\bar{x} = \frac{\int_1^6 x^3 \,dx}{\int_1^6 x^2 \,dx}\right]
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
\displaystyle
\bar{y} = \frac{\int_{y=1^2}^{y=6^2} y \,dA}{\int_{y=1^2}^{y=6^2} dA} = \frac{\int_{1}^{36} (y)(6 - \sqrt{y}) \,dy}{\int_{1}^{36} 6 - \sqrt{y} \,dy}
\Rightarrow \left[\bar{y} = \frac{\int_{1}^{36} 6y - y^{\frac{3}{2}} \,dy}{\int_{1}^{36} 6 - \sqrt{y} \,dy}\right]$$

Again, this is very simple in MATLAB:

```MATLAB
syms y                                              % define symbolic y
numerator = int(6*y-y^(3/2), y, 1, 36);             % integrate numerator
denominator = int(6-sqrt(y), y, 1, 36);             % integrate denominator
y_bar = double(simplify(numerator / denominator))   % solve y_bar
```

`output: y_bar = 11.6250`

Now, to justify that these answers are correct:

$$
\displaystyle
\bar{x} =
\frac{\int_1^6 x^3 \,dx}{\int_1^6 x^2 \,dx} =
\frac{\frac{1}{4}\left.x^4\right|_1^6}{\frac{1}{3}\left.x^3\right|_1^6} =
\frac{\frac{1}{4}\left[6^4 - 1\right]}{\frac{1}{3}\left[6^3 - 1\right]} =
\frac{\frac{1295}{4}}{\frac{215}{3}} =
\frac{(1295)(3)}{(215)(4)} =
4.5174
$$

$$
\displaystyle
\bar{y} = \frac{\int_{1}^{36} 6y - y^{\frac{3}{2}} \,dy}{\int_{1}^{36} 6 - \sqrt{y} \,dy} =
\frac{\left.\frac{6}{2}y^2 - \frac{2}{5}y^{\frac{5}{2}}\right|_1^{36}}{\left.6y - \frac{2}{3}y^{\frac{3}{2}}\right|_{1}^{36}} =
\frac{\frac{6}{2}\left[36^2-1\right] - \frac{2}{5}\left[36^{\frac{5}{2}}-1\right]}{6\left[36-1\right] - \frac{2}{3}\left[36^{\frac{3}{2}}-1\right]} =
\frac{\frac{6}{2}(1295) - \frac{2}{5}(7775)}{(6)(35) - \frac{2}{3}(215)} =
11.6250
$$

$$
\displaystyle
\left(\bar{x},\,\bar{y}\right) = \left(4.5174,\,11.6250\right)
$$

Hopefully it is clear to see that MATLAB makes these calculations significantly simpler!

## Other Centroid Calculations

Any other centroid calculation is exactly the same as what we've just done. The only difference is how you set up the problem, which is outside the scope of this MATLAB content.

I assure you, if you are comfortable with writing the integrals in MATLAB for this exercise, you can do centroids of lines, volume, mass, or anything else!

## Extra Resources

If you want a deep dive, here is a [link](https://www.mathworks.com/products/symbolic.html) to the Mathworks page on the `Symbolic Toolbox`. You will find tons of documentation on everything it can do!