%define my data 
v=exprnd(1,[1,2048]);   
b=[1.0 0.93 0.85 0.72 0.59 -0.10];
q=5; %MA order


%������� ����������� ������ x[k]
x=zeros(1,2048);
for k=1:2048
for i=0:q
       if (k-i)<1    %������� ���� ���� ���� k-i=0 �� ��� ����������� �� �������� 
          break
       else
          x(k)=b(i+1)*v(k-i)+ x(k);
       end
end
end


%���� ���� m1v
m1v=0;
for i=1:2048
    m1v= v(i)+m1v;
end
m1v=m1v/2048;

%������ �������� � standard deviation
sd=0;
for i=1:2048
sd = ((v(i)-m1v*m1v)^2 + sd);
end
sd = sqrt(sd/2048);

%�������� (skewness) �3 ��� v[k]
skewness= 0;
for i=1:2048
skewness = (v(i)- m1v)^3  + skewness;
end
skewness = skewness/ ((2047)*(sd^3));



