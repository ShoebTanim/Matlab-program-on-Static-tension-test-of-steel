function [Ulstrength,percentAreaRed,percentelongation,Elasticity,modulus,...
    Proportional_limit]=Mild_steel(F,y,calibration,reduceddia,Initialdia,gagelength,extensoconstant)
%Ulstrength=Ultimate strength of mild steel
%percentAreaRed=percentage of area reduced after breaking
%Elasticity=modulus of elasticity of used mild steeel
%modulus=contains modulus of resilience,modulus of toughness
%proportional limit=proportional limit of steel using .005% strain
%All calculations are done in fps unit
%F=Observed Load
%y=elongation(inch)
%calibration=calibration equation
%reduceddia=reduced diameter after breaking
%initialdia=initial diameter of specimen

if nargin<4,error('at least 4 input arguments required'),end
if length(F)~=length(y), error('Stress and deformation value size do not match'),end

%calculating calibrated load
Ftrue=calibration(F);

if nargin<5||isempty(gagelength), gagelength=2;end
if nargin<6|isempty(Initialdia), Initialdia=0.5;end
if nargin<7||isempty(extensoconstant), extensoconstant=0.0001;end
Area=(pi/4)*Initialdia.^2;
 
%Determining True stress
%making intial force 0 which may come negative due to calibration

Fstress=Ftrue./Area;
if Fstress(1)<0
    Fstress(1)=0;
end

%Rounding
p=1;
for p=1:length(Fstress)
    if Fstress(p)<50000
        Fstress(p)= round(Fstress(p)/100)*100;
    else Fstress(p)>50000;
         Fstress(p)= round(Fstress(p)/500)*500;
    end
end

%converting extensometer reading into elongation
if y(3)>1
    y(1:end)=y(1:end)*extensoconstant;
end

    
%True strain
%making strain 0 for no load
ystrain=y./gagelength ;
if ystrain(1)<0
    ystrain(1)=0;
end

%Determining Elasticity&

%ploting stress strain curve upto elastic limit
%here 42000 is estimated value of yield

k=Fstress<42000;
%location of stress values less than 4200

Fyield=Fstress(k);
l=length(Fyield);
yyield=ystrain(1:l);

Elasticity= sum(Fyield)*sum(yyield)/(sum(yyield))^2;

m=Elasticity*((.005/100)+yyield);
Proportional_limit=m(end);

correctedF=yyield.*Elasticity;


subplot(1,2,1)
plot(yyield,Fyield,'r-',yyield,correctedF,'b--')
grid on;
xlabel('Strain-in/in');
ylabel('Stress(psi)');
legend('True stress strain','Best fit')
title('Stress vs Strain Diagram for mild steel upto elastic limit');



%Modulus of resilience
%By integrating area under elastic region
modulus(1)=.5*yyield(end)*correctedF(end);
%Modulus of toughness
%by integrating full area of stress strain curve
modulus(2)=trapz(ystrain,Fstress);

%Full stress strain diagram
subplot(1,2,2)
plot(ystrain,Fstress,'-')
grid on; 
xlabel('Strain-''in/in''');
ylabel('Stress(psi)');
title('Stress vs Strain Diagram for mild steel');


print('Ultimate strength of mild steel=');
Ulstrength=max(Fstress);

%percent elongation=ystrain(final)*100

percentelongation=ystrain(end)*100;
 
%percentage of area reduced
AreaRed=(pi/4)*reduceddia^2;
percentAreaRed=((Area-AreaRed)/Area)*100;
Fstress
ystrain




%y=[0 5e-4 11e-4 16e-4 21e-4 26e-4 32e-4 37e-4 42e-4 47e-4 55e-4 85e-4 900e-4 .1 .11 .12 .15 .16 .21 .24 .35 .56 .61 .68];
%x=[0 1000 2000 3000 4000 5000 6000 7000 8000 9000 9500 9300 10000 11000 12000 13000 14000 15000 16000 17000 17750 17000 16000 14000];
%[f,c,v]=Mild_strrl(y,x,@(x) .9938*x-193.6688)