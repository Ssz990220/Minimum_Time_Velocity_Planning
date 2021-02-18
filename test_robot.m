robot = three_link_robot;
qn = robot.ikine([0.5,0,0.1])
robot.fkine(qn)