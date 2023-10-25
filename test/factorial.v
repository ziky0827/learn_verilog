//阶乘运算
module factorial(a,b);
    input a;
    output b;
    

    function automatic [31:0] fac;
    input [15:0] n;
    if (n == 1) fac = 1;
    else fac = n * fac(n-1); 
    endfunction
    
    assign b = fac(a);

endmodule