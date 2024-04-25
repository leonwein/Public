def main():
    s1 = "ABC"
    s2 = "CBA"
    are_reverses(s1,s2)



def are_reverses(string_1, string_2):
    for i in range(len(string_1)):
        if(string_1[i] != string_2[len(string_1)-1-i]):
            return False
            
    return True
    
    
if __name__ == "__main__":
    main()