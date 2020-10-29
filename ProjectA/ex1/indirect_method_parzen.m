function C3=indirect_method_parzen(x,K,M)

C3=zeros(51,51); 

%Κατάτμηση
 
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

r=zeros(K,129,129);  
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

 c3=zeros(129,129);
  for m = -64:64
  for n = -64:64
       for i=1:K
    c3(m+65,n+65)= r(i, m+65,n+65)+c3(m+65,n+65);
    
       end
  c3(m+65,n+65)=c3(m+65,n+65)/K;

  end      
 end
 
 

%Parzen Window
 dp=zeros(1,129);    %sto dp(1) to -64 sto dp(65) to 0
 for i=-64:64
     if  (abs(i)<=32)      %if |m| <= L/2
        dp(i+65)= 1-6*(abs(i)/64)^2+6*(abs(i)/64)^3;
     else
           dp(i+65)=2*(1-abs(i)/64)^3;
     end
 end
 

   %Smoothing Window 
W=zeros(129,129);
 for m=-64:64
       for n=-64:64
           if abs(n-m)>64
              W(m+65,n+65)=0;    %Είναι d(m)=0 για m>L
           else
              W(m+65,n+65)=dp(m+65)*dp(n+65)*dp((n-m)+65); 
           end
        end
 end
 
 
 
 
 %Εκτίμηση του bispectrum
  
 for counter1= 0: 1: 50 
  for counter2= 0: 1: 50
       
       f1=counter1*0.02-0.5;  %f1 και f2 τρέχουν στο [-0.5,+0.5]
       f2=counter2*0.02-0.5;
     if abs(f1+f2)<=0.5  %Τριγωνική περιοχή
          for m=-64:64
          for n=-64:64
             C3(counter1+1,counter2+1) =  c3(m+65,n+65)*W(m+65,n+65) * exp(-1i*(2*pi*f1*m+2*pi*f2*n)) + C3(counter1+1,counter2+1);
          end
          end
    end
   end
 end



 end
 