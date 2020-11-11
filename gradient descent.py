#gradient descent for linear regression

#input training examples
x=[1,2,2,3,3,4,5,6,6,6,8,10]
y=[-890,-1411,-1560,-2220,-2091,-2878,-3537,-3268,-3920,-4163,-5471,-5157]

#guess
temp0=0
temp1=0

#number of observations
m=len(x)

#intialize hypothesis function
h=[0]*m

#set learning rate
alpha=0.06

#set tolerance and initialize error
tol=0.001
error0=10
error1=10

#main loop for gradient descent
while error0>tol or error1>tol:

    sum1=0
    sum2=0

    for i in range(m):
        h[i]=temp0+temp1*(x[i])
        sum1_i=h[i]-y[i]
        sum2_i=(h[i]-y[i])*x[i]
        sum1=sum1+sum1_i
        sum2=sum2+sum2_i

    theta0=temp0-(alpha*(1/m)*sum1)
    theta1=temp1-(alpha*(1/m)*sum2)

    error0=abs(theta0-temp0)
    error1=abs(theta1-temp1)

    temp0=theta0
    temp1=theta1

#print final values
print('The value of theta0 is: ',theta0)
print('The value of theta1 is: ',theta1)
print('The error for theta0 is: ',error0)
print('The error for theta1 is: ',error1)
