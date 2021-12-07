clc
clear all

%G to X -------------------------------------------------------------------
XtoG = readmatrix('EigGtoXfinal.xlsx','Range','A1:C400');
zeig = readmatrix('eig0.xlsx','Range','A1:C8');
a = .03; %Unit Cell Size
N1 = 20; %Number of eigenfrequencies
kx = XtoG(:,1); %Wavenumber in the x direction
ky = XtoG(:,2); %Wavenumber in the y direction
frequency1 = sqrt(real(XtoG(:,3)).^2 + imag(XtoG(:,3)).^2) %Frequency
%This loop is the adjustment for the gamma boundary
for i = 1:8
    frequency1(5+i) = real(zeig(i,3));
end

beta = sqrt((kx./a).^2 + (ky./a).^2) %Non dimensional total wavenumber 
length(beta)
%We need to sort out this vector into each branch vector since it is not in
%the proper order as it currently sits.
for i = 0:19
    for j = 1:20
        beta2xg(i+1) = beta(j + N1*i);
    end
end

%This loop plots the Gamma-X leg of the band structure diagram
figure
for j = 1:20
    for i = 1:20
        freq2xg(i) = frequency1(j+N1*(i-1));
    end
    plot(beta2xg,freq2xg)
    hold on
end
hold off
title('G to X')



%M to G--------------------------------------------------------------------
MtoG = readmatrix('EigGtoMfinal.xlsx','Range','A1:C400');

Nm = 20;
kx1 = MtoG(:,1); %Wavenumber in the x direction
ky1 = MtoG(:,2); %Wavenumber in the y direction
frequncy2 = [];
beta = [];

frequency2 = sqrt(real(MtoG(:,3)).^2 + imag(MtoG(:,3)).^2); %Frequency Magnitude
%Note that the imaginary part is very small and hardly affects the
%magnitude.

%This loop corrects the results at the gamma boundary.
for i = 1:8
    frequency2(5+i) = sqrt(real(zeig(i,3))^2 + imag(zeig(i,3))^2);
end

beta = sqrt((kx1./a).^2 + (ky1./a).^2); %Non dimensional total wavenumber 
% % length(beta);

% We need to sort out this vector into each branch vector since it is not in
% the proper order as it currently sits
for i = 0:19
    for j = 1:20
        beta2mg(i+1) = beta(j + Nm*i);
    end
end
% % beta2mg;
% % length(beta2mg);

%Plotting the M-G leg of the band structure diagram
figure
for j = 1:20
    for i = 1:20
        freq2mg(i) = frequency2(j+Nm*(i-1));
    end
    plot(beta2mg,flip(freq2mg))
    hold on
end
hold off
title('M to G')

%X to M--------------------------------------------------------------------
XtoM = readmatrix('EigXtoMfinal.xlsx','Range','A1:C400');

Nxm = 20;
kx2 = XtoM(:,1); %Wavenumber in the x direction
ky2 = XtoM(:,2); %Wavenumber in the y direction
frequncy3 = [];
beta = [];
frequency3 = real(XtoM(:,3)); %Frequency


beta = sqrt((kx2./a).^2 + (ky2./a).^2); %Non dimensional total wavenumber 
length(beta)

%We need to sort out this vector into each branch vector since it is not in
%the proper order as it currently sits
for i = 0:19
    for j = 1:20
        beta2xm(i+1) = beta(j + Nxm*i);
    end
end
% beta2xm
% length(beta2xm)

figure
for j = 1:19
    for i = 1:20
        freq2xm(i) = frequency3(j+Nxm*(i-1));
    end
    plot(beta2xm,freq2xm)
    hold on
end
hold off
title('X to M')



%These loops make one figure with the three above plots, resulting in the
%final band structure diagram.
figure
for j = 1:N1
    for i = 1:20
        freq2xg(i) = frequency1(j+N1*(i-1));
    end
    plot(beta2xg + beta2xm(length(beta2xm))-beta2xm(1),flip(freq2xg))
    hold on
end
offset = beta2xg(length(beta2xg)) + (beta2xm(length(beta2xm)) - beta2xm(1));
for j = 1:Nm
    for i = 1:20
        freq2mg(i) = frequency2(j+Nm*(i-1));
    end
    plot(beta2mg+offset,freq2mg)
    hold on
end
for j = 1:Nxm
    for i = 1:20
        freq2xm(i) = frequency3(j+Nxm*(i-1));
    end
    plot(beta2xm - beta2xm(1),flip(freq2xm))
    hold on
end
title('M-X-Gamma-M')
ylabel('Frequency')
hold off