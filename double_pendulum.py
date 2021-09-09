from sympy import symbols, asin, sin, simplify
from sympy.physics.mechanics import (
    Particle, Point, ReferenceFrame, RigidBody,
    dynamicsymbols, inertia, kinetic_energy,
    potential_energy, LagrangesMethod, mechanics_printing)
from sympy.utilities.lambdify import lambdify
from sympy.simplify import trigsimp
from sympy.printing import latex

import re

mechanics_printing(pretty_print=False)

l1, l2 = symbols("l1 l2")  # Link length
d1, d2 = symbols("d1 d2")  # Location of link c.o.m. along axis
I1, I2, Iball = symbols("I1 I2 Iball")  # Moments of inertia
m1, m2, mball = symbols("m1 m2 mball")  # Masses
g = symbols("g")
τ = symbols("τ")  # Torque on system

# Generalized coordinates
q = dynamicsymbols("θ1 θ2")
dq = dynamicsymbols("θ1 θ2", level=1)

# Inertial reference frame & origin
N = ReferenceFrame("N")  # Inertial reference frame
O = Point("O")
O.set_vel(N, 0)  # Set velocity to zero

# Frame of the first link
link1_frame = N.orientnew("link1", "axis", (q[0], N.z))
link1_frame.set_ang_vel(N, dq[0]*N.z)
C1 = O.locatenew("P", link1_frame.x*d1)
C1.v2pt_theory(O, N, link1_frame)
P = O.locatenew("P", link1_frame.x*l1)
P.v2pt_theory(O, N, link1_frame)

# Frame of the second link
link2_frame = link1_frame.orientnew("link2", "axis", (q[1], link1_frame.z))
link2_frame.set_ang_vel(link1_frame, dq[1]*N.z)
Q = P.locatenew("Q", link2_frame.x*l2)
Q.v2pt_theory(P, N, link2_frame)
C2 = P.locatenew("Q", link2_frame.x*d2)
C2.v2pt_theory(P, N, link2_frame)

# Rigid bodies
link1 = RigidBody("link1", C1, link1_frame, m1, (inertia(link1_frame, 0, 0, I1), C1))
link2 = RigidBody("link2", C2, link2_frame, m2, (inertia(link2_frame, 0, 0, I2), C2))
ball = RigidBody("ball", Q, link2_frame, mball, (inertia(link2_frame, 0, 0, Iball), Q))

# To compare with classic solution with two point masses
# testball1 = Particle("testball1", P, m1)
# testball2 = Particle("testball2", Q, m2)

link1.potential_energy = -C1.pos_from(O).dot(N.x)*link1.mass*g
link2.potential_energy = -C2.pos_from(O).dot(N.x)*link2.mass*g
ball.potential_energy = -Q.pos_from(O).dot(N.x)*ball.mass*g

# testball1.potential_energy = -P.pos_from(O).dot(N.x)*testball1.mass*g
# testball2.potential_energy = -Q.pos_from(O).dot(N.x)*testball2.mass*g

T = kinetic_energy(N, link1, link2, ball)  # Kinetic energy
V = potential_energy(link1, link2, ball)

forces = [(link1_frame, τ*N.z)]

L = T - V
LM = LagrangesMethod(L, q, forcelist=forces, frame=N)
LM.form_lagranges_equations()
mm_string = str(LM.mass_matrix_full)
fm_string = str(LM.forcing_full)

def matlab_syntax(string):
    # Matlab matrix formatting
    string = string[8:-2].replace('], [', ';\n ').replace('(t)', '')

    # Take care of Unicode Greek symbols
    greeks = {'ψ': 'psi', 'θ': 'theta', 'φ': 'phi', 'τ': 'tau'}
    for symbol in greeks.keys():
        string = string.replace(symbol, greeks[symbol])

    # Remove 'Derivative(phi, t)'
    string = re.sub(r'Derivative\((?P<symbol>\w*), t\)', lambda match: match.group('symbol') + '_dot', string)

    # Use caret symbol for powers
    string = string.replace("**", "^")

    return string

print(matlab_syntax(mm_string))
print(matlab_syntax(fm_string))
