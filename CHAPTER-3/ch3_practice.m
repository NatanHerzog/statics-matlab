% Practicing Vector Projects and Moment/Couple Calculations

%% --------------- STEP-BY-STEP 1 --------------- %%
% [] Define two vectors a and b (choose their components yourself) 
% [] Calculate the magnitude of each (refer to ch3_plan.md for the command)
% [] Define unit direction vectors for each by using the previously calculated magnitudes (recall the formula from ch3_plan.md)
% [] Following the code example, project vector a along the direction of vector b
% [] With the same formula, project vector b along the direction of vector a

%% --------------- STEP-BY-STEP 2 --------------- %%
% [] Define two position vectors r1 and r2 (choose their components yourself)
% [] Define a force vector F (choose its components yourself)
% [] Calculate the resultant M1 with a moment arm r1 using the cross product (r1 x F)
% [] Calculate the resultant M2 with a moment arm r2 using the cross product (r2 x F)
% [] Calculate the magnitudes of each resultant moment, M1 and M2
% [] Observe that not only are the vectors M1 and M2 different, but their magnitudes are also

%% --------------- STEP-BY-STEP 3 --------------- %%
% **NOTE** for this problem, refer to the second set of diagrams in ch3_plan.md
% [] Define a vector r (blue vector) (choose only x,y components and set rz = 0)
% [] Define a vector F (red vector) (choose only x,y components and set Fz = 0)
% **NOTE** we don't need to declare another opposing vector because it is not part of the equation, but keep in mind that a couple does still have it
% [] Calculate the couple between these two forces (r x F)
% [] Now apply the following matrix to the vectors r, F:
rotationMatrix = [cosd(45), -sind(45) 0; sind(45), cosd(45), 0; 0, 0, 0];
% **NOTE** this is a rotation matrix that rotates the vectors in the x-y plane. you DO NOT need to know how this works for this course, I am only including it so that you can see the invariance of couples
% Apply R to the vectors like so: rNew = (rotationMatrix*r')', FNew = (rotationMatrix*F')'
% [] Now calculate the couple again, just as before
% [] Observe that this resultant couple is identical to the one you calculated before!!