function [dx] = dynamics(x, tau, par)

    % x = [theta1, theta2, dtheta1, dtheta2
    
    d1 = par.d1;
    d2 = par.d2;
    l1 = par.l1;
    l2 = par.l2;
    I1 = par.I1;
    I2 = par.I2;
    Iball = par.Iball;
    m1 = par.m1;
    m2 = par.m2;
    mball = par.mball;
    g = par.g;
    
    theta1 = x(1);
    theta2 = x(2);
    theta1_dot = x(3);
    theta2_dot = x(4);
    
    mass = [1, 0, 0, 0; ...
            0, 1, 0, 0; ...
            0, 0, I1 + I2 + Iball + d1^2*m1 + m2*(2*d2^2 + 4*d2*l1*cos(theta2) + 2*l1^2)/2 + mball*(2*l1^2 + 4*l1*l2*cos(theta2) + 2*l2^2)/2, I2 + Iball + m2*(2*d2^2 + 2*d2*l1*cos(theta2))/2 + mball*(2*l1*l2*cos(theta2) + 2*l2^2)/2; ...
            0, 0, I2 + Iball + m2*(2*d2^2 + 2*d2*l1*cos(theta2))/2 + mball*(2*l1*l2*cos(theta2) + 2*l2^2)/2, I2 + Iball + d2^2*m2 + l2^2*mball];

    forcing = [theta1_dot; ...
               theta2_dot; ...
               -d1*g*m1*sin(theta1) - g*m2*(-d2*(-sin(theta1)*cos(theta2) - sin(theta2)*cos(theta1)) + l1*sin(theta1)) - g*mball*(l1*sin(theta1) - l2*(-sin(theta1)*cos(theta2) - sin(theta2)*cos(theta1))) - m2*(-2*d2*l1*(theta1_dot + theta2_dot)*sin(theta2)*theta2_dot - 2*d2*l1*sin(theta2)*theta1_dot*theta2_dot)/2 - mball*(-2*l1*l2*(theta1_dot + theta2_dot)*sin(theta2)*theta2_dot - 2*l1*l2*sin(theta2)*theta1_dot*theta2_dot)/2 + tau; ...
               d2*g*m2*(-sin(theta1)*cos(theta2) - sin(theta2)*cos(theta1)) - d2*l1*m2*(theta1_dot + theta2_dot)*sin(theta2)*theta1_dot + d2*l1*m2*sin(theta2)*theta1_dot*theta2_dot + g*l2*mball*(-sin(theta1)*cos(theta2) - sin(theta2)*cos(theta1)) - l1*l2*mball*(theta1_dot + theta2_dot)*sin(theta2)*theta1_dot + l1*l2*mball*sin(theta2)*theta1_dot*theta2_dot];

           
    dx = mass\forcing;
end

