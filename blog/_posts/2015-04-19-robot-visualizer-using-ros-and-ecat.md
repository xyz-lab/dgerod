---
layout: post
tags: robotics delta-3_robot ROS visualizer robot ECAT
---

# A visualizer for our robots done using ROS and EtherCAT

In the MDT we were thinking about using ROS as development framework to make our life easy when we develop our own machine controller, the NJ controller that integrates [robotics functions](http://industrial.omron.eu/en/products/catalogue/motion_and_drives/machine_automation_controllers/nj_series/nj5_robotics/default.html).

![image](https://user-images.githubusercontent.com/1392333/153720224-1dd30418-bf0c-41b3-8b62-a8193aae4ddf.png)

The NJ controller is programmed using the SYSMAC ￼Studio IDE and it can control 64 servo-drives through the EtherCAT field bus. Due to that, the visualizer is installed on a normal PC with an EtherCAT slave card; and it runs on Ubuntu 14.04 LTS and ROS Indigo.

![image](https://user-images.githubusercontent.com/1392333/153720213-e5d987a5-1c7e-482d-a337-2ca5348e5c67.png)

The visualizer is composed by two main parts:

- The simulator of EtherCAT slaves.
- The ROS meta-package that visualizes the family of delta robots.

The EtherCAT slave simulator reads the axes commanded positions sent by the controller, forwards them to a ROS node, and closes the loop providing feedback to the controller. After that the ROS meta-package calculates the full positions of the delta robots based on the provided positions and visualizes them using RViz.

![image](https://user-images.githubusercontent.com/1392333/153720236-123353b7-520e-471c-936b-ed757b87c5a6.png) ![image](https://user-images.githubusercontent.com/1392333/153720241-46ccc0de-4589-4999-81ee-a98d00211ee5.png)

The work was done by [F. Martí](https://github.com/FelipMarti) during his winter internship at [OMRON Industrial Automation](https://industrial.omron.eu). And in his [Vimeo account](https://vimeo.com/felipmarti) you could see the [video of the system working](https://vimeo.com/118338456) at the Robotics Lab of the MDT that is placed in Barcelona (Spain).

Information about this project was also published in [ROS Blog](http://www.ros.org/news/2015/04/visualizer-of-delta-robots-using-ros-and-ethercat.html).
