function [relative_error] = PIVfunction(image1,image2,imgcoord,Mask,coordinate,a,k,omega,rng,subw,overlape)
% Function for compute the velocity, surface elevation and relative error.
% When we choose the point in the coordinate picture, I jump four points in
% x and y direction.
% The imput arguments image 1 and image 2 matrix, coordinate matrix,
% amplitude, wavenumber, and angular frequency.


coord = imread(imgcoord);
figure(21);
imagesc(coord)
%Select reference points in pixel coordinate            
%h1 = impoly;
%pixel = h1.getPosition;
    

pixel = coordinate;


L = length(pixel);

% Refine pixel positions
c = graythresh(coord);
bw = im2bw(coord);
cc = bwconncomp(bw);
stats = regionprops(cc,'Centroid');
xc = vertcat(stats.Centroid);
idx = knnsearch(xc,pixel);
pixel = xc(idx,:);

% Define matching reference points in world coordinate
px_size = 4/abs(pixel(2,1)-pixel(1,1));
wxwy = pixel*px_size/100;
surface = 400*px_size/100;
world= transpose([wxwy(1:L)-0.14;-wxwy(L+1:L*2)+surface]);

% Create a polygonal mask

im1 = imread(image1);
im2 = imread(image2);

%figure(22);
%imagesc(im1);
%set(gca,'Ydir','reverse')
%h = impoly();
%mask = h.createMask();

mask = Mask;


opt1 = setpivopt('range',[-rng rng -rng rng],'subwindow',subw,subw,overlape);
piv1 = normalpass([],im1,[],im2,[],opt1);
[U,V,x,y] = replaceoutliers(piv1);

% Creat the coordinate system
[tform,err,errinv] = createcoordsystem(pixel,world,'linear');

% Compute the position and velocity in world coordinate

dt = 0.0167;
[U1,V1,x1,y1] = replaceoutliers(piv1,mask);
[Uw,Vw,xw,yw] = pixel2world(tform,U1,V1,x1,y1,dt);

% Surface
[idx1,eta1] = max(mask);
[etax,etay] = tformfwd(tform,1:2048,eta1);

H = 0.333;
NN = length(xw(1,:));
t = linspace(0,dt,NN);

axis_size = 15;
fontSize1 = 20;
fontSize2 = 14;
width = 1.2;

% Theorytical eta for linear waves

ak = a*k;
if ak > 0.1
    ETA = a*((1-(1/6*(k*a)^2))*cos(k*xw(1,:) - omega*t) + (0.5*k*a)...
        *cos(2*(k*xw(1,:) - omega*t))+ 3/8*(k*a)^2*cos(3*(k*xw(1,:) - omega*t)));
else
    ETA = a*cos(k*xw(1,:) - omega*t);
end

figure(3);
quiver((xw)/H,yw/H,Uw,Vw,'b','LineWidth',width);
hold on;
plot(etax/H,etay/H,'r--','LineWidth',width);
hold on;
plot(xw(1,:)/H,ETA/H,'k--','LineWidth',width);
set(gca,'fontsize',axis_size);
xlabel('$\frac{x}{H}$','interpreter','latex','FontSize', fontSize1);
ylabel('$\frac{y}{H}$','interpreter','latex','FontSize', fontSize1);
title('Velocity fields','FontSize', fontSize2)
legend('$\mathbf{u}$','$\eta$','$\eta$ theory','interpreter','latex',...
    'FontSize', fontSize2)
hold off;


% Finding the index of the crest

[M,I] = max(abs(Uw));
[MAX,idx] = max(M);
non_NaN_idx = find(~isnan(Uw(:,idx)));

% Analytic solution linear

g = 9.81;
v_analytic = a*omega*exp(k*yw(non_NaN_idx,idx));


% Dimensionless the velocity profile linear
u_tilde = exp(k*yw(non_NaN_idx,idx));
u_tilde_num = (Uw(non_NaN_idx,idx))*omega/(a*k*g);
Y = yw(non_NaN_idx,idx)*k;

% Plot comparison(dimension)
figure(4);
plot(v_analytic,yw(non_NaN_idx,idx),'LineWidth',width)
hold on
plot(Uw(non_NaN_idx(1:end),idx),yw(non_NaN_idx(1:end),idx),'+','LineWidth',width)
hold off
set(gca,'fontsize',axis_size);
xlabel('$u$[m/s]','interpreter','latex','FontSize', fontSize1);
ylabel('$y$[m]','interpreter','latex','FontSize', fontSize1);
title('The analytical velocity profile vs. experiment on the wave crest',...
      'FontSize', fontSize2)
legend('Theory','Experiment','FontSize', fontSize2)


% Plot comparison(dimensionless)
figure(5);
plot(u_tilde(1:end),Y(1:end),'LineWidth',width)
hold on
plot(u_tilde_num(1:end),Y(1:end),'*','LineWidth',width)
hold off
set(gca,'fontsize',axis_size);
xlabel('$\tilde{u}$','interpreter','latex','FontSize', fontSize1);
ylabel('$\tilde{y}$','interpreter','latex','FontSize', fontSize1);
title('The analytical velocity profile vs. experiment on the wave crest',...
'FontSize', fontSize2);
legend('Theory','Experiment','FontSize', fontSize2)


% Compute relativ error of single measurement
mean_v_num = mean(abs(Uw(non_NaN_idx(1:end),idx)));
mean_v_analytic = mean(v_analytic(1:end));
relative_error = (mean_v_num - mean_v_analytic)/mean_v_analytic*100;

end

