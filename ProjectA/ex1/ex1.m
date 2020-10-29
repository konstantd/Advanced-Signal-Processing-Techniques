newline=sprintf('\n'); 
disp(newline)
disp('Press any key to start with the 1st question.')
disp(newline)
pause;
   
disp(newline)
disp('#Question 1.1')
disp(newline)
ex_1question_1
plot(x)  %Μπαίνει εδώ για το τελευταίο ερώτημα
title('x[k]')
disp('Χ[k] is plotted')
disp(newline)
disp('Press any key to continue to the next question.')
disp(newline)
pause;


disp('#Question 1.2')
disp(newline)
disp('Power Spectrum is plotted.')
disp(newline)
ex_1question_2
plot(fr,abs(C2))    %Μπαίνει εδώ για το τελευταίο ερώτημα
title('Power Spectrum')   
xlabel('f')
ylabel('Magnitude')
disp('Press any key to continue to the next question.')
disp(newline)
pause;



disp('#Question 1.3')
disp(newline)
print3(x,32,256)
disp('Bispectrum with different methods are plotted')
disp(newline)
disp('Press any key to plot with different segmentation (K=12, M=512).')
disp(newline)
pause;


disp('#Question 1.7ai')
close all
disp(newline)
print3(x,12,512)
disp('Bispectrum with different methods are plotted')
disp(newline)
disp('Press any key to plot with different segmentation (K=64, M=128).')
disp(newline)
pause;


disp('#Question 1.7aii')
close all
disp(newline)
print3(x,64,128)
disp('Bispectrum with different methods are plotted')
disp(newline)
disp('Press any key to continue to the last question.')
disp(newline)
pause;



disp('#Question 1.7b')
disp(newline)
ex_1question_7b
disp('The mean Power Spectrum and Bispectrum are appeared')
disp(newline)
disp('End of exercise 2. Press any key.')
disp(newline)
pause;


