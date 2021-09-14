function [A, B, C, D] = linear_model(theta, dtheta, d1, d2, l1, l2, I1, I2, Iball, m1, m2, mball)

    theta1 = theta(1);
    theta2 = theta(2);
    theta1_dot = dtheta(1);
    theta2_dot = dtheta(2);
    theta1_ddot = 0;
    theta2_ddot = 0;
    
    A = [0, 0, 1, 0; ...
         0, 0, 0, 1; ...
         g*(-I2*d1*m1*cos(theta1) - I2*l1*m2*cos(theta1) - I2*l1*mball*cos(theta1) - Iball*d1*m1*cos(theta1) - Iball*l1*m2*cos(theta1) - Iball*l1*mball*cos(theta1) - d1*d2^2*m1*m2*cos(theta1) - d1*l2^2*m1*mball*cos(theta1) - d2^2*l1*m2^2*sin(theta1 + theta2)*sin(theta2) - d2^2*l1*m2*mball*cos(theta1) - 2*d2*l1*l2*m2*mball*sin(theta1 + theta2)*sin(theta2) + 2*d2*l1*l2*m2*mball*cos(theta1) - l1*l2^2*m2*mball*cos(theta1) - l1*l2^2*mball^2*sin(theta1 + theta2)*sin(theta2))/(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2), (-(-(I2 + Iball + d2*m2*(d2 + l1*cos(theta2)) + l2*mball*(l1*cos(theta2) + l2))*(-d2*g*m2*cos(theta1 + theta2) + d2*l1*m2*(2*sin(theta2)*theta1_ddot + sin(theta2)*theta2_ddot + 2*cos(theta2)*theta1_dot*theta2_dot + cos(theta2)*theta2_dot^2) - g*l2*mball*cos(theta1 + theta2) + l1*l2*mball*(2*sin(theta2)*theta1_ddot + sin(theta2)*theta2_ddot + 2*cos(theta2)*theta1_dot*theta2_dot + cos(theta2)*theta2_dot^2)) + (I1 + I2 + Iball + d1^2*m1 + m2*(d2^2 + 2*d2*l1*cos(theta2) + l1^2) + mball*(l1^2 + 2*l1*l2*cos(theta2) + l2^2))*(-d2*g*m2*cos(theta1 + theta2) + d2*l1*m2*sin(theta2)*theta1_ddot - d2*l1*m2*cos(theta2)*theta1_dot^2 - g*l2*mball*cos(theta1 + theta2) + l1*l2*mball*sin(theta2)*theta1_ddot - l1*l2*mball*cos(theta2)*theta1_dot^2))*(I2 + Iball + d2*m2*(d2 + l1*cos(theta2)) + l2*mball*(l1*cos(theta2) + l2)) + (-d2*g*m2*cos(theta1 + theta2) + d2*l1*m2*(2*sin(theta2)*theta1_ddot + sin(theta2)*theta2_ddot + 2*cos(theta2)*theta1_dot*theta2_dot + cos(theta2)*theta2_dot^2) - g*l2*mball*cos(theta1 + theta2) + l1*l2*mball*(2*sin(theta2)*theta1_ddot + sin(theta2)*theta2_ddot + 2*cos(theta2)*theta1_dot*theta2_dot + cos(theta2)*theta2_dot^2))*(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2))/((I1 + I2 + Iball + d1^2*m1 + m2*(d2^2 + 2*d2*l1*cos(theta2) + l1^2) + mball*(l1^2 + 2*l1*l2*cos(theta2) + l2^2))*(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2)), l1*(2*(d2*m2 + l2*mball)*(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2)*theta2_dot + (2*(d2*m2 + l2*mball)*(I2 + Iball + d2*m2*(d2 + l1*cos(theta2)) + l2*mball*(l1*cos(theta2) + l2))*theta2_dot + (I1 + I2 + Iball + d1^2*m1 + m2*(d2^2 + 2*d2*l1*cos(theta2) + l1^2) + mball*(l1^2 + 2*l1*l2*cos(theta2) + l2^2))*(d2*m2*(theta1_dot + theta2_dot) + d2*m2*theta1_dot - d2*m2*theta2_dot + l2*mball*(theta1_dot + theta2_dot) + l2*mball*theta1_dot - l2*mball*theta2_dot))*(I2 + Iball + d2*m2*(d2 + l1*cos(theta2)) + l2*mball*(l1*cos(theta2) + l2)))*sin(theta2)/((I1 + I2 + Iball + d1^2*m1 + m2*(d2^2 + 2*d2*l1*cos(theta2) + l1^2) + mball*(l1^2 + 2*l1*l2*cos(theta2) + l2^2))*(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2)), 2*l1*(d2*m2 + l2*mball)*(theta1_dot + theta2_dot)*(I2 + Iball + d2^2*m2 + l2^2*mball)*sin(theta2)/(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2); ...
         g*(-(d2*m2 + l2*mball)*(I1 + I2 + Iball + d1^2*m1 + m2*(d2^2 + 2*d2*l1*cos(theta2) + l1^2) + mball*(l1^2 + 2*l1*l2*cos(theta2) + l2^2))*cos(theta1 + theta2) + (d1*m1*cos(theta1) + m2*(d2*cos(theta1 + theta2) + l1*cos(theta1)) + mball*(l1*cos(theta1) + l2*cos(theta1 + theta2)))*(I2 + Iball + d2*m2*(d2 + l1*cos(theta2)) + l2*mball*(l1*cos(theta2) + l2)))/(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2), (-(I2 + Iball + d2*m2*(d2 + l1*cos(theta2)) + l2*mball*(l1*cos(theta2) + l2))*(-d2*g*m2*cos(theta1 + theta2) + d2*l1*m2*(2*sin(theta2)*theta1_ddot + sin(theta2)*theta2_ddot + 2*cos(theta2)*theta1_dot*theta2_dot + cos(theta2)*theta2_dot^2) - g*l2*mball*cos(theta1 + theta2) + l1*l2*mball*(2*sin(theta2)*theta1_ddot + sin(theta2)*theta2_ddot + 2*cos(theta2)*theta1_dot*theta2_dot + cos(theta2)*theta2_dot^2)) + (I1 + I2 + Iball + d1^2*m1 + m2*(d2^2 + 2*d2*l1*cos(theta2) + l1^2) + mball*(l1^2 + 2*l1*l2*cos(theta2) + l2^2))*(-d2*g*m2*cos(theta1 + theta2) + d2*l1*m2*sin(theta2)*theta1_ddot - d2*l1*m2*cos(theta2)*theta1_dot^2 - g*l2*mball*cos(theta1 + theta2) + l1*l2*mball*sin(theta2)*theta1_ddot - l1*l2*mball*cos(theta2)*theta1_dot^2))/(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2), -l1*(2*(d2*m2 + l2*mball)*(I2 + Iball + d2*m2*(d2 + l1*cos(theta2)) + l2*mball*(l1*cos(theta2) + l2))*theta2_dot + (I1 + I2 + Iball + d1^2*m1 + m2*(d2^2 + 2*d2*l1*cos(theta2) + l1^2) + mball*(l1^2 + 2*l1*l2*cos(theta2) + l2^2))*(d2*m2*(theta1_dot + theta2_dot) + d2*m2*theta1_dot - d2*m2*theta2_dot + l2*mball*(theta1_dot + theta2_dot) + l2*mball*theta1_dot - l2*mball*theta2_dot))*sin(theta2)/(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2), -2*l1*(d2*m2 + l2*mball)*(theta1_dot + theta2_dot)*(I2 + Iball + d2*m2*(d2 + l1*cos(theta2)) + l2*mball*(l1*cos(theta2) + l2))*sin(theta2)/(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2)];
    B = [0; ...
         0; ...
         (I2 + Iball + d2^2*m2 + l2^2*mball)/(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2); ...
         -(I2 + Iball + d2*m2*(d2 + l1*cos(theta2)) + l2*mball*(l1*cos(theta2) + l2))/(I1*I2 + I1*Iball + I1*d2^2*m2 + I1*l2^2*mball + I2*d1^2*m1 + I2*l1^2*m2 + I2*l1^2*mball + Iball*d1^2*m1 + Iball*l1^2*m2 + Iball*l1^2*mball + d1^2*d2^2*m1*m2 + d1^2*l2^2*m1*mball + d2^2*l1^2*m2^2*sin(theta2)^2 + d2^2*l1^2*m2*mball + 2*d2*l1^2*l2*m2*mball*sin(theta2)^2 - 2*d2*l1^2*l2*m2*mball + l1^2*l2^2*m2*mball + l1^2*l2^2*mball^2*sin(theta2)^2)];
    C = [eye(2) zeros(2)];
    D = zeros(2, 1);
    
end

