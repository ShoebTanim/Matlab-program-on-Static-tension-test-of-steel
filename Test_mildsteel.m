clear;
clc;
disp('Static Tension Test of Mild Steel Specimen Using Matlab ')
disp('This is a project by Section-C Group-7 Students.')
disp('All units are taken in FPS/matric unit')

    [str]=xlsread("Stress1.xlsx");
    
    F=str(:,1);
    y=str(:,2);


Initialdia=double(input('Specimen Diameter(inch):'));
reduceddia=double(input('Diameter After Breaking(inch):'));
gagelength=double(input('Gage Length(inch):'));
extensoconstant=double(input(' Extensometer Constant (inch):'));


 [Ulstrength,percentAreaRed,percentelongation,Elasticity,modulus,Proportional_limit]=Mild_steel(F,y,@calibration,reduceddia,Initialdia,gagelength,extensoconstant);
fprintf('The Ultimate strength of mild steel is=%.4f \n',Ulstrength);
fprintf('The percentage of area reduced after breaking is=%.4f \n',percentAreaRed);
fprintf('The modulus of elasticity of used mild steel=%.4f \n',Elasticity);
fprintf('The contains modulus of resilience=%.4f \n',modulus(1));
fprintf('The contains modulus of toughness=%.4f \n',modulus(2));
fprintf('Proportional limit of steel =%.4f \n',Proportional_limit);

disp('Converted results in SI unit ')
 

Ulstrength_1= Ulstrength /145.038;
Elasticity_1=Elasticity/145.038;
modulus_1(1)=modulus(1)/145.038;
modulus_2(2)=modulus(2)/145.038;
Proportional_limit_1=Proportional_limit/145.038;

fprintf('The Ultimate strength of mild steel is (Mpa)=%.4f \n',Ulstrength_1);
fprintf('The percentage of area reduced  after breaking is=%.4f \n',percentAreaRed')
fprintf('The modulus of elasticity of used mild steel (Mpa)=%.4f \n',Elasticity_1);
fprintf('The contains modulus of resilience(Mpa)=%.4f \n',modulus_1(1));
fprintf('The contains modulus of toughness(Mpa)=%.4f \n',modulus_2(2));
fprintf('Proportional limit of steel(Mpa) =%.4f \n',Proportional_limit_1);
fprintf('Percentage Elongation=%.4f \n',percentelongation);




