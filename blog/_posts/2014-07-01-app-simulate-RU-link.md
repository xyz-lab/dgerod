---
layout: post
tags: C++ kinematics OpenGL QT robotics simulation
---

# Application to simulate a RU link

The objective of the task was to simulate a in a generic environment the kinematics behavior of one revolute joint and one universal joint. It includes the simulation of the motions of the mechanism. 

![image](https://user-images.githubusercontent.com/1392333/153741851-00d7d8a7-43b7-4b46-86d6-e177cec43c8a.png)

Therefore, I developed a GNU/Linux application in C++ and [QT](http://www.qt.io). The application was divided in three components: simulations, graphics and model importer.

![image](https://user-images.githubusercontent.com/1392333/153741854-fd6472ee-d759-4886-a0e6-a7d16727d0ec.png)

The simulation of the RU kinematics was done using [KDL](http://www.orocos.org/kdl) and a PTP movement using a polynomial 3 profile was created. For the visualization engine I used directly [OpenGL](https://www.opengl.org).

![image](https://user-images.githubusercontent.com/1392333/153741855-b16b4535-a24b-4436-9514-ab7224ea53f2.png)

Below you could a see video of the application that is upload in [my channel](https://www.youtube.com/channel/UCRX6SIvzNbPf7FUBhXc7iAw). And the code is stored in [GitHub](https://github.com/dgerod/simulate_RU_link).

<iframe id="video" src="https://www.youtube.com/embed/gUnaLO5bWQI" 
    width="560" 
    height="315"
    frameborder="0" 
    allowfullscreen>
</iframe>

This code was a quick prototype developed due to a special requested, I did it in 25 hours of effective work. As it was I developed in my free time, it is not completed, for example the importer is missing.
