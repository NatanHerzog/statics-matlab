The cross product is also extremely common, especially in this course. When considering the moment created by a force $\vec{F}$ acting at a distance $\vec{r}$, we calculate $\vec{M} = \vec{r} \times \vec{F}$.

When performed by hand, we have to go through the process of calculating the $3 \times 3$ determinant:

$$\vec{M} = 
\begin{vmatrix}
\hat{i} & \hat{j} & \hat{k} \\
r_x & r_y & r_z \\
F_x & F_y & F_z \\
\end{vmatrix}
$$

$$\vec{M} = 
\left(r_yF_z - r_zF_y\right)\hat{i} - \left(r_xF_z - r_zF_x\right)\hat{j} + \left(r_xF_y - r_yF_x\right)\hat{k}
$$

That's quite a process! In MATLAB, just like with `dot()`, there is a `cross()` function to make our lives easy and awesome.

```MATLAB
a = [3, 2, 1];
b = [5, 4, 3];
cross(a, b)
```

`output: ans = [2, -4, 2]`

This is a **SUPER** important tool for this class. Calculating the net moment is essential when evaluating the static conditions for a body.

*Foreshadowing:* $\Sigma\vec{F}=\vec{0}$, $\Sigma\vec{M}=\vec{0}$ must be true in all dimensions for a static structure. One important example, which we will explore throughout the term, is the modeling of bridges. It goes without saying that a bridge should not suddenly start translating or rotating in any way.

This is the reason that we are building these skills now.