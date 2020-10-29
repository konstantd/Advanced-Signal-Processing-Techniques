function C3=indirect_method_beltisto(x,K,M)

C3=zeros(51,51); 

%���������
 segm=zeros(K,M);
 
for i=0:(K-1)
    for j=1:M      
        segm(i+1,j)=x(M*i+j);
    end
end


%�������� ����� ����� ��� ���� ����������

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
    
%E������� ����� 3�� �����

r=zeros(K,129,129);   %��� r(1) �� m-64, ��� r(65) �� m=0, ��� r(129) �� m=+64 
  
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
  
  
 %M��� ���� ���� ��� ����������

 c3=zeros(129,129);     %��� c3(1) �� m-64, ��� c3(65) �� m=0, ��� c3(129) �� m=+64 
 

  for m= -64:64
  for n = -64:64
       for i=1:K
    c3(m+65,n+65)= r(i, m+65,n+65)+c3(m+65,n+65);
    end
      c3(m+65,n+65)=c3(m+65,n+65)/K;

  end
 end
 
 

 %�������� ��������
 
 d=zeros(1,129);   %��� d(1) �� m-64, ��� d(65) �� m=0, ��� d(129) �� m=+64 
 for i=-64:64
     d(i+65)=(1/pi)*abs(sin(pi*i/64))+(1-abs(i)/64)*cos(pi*i/64);
 end
 
 
 %Smoothing Window 
  W=zeros(129,129);
 
 for m=-64:64
       for n=-64:64
           if abs(n-m)>64    %����� d(m)=0 ��� m>L
                W(m+65,n+65)=0;
           else
 W(m+65,n+65)=d(m+65)*d(n+65)*d((n-m)+65);
       end
 end
 end

 %-------------------------------------------------------------------
 
 
 %�������� ��� bispectrum

 for counter1= 0: 1: 50
   for counter2= 0: 1: 50
       
       f1=counter1*0.02-0.5;   %f1 ��� f2 ������� ��� [-0.5,+0.5]
       f2=counter2*0.02-0.5;
    if abs(f1+f2)<=0.5         %��������� �������
       for m=-64:64
        for n=-64:64
        C3(counter1+1,counter2+1) =  c3(m+65,n+65)*W(m+65,n+65) * exp(-1i*(2*pi*f1*m+2*pi*f2*n)) + C3(counter1+1,counter2+1);
        end
       end
    end
   end
 end
 
 
end

 
    