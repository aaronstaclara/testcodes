#this code will check if the input code is a palindrome

print('This is a palindrome checker!')
print('')
txt=input('Input word to check: ')

def palindrome_check(txt):
    i=0
    j=len(txt)-1
    counter=0
    n=int(len(txt)/2)

    for iter in range(1,n+1):
        if txt[i]==txt[j]:
            counter=counter+1
        i=i+iter
        j=j-iter

    if counter==n:
        disp="Yes! It is a palindrome!"
    else:
        disp='No! It is not a palindrome!'

    return print(disp)

palindrome_check(txt)
