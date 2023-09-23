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
% [] Calculate the resultant moment, M1, at r1 with the cross product (r1 x F)
% [] Calculate the resultant moment, M2, at r2 with the cross product (r2 x F)
% [] Calculate the magnitudes of each resultant moment, M1 and M2
% [] Observe that not only are the vectors M1 and M2 different, but their magnitudes are also

%% --------------- STEP-BY-STEP 3 --------------- %%
% [] Define a vector r (blue vector between a force couple) (choose its components yourself)
% [] Define a vector F (red force vector) and its negative (-F) (choose the components yourself)
% [] Calculate the couple between these two forces (r x F) making sure that you use the force vector that r actually points towards 
% [] Now apply the following matrix to the vector r, F, and (-F):
R = [cosd(45), -sind(45); sind(45), cosd(45)];
% **NOTE** this is a rotation matrix that will just rotate the vectors in 2D space. you DO NOT need to know how this works for this course, I am only including it so that you can see how couples work
% Apply R to the vectors like so: rNew = (R*r')', FNew = (R*F')' (also do -FNew)
% [] Now calculate the couple again, just as before
% [] Observe that this resultant couple is identical to the one you calculated before!!