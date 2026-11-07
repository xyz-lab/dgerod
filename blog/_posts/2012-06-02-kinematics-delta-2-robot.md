---
layout: post
tags: robotics delta-2_robot robot kinematics algorithms note
---

# Kinematics of a delta-2 robot 

A [delta-2 robot](https://www.youtube.com/watch?v=57WoQSqxPW0) is a parallel robot composed by two legs, each one has three rational joints but only the one attached to the fixed-frame (or top-plate) is not a passive joint. Therefore, to move the end-effector position (TCP-0) of the robot the two active joints must be controlled.

The delta-2 robot can be seen as a simplification of the [delta-3 robot](http://en.wikipedia.org/wiki/Delta_robot), and it is usually used in the packaging industry for pick products on a conveyor belt. You can see some models [here](https://www.google.com/search?q=delta+3+robot).

![image](https://user-images.githubusercontent.com/1392333/150633759-a5bd9f3d-a10a-4ef1-a8fb-4810e656feda.png)

Due to its mechanical configuration this robot can only move its end-effector on plane XZ, see figure belowt. And its TCP-0 is defined by (x,0,z).

![image](https://user-images.githubusercontent.com/1392333/150633766-735d3a7d-bda6-45f3-929f-0503603fc0a8.png)

The kinematics of the delta-2 robot can be solved using a geometric method. For doing this, we model the robot (see figure abowe) using four kinematics parameters: rf,lf, le, re.
The parameter rf is the distance between the center of the fixed-frame to the position of the active joint, re is the distance between the center of the end-effector (E) and the position of the passive joint (F), and lf and le are the lengths of the links of a leg. And the link 1 and link 2 of a robot leg are connected in point G.

The [algorithms](https://github.com/dgerod/RTSX) for solving the Kinematics Problem of the delta-2 robot have been developed using [Scilab](http://www.scilab.org). 

# Inverse kinematics

For knowing the joins (j1,j2) from the end-effector position (TCP-0) we must solve the inverse kinematics problem.

![image](https://user-images.githubusercontent.com/1392333/150633772-bd53668d-88f1-4c61-aab4-0d14ab511f4c.png)

(le) as radius. And the second circle (red) has point F as center and the length link 1 (lf) as radius.
Once you know position of G, the value of the joint is calculated as the angle defined by the axis X and the line that connect F with G, that's the real position of the link 1.

This method is applied independently for each leg of the robot.

# Direct kinematics

And we can calculated the end-effector position (TCP-0) from the joint values (j1,j2) solving the kinematics problem.

![image](https://user-images.githubusercontent.com/1392333/150633775-3f549b62-2d19-4ae0-9a07-41bbd7bfb86c.png)

The end-effector position (E) is obtained from the intersection of the two circles (cyan) defined by the link 2 of each robot leg. The center of each circles is defined by G and the radius by the length of the link (le). And the point G is 
calculated by trigonometry using the value of the joint, the length of the link 1 (lf) and the position of F.
