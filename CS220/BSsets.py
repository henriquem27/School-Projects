
import sys

''' provided
    strings are immutable, but lists are mutable 
    replace(s,i,c) turns string s into a list, replaces s[i] with c,
    then turns the list back into a string and returns it
'''
def replace(s,i,c):
    s=list(s)
    s[i]=c
    s = ''.join(s)
    return s

'''
    return a string with n c-s
    eg. string(5,"0") returns '000000'
'''
def stringn(n,c):
    c=str(c)    
    return n*c

    '''
  given bit string bs of size n, 
  return the next (boolean increment)
  e.g.  '00000' -> '00001'
        '01011' -> '01100'
        '11111' -> '00000' 
    '''
def next(bs,n):
    return '{:0{}b}'.format(int(bs, 2) + 1, n)[-n:]


    '''
    return the set of all length n>=2 bitstrings 
    that start with '11' or end with '1'
  
    '''
def Union(lst1, lst2): 
    final_list = list(set(lst1) | set(lst2)) 
    return final_list

def s11x1(n):
    l=[]
    
    x=stringn(n,0)
    l.append(x)
    i=1
    while i<(2**n):
        x=next(x,n)
        l.append(x)
        i=i+1
        
    start='11'
    ends='1'
    res = [x for x in l if x.startswith(start)]
    res1 = [x for x in l if x.endswith(ends)] 
    
    
    return set(Union(res,res1))  


    '''
   return the set of all length n>=2 bitstrings 
   that start with '11'
    '''
def s11x(n):
    l=[]
    
    x=stringn(n,0)
    l.append(x)
    i=1
    while i<(2**n):
        x=next(x,n)
        l.append(x)
        i=i+1
        
    subs='11'
    
    res = [x for x in l if x.startswith(subs)] 

    
    return set(res)


    '''
   return the set of all length n>=2 bitstrings 
   that end with '1'
    '''
def sx1(n):
    l=[]
    
    x=stringn(n,0)
    l.append(x)
    i=1
    while i<(2**n):
        x=next(x,n)
        l.append(x)
        i=i+1
        
    start='11'
    ends='1'
    
    res1 = [x for x in l if x.endswith(ends)] 
    
    
    return set(res1)  


    ''' provided '''
if __name__ == "__main__":
  # sets of bit strings size n
  n = int(20)
  if n<2:
    print( 'argument must be >= 2' )
    sys.exit()
  s3 = s11x1(n)
  print( 'len(s3) =', len(s3) )
  s2 = s11x(n)
  print( 'len(s2) =', len(s2) )
  s1 = sx1(n)
  print( 'len(s1) =', len(s1) )
  print( 'len(s1&s2):', len(s1&s2) )
  print( 's3 == s2|s1:', s3 == s2|s1 )
  print( 'len(s3) == len(s2)+len(s1)-len(s2&s1):',
          len(s3) == len(s2)+len(s1)-len(s2&s1) )

print(len(s3))
