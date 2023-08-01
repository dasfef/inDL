﻿using System;

public class Solution{
    public static void Main(){
        int[] numbers = new int[7] {0,1,2,3,4,5,6};

        var numQuery = 
            from num in numbers
            where (num % 2) == 0
            select num;
        
        foreach(int num in numQuery){
            Console.WriteLine("{0,1} ", num);
        }
    }
}