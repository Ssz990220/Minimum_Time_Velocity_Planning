classdef three_link_robot
    %THREE_LINK_ROBOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        n_dof
        robot
    end
    
    methods
        function obj = three_link_robot
            %THREE_LINK_ROBOT Construct an instance of this class
            %   Detailed explanation goes here
            obj.n_dof = 3;
            l1 = Link('d',0.2,'a',0,'alpha',pi/2,'m',1.5,'r',[0;-0.12;0],'I',[7.5;7.5;7.5]);
            l2 = Link('d',0,'a',0.3,'alpha',0,'m',1.5,'r',[-0.18;0;0],'I',[5.7;5.7;5.7]);
            l3 = Link('d',0 ,'a',0,'alpha',0,'m',1.5,'r',[0.13;0;0],'I',[4.75;4.75;4.75]);
            tool = [1,0,0,0.325;0,1,0,0;0,0,1,0;0,0,0,1];
            obj.robot = SerialLink([l1,l2,l3],'tool',tool,'gravity',[0;0;9.81]);
            obj.robot.display()
        end
        
        function qn = ikine(obj, target)
            q1 = atan2(target(:,2),target(:,1));
            dis2j1 = sqrt(sum((target - [0,0,0.2]).^2,2));
            dis2z = sqrt(target(:,2).^2+target(:,1).^2);
            q3 = acos((-dis2j1.^2+0.3^2+0.325^2)/(2*0.2*0.3)) - pi;
            q2 = acos((dis2j1.^2+0.3^2-0.325^2)./(2*0.3*dis2j1))+atan2(target(:,3) - 0.2,dis2z);
            qn = [q1,q2,q3];
        end
        
        function fkine(obj, qn)
            obj.robot.plot(qn);
            
        end
        
        function [ds, cs, gs] = get_dcg(obj, qs, qds, qdds)
            Ds = obj.robot.inertia(qs);
            Cs = obj.robot.coriolis(qs, qds);
            gs = obj.robot.gravload(qs);
            qds = reshape(qds', [obj.n_dof, 1, size(qds,1)]);
            qdds = reshape(qdds', [obj.n_dof, 1, size(qdds,1)]);
            ds = pagemtimes(Ds, qds);
            ds = reshape(ds, [obj.n_dof, size(ds,3)])';
            cs = pagemtimes(Ds, qdds) + pagemtimes(Cs, qds);
            cs = reshape(cs, [obj.n_dof, size(cs,3)])';           
        end
        
    end
end

