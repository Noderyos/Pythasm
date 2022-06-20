int le_sqrt(int a) {
    int n=1;
    int number = a;
    for (int i=0; i<100; i++) {
        n=(n+number/n)/2;  
    }
    return n; 
}