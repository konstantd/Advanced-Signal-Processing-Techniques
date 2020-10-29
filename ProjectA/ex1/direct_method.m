function C3 = direct_method(x,K,M)

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
    
     
   %Δημιουργία Συντελεστών Y
    Y=zeros(K,M/2+1);
  for i=1:K   
   for lambda=0:M/2
      % omega=2*pi*lambda/256;
     f=lambda/M;
       for k=0:M-1
           Y(i,lambda+1)=segm(i,k+1)*exp(-1i*((2*pi)^2)*k*f/M)+Y(i,lambda+1);   
       end
       Y(i,lambda+1)=Y(i,lambda+1)/M;
    end
   end
   
   
   %Εκτίμηση - Πίνακας b
   Do=1/M;
   b=zeros(K,M/2+1,M/2+1);
   for i=1:K
   for lambda1= 0:M/2
   for lambda2= 0:M/2
        omega1=2*pi*lambda1/M;      %Κάθε λάμδα αντιστοιχεί σε μία ω
        omega2=2*pi*lambda2/M;

       if omega1+omega2<= pi  %Τριγωνική περιοχή
         b(i,lambda1+1,lambda2+1) = Y(i,lambda1+1)*Y(i,lambda2+1)*conj(Y(i,lambda1+lambda2+1))/(Do^2);
       end
    end
    end
   end
   
%Υπολογισμός Bispectrum
C3=zeros(M/2+1,M/2+1);
  for lambda1= 0:M/2
  for lambda2= 0:M/2
       for i=1:K
         C3(lambda1+1,lambda2+1)=b(i,lambda1+1,lambda2+1)+ C3(lambda1+1,lambda2+1);
       end
        C3(lambda1+1,lambda2+1)= C3(lambda1+1,lambda2+1) / K;
  end
  end

 %Συμμετρία 
 for lambda1= 0:M/2
 for lambda2= 0:M/2
    if lambda1+lambda2 < M/2	  %Στοιχεία του πίνακα κάτω αριστερά της διαγωνίου 
      C3(M/2+1-lambda1,M/2+1-lambda2)=C3(lambda1+1,lambda2+1);
    end
 end
 end

end

   
    

   
   
   
    