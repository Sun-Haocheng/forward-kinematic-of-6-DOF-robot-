%采样数step
int8 step;
int8 i;
step=100;
i=1;
X=zeros(step);
Y=zeros(step);
Z=zeros(step);
phip=zeros(step);
thetap=zeros(step);
psip=zeros(step);
%变量theta,t,time
single theta;
single t;
single time;
time=0.02:2/step:2;
%alpha
ap=[-pi/2 0 0 pi/2 -pi/2 0];
%theta
single theta;
theta=0;
%a
a=[0 425 392.43 0 0 0];
%d
d=[89.2 135.7 -36.7 0 93 82];
%标准DH坐标
%DH=[ap;th;a;d];

for t=0:2/step:2
    th=[theta-pi/2 theta-pi/2 theta theta+pi/2 theta theta-pi/2];
    if t>=0&&t<=1
        theta=pi/12*t^2;
    else
        theta=pi/12+pi/6*(t-1)-pi/12*(t-1)^2;
    end
    %各变换矩阵
    t01=[cos(th(1)) -sin(th(1))*cos(ap(1)) sin(th(1))*sin(ap(1)) a(1)*cos(th(1));
     sin(th(1)) cos(th(1))*cos(ap(1)) -cos(th(1))*sin(ap(1)) a(1)*sin(th(1));
     0          sin(ap(1))             cos(ap(1))            d(1);
     0          0                      0                     1];
    t12=[cos(th(2)) -sin(th(2))*cos(ap(2)) sin(th(2))*sin(ap(2)) a(2)*cos(th(2));
     sin(th(2)) cos(th(2))*cos(ap(2)) -cos(th(2))*sin(ap(2)) a(2)*sin(th(2));
     0          sin(ap(2))             cos(ap(2))            d(2);
     0          0                      0                     1];
    t23=[cos(th(3)) -sin(th(3))*cos(ap(3)) sin(th(3))*sin(ap(3)) a(3)*cos(th(3));
     sin(th(3)) cos(th(3))*cos(ap(3)) -cos(th(3))*sin(ap(3)) a(3)*sin(th(3));
     0          sin(ap(3))             cos(ap(3))            d(3);
     0          0                      0                     1];
    t34=[cos(th(4)) -sin(th(4))*cos(ap(4)) sin(th(4))*sin(ap(4)) a(4)*cos(th(4));
     sin(th(4)) cos(th(4))*cos(ap(4)) -cos(th(4))*sin(ap(4)) a(4)*sin(th(4));
     0          sin(ap(4))             cos(ap(4))            d(4);
     0          0                      0                     1];
    t45=[cos(th(5)) -sin(th(5))*cos(ap(5)) sin(th(5))*sin(ap(5)) a(5)*cos(th(5));
     sin(th(5)) cos(th(5))*cos(ap(5)) -cos(th(5))*sin(ap(5)) a(5)*sin(th(5));
     0          sin(ap(5))             cos(ap(5))            d(5);
     0          0                      0                     1];
    t56=[cos(th(6)) -sin(th(6))*cos(ap(6)) sin(th(6))*sin(ap(6)) a(6)*cos(th(6));
     sin(th(6)) cos(th(6))*cos(ap(6)) -cos(th(6))*sin(ap(6)) a(6)*sin(th(6));
     0          sin(ap(6))             cos(ap(6))            d(6);
     0          0                      0                     1];
    t06=t01*t12*t23*t34*t45*t56;
    %提取末端坐标和欧拉角
    px=t06(1,4);
    py=t06(2,4);
    pz=t06(3,4);
    
    phi=atand(t06(3,1)/t06(3,2));
    thetax=acosd(t06(3,3));
    psi=atand(-t06(1,3)/t06(2,3));
    %存储每次计算的末端坐标和欧拉角
    X(i)=px;
    Y(i)=py;
    Z(i)=pz;
    phip(i)=phi;
    thetap(i)=thetax;
    psip(i)=psi;
    i=i+1;
end
figure(1)
plot3(X,Y,Z)%末端轨迹图
figure(2)
plot(time,phip)%欧拉角Φ变化图
figure(3)
plot(time,thetap)%欧拉角Θ变化图
figure(4)
plot(time,psip)%欧拉角ψ变化图