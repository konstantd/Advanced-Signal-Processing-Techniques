C2=zeros(1001,1);   %φάσμα ισχύος  %mono ayto ap ekso
C3=zeros(51,51); 
K=32;
M=256;

for j=1:50
  

ex_1question_1




%Power Spectrum

%Εύρεση μέσης τιμής m1
s=0;
for k = 0 :(N-1)
    s= x(k+1)+s;
end
m1=s/N;
%----------------------



%Autocorelation m2
m2=zeros(257,1);            %Στη μέση του πίνακα m2(129) για τ=0

%symmetablhtothta c2
c2=zeros(257,1);


 for L = -128 :128   %μετατοπίσεις
      s=0;
         for k = 129 : N-128         
       s= (x(k)*x(k+L) )+s;   
    end
  m2(L+129)= s /N;
        c2(L+129)=m2(L+129)-m1*m1;
end
%-----------------------------------------

fr=zeros(1001,1);   %δείγματα συχνοτήτων
counter=0;

for f= -0.5 :0.001: 0.5
   counter=counter+1;
   fr(counter)=f;  
        for L = -128 :128
            C2(counter)=c2(L+129)*exp(-1i*L*2*pi*f)+C2(counter);
        end
end



%----------------------------------------------------------------------



%Κατάτμηση
 segm=zeros(K,M);
 
for i=0:(K-1)
    for j=1:M      
        segm(i+1,j)=x(M*i+j);
    end
end


%Αφαίρεση μέσης τιμής του κάθε υποσυνόλου

  average_seg=zeros(K,1);
  
  for i=1:K
      s=0;
    for j=1:M
    s=segm(i,j)+s;
    end
    average_seg(i)=s/M;    
  end
  
    for i=1:K
    for j=1:M
    segm(i,j)=segm(i,j)-average_seg(i);
    end
    end
    
%Eκτίμηση ροπής 3ης τάξης

r=zeros(K,129,129);   %Στο r(1) το m-64, στο r(65) το m=0, στο r(129) το m=+64 
  
  for i=1:K
  for m = -64 :64 
  for n = -64:64
      
     pin_max=[0 -m -n];
     pin_min=[M-1   M-1-m   M-1-n];   
     s1=max(pin_max); 
     s2=min(pin_min);
     s=0;
   for l=s1:s2
       s=segm(i,l+1)*segm(i,l+1+m)*segm(i,l+n+1)+s;
   end
   r(i,m+65,n+65)=s/M;

  end
  end
  end
  
  
 %Mέση τιμή όλων των υποσυνόλων

 c3=zeros(129,129);     %Στο c3(1) το m-64, στο c3(65) το m=0, στο c3(129) το m=+64 
 

  for m= -64:64
  for n = -64:64
       for i=1:K
    c3(m+65,n+65)= r(i, m+65,n+65)+c3(m+65,n+65);
    end
      c3(m+65,n+65)=c3(m+65,n+65)/K;

  end
 end
 
 

 %Βέλτιστο παράθυρο
 
 d=zeros(1,129);   %Στο d(1) το m-64, στο d(65) το m=0, στο d(129) το m=+64 
 for i=-64:64
     d(i+65)=(1/pi)*abs(sin(pi*i/64))+(1-abs(i)/64)*cos(pi*i/64);
 end
 
 
 %Smoothing Window 
  W=zeros(129,129);
 
 for m=-64:64
       for n=-64:64
           if abs(n-m)>64    %Είναι d(m)=0 για m>L
                W(m+65,n+65)=0;
           else
 W(m+65,n+65)=d(m+65)*d(n+65)*d((n-m)+65); %SVSTOOOOO
       end
 end
 end

 %-------------------------------------------------------------------
 
 
 %Εκτίμηση του bispectrum

 for counter1= 0: 1: 50
   for counter2= 0: 1: 50
       
       f1=counter1*0.02-0.5;   %f1 και f2 τρέχουν στο [-0.5,+0.5]
       f2=counter2*0.02-0.5;
    if abs(f1+f2)<=0.5         %Τριγωνική περιοχή
       for m=-64:64
        for n=-64:64
        C3(counter1+1,counter2+1) =  c3(m+65,n+65)*W(m+65,n+65) * exp(-1i*(2*pi*f1*m+2*pi*f2*n)) + C3(counter1+1,counter2+1);
        end
       end
    end
   end
 end
 
 %-------------------------------------------------------------------------------------------------



end

%Plot Power Spectrum

plot(fr,abs(C2)/50)    %Μπαίνει εδώ για το τελευταίο ερώτημα
title('Power Spectrum')   
xlabel('f')
ylabel('Magnitude')


%Plot Bispectrum

f1=[-0.5:0.02:0.5];
f2=[-0.5:0.02:0.5];
contour(f1,f2, abs(C3))
str=sprintf('Bispectrum Indirect Method Optimal window');
title(str)
xlabel('f1')
ylabel('f2')
colorbar