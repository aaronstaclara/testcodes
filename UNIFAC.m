
function gamma_UNIFAC(components,subgroups,x,T,D,a_mn)

%input:
%x - row vector containing mole fraction of the components
%T - temperature in K
%D - array containing the parameters for each functional group in the mixture 
%wherein the structure is [main_group_number subgroup_number R_k Q_k v_k_1 v_k_2 … v_k_n]
%a_mn – matrix of interaction parameters for all pairs of subgroups

%output:
%gamma_i – row vector containing activity coefficient of each species


disp('UNIFAC');
disp('The user should input the array containing parameters for each functional group ');
disp('in this order: [main_group_number subgroup_number R_k Q_k v_k_1 v_k_2 ... v_k_n].');

components=input('Input number of components: '); 
subgroups=input('Input number of functional groups: ');
x=input('Input row vector of mole fraction of components: '); %[x1 x2 ... xn];
T=input('Temperature (K): '); %in K
D=input('Array containing parameters for each functional group: '); %structure: [m k Rk Qk v1 v2 ... vn]
a_mn=input('Matrix of interaction parameters for all pairs of subgroups: '); %input array of a_mn parameters 

k=subgroups;

r=[];
q=[];

for i=1:length(x)
    
    r(i)=0;
    q(i)=0;
    
    for j=1:k
        
        r(i)=r(i)+D(j,4+i)*D(j,3);
        q(i)=q(i)+D(j,4+i)*D(j,4);
        
    end
end

phi=[];
theta=[];
I=[];
z=10;

for i=1:length(x)
    
    phi(i)=(r(i)*x(i))/sum(r.*x);
    theta(i)=(q(i)*x(i))/sum(q.*x);
    I(i)=((z/2)*(r(i)-q(i)))-(r(i)-1);
    
end

lngamma_c=[];

for i=1:length(x)
    
    lngamma_c(i)=log(phi(i)/x(i))+(z/2)*q(i)*log(theta(i)/phi(i))+I(i)-(phi(i)/x(i))*sum(x.*I);
    
end

psi_mn=exp(-a_mn/T);

x_k=[];
theta_k=[];

for i=1:length(x)
    
    for j=1:k
        
    x_k(j,i)=D(j,4+i)/sum(D(:,4+i));
    
    end
end

for i=1:length(x)
    
    for j=1:k
        
        theta_k(j,i)=(D(j,4)*x_k(j,i))/sum(D(:,4).*x_k(:,i));
    end
end

lngamma_ki1=[];
lngamma_ki2=[];
lngamma_ki3=[];
lngamma_ki=[];

for i=1:length(x)
    
    for j=1:k
        
        lngamma_ki1(j,i)=D(j,4);
        lngamma_ki2(j,i)=-D(j,4)*log(sum(theta_k(:,i).*psi_mn(:,j)));
        S2=0;
        
        for m=1:k
            S1=0;
            
            for n=1:k
                
                S1=S1+theta_k(n,i)*psi_mn(n,m);
                
            end
            
            S2=S2+(theta_k(m,i)*psi_mn(j,m))/S1;
            
        end
        
        lngamma_ki3(j,i)=-D(j,4)*(S2);
        lngamma_ki(j,i)=lngamma_ki1(j,i)+lngamma_ki2(j,i)+lngamma_ki3(j,i);
    
    end
end

x_k1=[];
x_k1num=[];
x_k1den=[];

for j=1:k
    
    x_k1num(j)=0;
    
    for i=1:length(x)
        
        x_k1num(j)=x_k1num(j)+(D(j,4+i).*x(i));
        
    end
end

for m=1:k
    
    x_k1den(m)=0;
    
    for j=1:k
        
        for i=1:length(x)
            
            x_k1den(m)=x_k1den(m)+D(j,i+4).*x(i);
            
        end
    end
end

x_k1=x_k1num./x_k1den;

theta_k1=[];

for j=1:k
    
    theta_k1(j)=D(j,4)*x_k1(j)/sum(D(:,4).*x_k1');
    
end

            
lngamma_k1=[];
lngamma_k2=[];
lngamma_k3=[];
lngamma_k=[];

for j=1:k
        
    lngamma_k1(j)=D(j,4);
    lngamma_k2(j)=-D(j,4).*log(sum(theta_k1'.*psi_mn(:,j)));
    S2=0;
    
        for m=1:k
            
            S1=0;
            
            for n=1:k
                
                S1=S1+theta_k1(n)*psi_mn(n,m);
                
            end
            
            S2=S2+(theta_k1(m)*psi_mn(j,m))/S1;
        end
        
    lngamma_k3(j)=-D(j,4)*(S2);
    lngamma_k(j)=lngamma_k1(j)+lngamma_k2(j)+lngamma_k3(j);
    
end

lngamma_r=[];

for i=1:length(x)
    
    lngamma_r(i)=sum(D(:,4+i).*(lngamma_k'-lngamma_ki(:,i)));
    
end

lngamma=lngamma_c+lngamma_r;
format long
gamma=exp(lngamma);
gamma_i=gamma
lngamma_c
lngamma_r

end


    
    
