l1 = Link('d',0.2,'a',0,'alpha',pi/2,'m',1.5,'r',[0;-0.12;0],'I',[7.5;7.5;7.5]);
l2 = Link('d',0,'a',0.3,'alpha',0,'m',1.5,'r',[-0.18;0;0],'I',[5.7;5.7;5.7]);
l3 = Link('d',0 ,'a',0,'alpha',0,'m',1.5,'r',[0.13;0;0],'I',[4.75;4.75;4.75]);
tool = [1,0,0,0.325;0,1,0,0;0,0,1,0;0,0,0,1];
% robot = SerialLink([l1,l2],'tool',tool,'gravity',[0;0;9.81]);
robot = SerialLink([l1,l2,l3],'tool',tool,'gravity',[0;0;9.81]);
robot.display();
robot.plot([0,0.2,0]);
% 
% robot.fkine([0,0,0])
% robot.inertia([0,0,0]);
% robot.coriolis([0,0,0],[0,0,0]);