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

C2=zeros(1001,1);   %φάσμα ισχύος
fr=zeros(1001,1);   %δείγματα συχνοτήτων
counter=0;

for f= -0.5 :0.001: 0.5
   counter=counter+1;
   fr(counter)=f;  
        for L = -128 :128
            C2(counter)=c2(L+129)*exp(-1i*L*2*pi*f)+C2(counter);
        end
end
