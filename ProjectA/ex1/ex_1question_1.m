%Formation of X[k]

omega=zeros(1,6);
lambda=zeros(1,6);
phi=zeros(1,6);

lambda(1)=0.12;
lambda(2)=0.30;
lambda(4)=0.19;
lambda(5)=0.17;

lambda(3)=lambda(1)+lambda(6);
lambda(6)=lambda(4)+lambda(5);

%Ανεξάρτητες ομοιόμορφα κατανεμημένες φ1, φ2, φ4, φ5
%Uniformly distributed random numbers  
phi(1)= 2*pi*rand;
phi(2)= 2*pi*rand;
phi(4)= 2*pi*rand;
phi(5)= 2*pi*rand;

phi(3)=phi(1)+phi(2);
phi(6)=phi(4)+phi(5);

for i=1:6
    omega(i)=2*pi*lambda(i);
end

N=8192;

x=zeros(1,N); 
for k = 0 :(N-1)       %στη πρώτη θέση x(1) αποθηκευμένο για k=0
for i=1:6
   x(k+1) = cos( omega(i)*k+phi(i) ) + x(k+1);
end
end
