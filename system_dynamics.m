function [dx, y] = system_dynamics(t, x, u, d1, d2, l1, l2, I1, I2, Iball, m1, m2, mball, R, L, Kr, A, varargin)

    % u = input voltage
    g = 9.810665;

    theta1 = x(1);
    theta2 = x(2);
    theta1_dot = x(3);
    theta2_dot = x(4);
    
    current = x(5);
    tau = Kr*current;
    
    mass = [1, 0, 0, 0; ...
            0, 1, 0, 0; ...
            0, 0, I1 + I2 + Iball + d1^2*m1 + m2*(2*d2^2 + 4*d2*l1*cos(theta2) + 2*l1^2)/2 + mball*(2*l1^2 + 4*l1*l2*cos(theta2) + 2*l2^2)/2, I2 + Iball + m2*(2*d2^2 + 2*d2*l1*cos(theta2))/2 + mball*(2*l1*l2*cos(theta2) + 2*l2^2)/2; ...
            0, 0, I2 + Iball + m2*(2*d2^2 + 2*d2*l1*cos(theta2))/2 + mball*(2*l1*l2*cos(theta2) + 2*l2^2)/2, I2 + Iball + d2^2*m2 + l2^2*mball];

    forcing = [theta1_dot; ...
               theta2_dot; ...
               -d1*g*m1*sin(theta1) - g*m2*(-d2*(-sin(theta1)*cos(theta2) - sin(theta2)*cos(theta1)) + l1*sin(theta1)) - g*mball*(l1*sin(theta1) - l2*(-sin(theta1)*cos(theta2) - sin(theta2)*cos(theta1))) - m2*(-2*d2*l1*(theta1_dot + theta2_dot)*sin(theta2)*theta2_dot - 2*d2*l1*sin(theta2)*theta1_dot*theta2_dot)/2 - mball*(-2*l1*l2*(theta1_dot + theta2_dot)*sin(theta2)*theta2_dot - 2*l1*l2*sin(theta2)*theta1_dot*theta2_dot)/2 + tau; ...
               d2*g*m2*(-sin(theta1)*cos(theta2) - sin(theta2)*cos(theta1)) - d2*l1*m2*(theta1_dot + theta2_dot)*sin(theta2)*theta1_dot + d2*l1*m2*sin(theta2)*theta1_dot*theta2_dot + g*l2*mball*(-sin(theta1)*cos(theta2) - sin(theta2)*cos(theta1)) - l1*l2*mball*(theta1_dot + theta2_dot)*sin(theta2)*theta1_dot + l1*l2*mball*sin(theta2)*theta1_dot*theta2_dot];

           
    dx(1:4) = mass\forcing;
    dx(5) = 1/L*(A*u - R*current - Kr*theta1_dot);
    
    y = x(1:2);

end

