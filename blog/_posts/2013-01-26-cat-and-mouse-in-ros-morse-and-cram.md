---
layout: post
tags: control ai_planning CRAM mobile_robot MORSE ROS simulation robotics
---
 
# 'Cat and mouse' game using ROS, Morse and CRAM

This is my first work using the [Cognitive Robot Abstract Machine](http://ias.in.tum.de/research/cram) (CRAM). It is an implementation of the "cat and mouse" game using [MORSE](http://www.openrobots.org/wiki/morse/), [ROS](http://www.ros.org) and [CRAM](http://www.ros.org/wiki/cram_core) as controller of the cat.

The mouse is controlled by the user using the keyboard and the cat follows the mouse using a CRAM plan. 

<iframe id="video" src="https://www.youtube.com/embed/CscEglTKEIU" 
    width="560" 
    height="315"
    frameborder="0" 
    allowfullscreen>
</iframe>

I used the example that comes with Morse but I have replaced the control script in Python for the cat by a CRAM plan. In addition, I added one pose sensor to the mouse robot and I used this sensor to know its position instead of the semantic cameras of the cat.

For create the CRAM plan I recycled some parts of the [tutorials](http://www.ros.org/wiki/cram_core/Tutorials) that you can find in ROS wiki. I used the [turtlesim controller](http://www.ros.org/wiki/cram_core/Tutorials/ControllingTurtlesimFromLisp) as base for my cat controller.

The source code is available in [GitHub](https://github.com/dgerod/morse_and_ros-cram_example).
