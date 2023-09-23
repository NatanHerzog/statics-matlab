# Objectives

## Vector Projection

In the last chapter, we introduced the dot product. One of its most powerful uses is for decomposing vectors into their projections along specific directions.

For example, when considering the moment acting on a car's wheel, we may be particularly interested in the component that acts along the direction of the axle, as that determines its tendency to rotate.

Or when considering the force on an airplane wing in flight, we may want to decompose it into components that lie parallel and perpendicular to the wing itself.

As we learned in class, the formula for the projection of $\vec{a}$ along the direction of $\vec{b}$ (let's call it $\vec{p}_{a/b}$) is as follows:

$$\vec{p}_{a/b} = \left(\vec{a}\cdot\hat{e}_b\right)\hat{e}_b$$

And recall that $\hat{e}_b$ is the unit direction vector along $\vec{b}$, which can be calculated as follows:

$$\hat{e}_b = \frac{\vec{b}}{\Vert\vec{b}\Vert}$$

In MATLAB, this becomes very simplified:

```MATLAB
a = [1, 1, 1]; % define vector a
b = [1, 0, 0]; % define vector b
normB = norm(b); % calculate the magnitude of b
e_b = b./normB; % get the unit direction vector for b
proj = e_b.*(dot(a, e_b)); % perform the projection of a onto b
```

`output: proj = [1, 0, 0]`

In this example, I broke down individual calculations to make it simple to read. You can also perform everything in the same line of code:

```MATLAB
a = [1, 1, 1]; % define vector a
b = [1, 0, 0]; % define vector b
proj = (b./norm(b)) .* (dot(a, b./norm(b)));
```

`output: proj = [1, 0, 0]`

## Vector Cross Product

Like the dot product, the cross product is extremely common, especially in this course. Especially when considering the moment created by a force $\vec{F}$ acting at a distance $\vec{r}$. We calculate $\vec{M} = \vec{r} \times \vec{F}$.

When performed by hand, we have to go through the tedious process of calculating the $3 \times 3$ determinant:

$$\vec{M} = \begin{vmatrix} \hat{i} & \hat{j} & \hat{k} \\ r_x & r_y & r_z \\ F_x & F_y & F_z \\ \end{vmatrix}$$

$$\vec{M} = \left(r_yF_z - r_zF_y\right)\hat{i} - \left(r_xF_z - r_zF_x\right)\hat{j} + \left(r_xF_y - r_yF_x\right)\hat{k}$$

That's quite a process! In MATLAB, just like with `dot()`, there is a `cross()` function to make our lives easy and awesome.

```MATLAB
a = [3, 2, 1];
b = [5, 4, 3];
cross(a, b)
```

`output: ans = [2, -4, 2]`

This is a **SUPER** important tool for this class. For a body to be static, it must not have any translational acceleration **and** it must not have any rotational acceleration. Therefore, both the net force and the net moment are vital to calculate.

*Foreshadowing:* $\Sigma\vec{F}=\vec{0}$, $\Sigma\vec{M}_o=\vec{0}$ must be true in all dimensions for a static structure. One important example, which we will explore throughout the term, is the modeling of bridges. It goes without saying that a bridge should not suddenly start translating or rotating in any way. This would be bad :)

This is the reason that we are building these skills now.
