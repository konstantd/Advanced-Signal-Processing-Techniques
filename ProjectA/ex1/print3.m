%prints 3 methods of Bispectrum with K,M

function print3(x,K,M)


C3ind_opt = indirect_method_beltisto(x,K,M);
%plot
f1=[-0.5:0.02:0.5];
f2=[-0.5:0.02:0.5];
contour(f1,f2, abs(C3ind_opt))
str=sprintf('Bispectrum Indirect Method Optimal window, K=%d, M=%d',K, M);
title(str)
xlabel('f1')
ylabel('f2')
colorbar



C3ind_par =indirect_method_parzen(x,K,M);

figure
f1=[-0.5:0.02:0.5];
f2=[-0.5:0.02:0.5];
contour(f1,f2,abs(C3ind_par))
str=sprintf('Bispectrum Indirect Method Parzen window, K=%d, M=%d',K, M);
title(str)
xlabel('f1')
ylabel('f2')
colorbar



C3dir = direct_method(x,K,M);

figure
f1=linspace(-0.5,0.5,M/2+1);
f2=linspace(-0.5,0.5,M/2+1);
contour(f1,f2,abs(C3dir))
str=sprintf('Bispectrum Direct Method, K=%d, M=%d',K, M);
title(str)
xlabel('f1')
ylabel('f2')
colorbar

end