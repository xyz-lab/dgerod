---
layout: post
tags: robotics delta-3_robot robot kinematics algorithms note
---

# Kinematics of a delta-3 robot

Parallel manipulators are robotic devices that differ from the more traditional serial robotic manipulators by virtue of their kinematics structure. Parallel manipulators are composed of multiple closed kinematics loops.

The delta-3 robot is a three degree of freedom parallel manipulator. It was designed by Clavel (1988) et al. at the [Swiss Federal Institute of Technology](http://www.ethz.ch). This manipulator robot has only translational degrees of freedom.

It is interesting to have a model of the robot for doing this study .

## Analysis of the Robot

The delta-3 robot (DR-3) is composed by two parallel platforms named as End-Effector and Fixed-Framed; and three symmetric legs (see figure below).

The Fixed-Frame (FF) is usually attached to a fixed surface and the tool of the robot is mounted in the TCP-0 which is placed on the center of the End-Effector. The End-Effector (EE) could also be named as travel plate because it is the mobile base of the robot.

![image](https://user-images.githubusercontent.com/1392333/153739553-6e34f236-a12c-4f32-977a-aca76f8d974b.png)

Scheme of delta-3 robot

Each leg is composed by two links and three joints (RUU); the actuated joint is rotational (R) and the two passive joints are universal (U). And their position in the robot is named as Fi, Gi and Ei (see previous figure), respectively; where the index i is the number of the leg (1, 2 or 3).

![image](https://user-images.githubusercontent.com/1392333/153739558-806230b1-b105-467b-b3ce-acad61be107f.png) ![image](https://user-images.githubusercontent.com/1392333/153739561-b15d216b-20c3-4650-aead-44ad7bd1b54d.png)

Spheres defined by the passive joints (placed in G and E) and Link 2, and circle defined by the actuated joint placed in F and Link1

F1, F2 and F3 are the positions in the Fixed-Frame of the actuated joints, J1, J2 and J3 respectively.

## Kinematics

The configuration parameters of a robot are the parameters which define a specific model of a robot type. For a DELTA-3 robot the geometry of its mechanical structure is directly used as configuration parameters:

- Side length of end-effector (EE)
- Length of link 2, from knee(E) to ankle(C)
- Length of link 1, from hip(D) to knee(E)
- Side length of fixed-frame (FF)

The [algorithms](https://github.com/dgerod/rtsx) for solving the Kinematics Problem of the delta-3 robot was developed using [Scilab](http://www.scilab.org).
